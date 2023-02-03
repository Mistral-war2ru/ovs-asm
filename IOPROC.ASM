public  _newline,_outint,_flush,_inch,_inint

CODE_SEG        SEGMENT BYTE
        ASSUME  CS:CODE_SEG
;--------------------------------------
_newline        PROC    FAR
        PUSH    AX
        PUSH    DX
        MOV     AH,2
        MOV     DL,13
        INT     21h
        MOV     DL,10
        INT     21h
        POP     DX
        POP     AX
        RET
_newline        ENDP
;--------------------------------------
_outint PROC    FAR
        PUSH    BP
        MOV     BP,SP
        PUSH    AX
        PUSH    CX
        PUSH    DX
        PUSH    SI
        SUB     SP,6
        CMP     DH,1
        JNE     Without_Sign
        CMP     AX,0
        JGE     Without_Sign
        MOV     DH,2
        NEG     AX
Without_Sign:
        PUSH    DX
        XOR     SI,SI
        MOV     CX,10
Next_Digit_Loop:
        XOR     DX,DX
        DIV     CX
        ADD     DL,'0'
        MOV     [BP-14+SI],DL
        INC     SI
        OR      AX,AX
        JNZ     Next_Digit_Loop
        POP     DX
        CMP     DH,2
        JNE     Is_Positive
        MOV     byte ptr [BP-14+SI],'-'
        INC     SI
Is_Positive:
        MOV     CL,DL
        MOV     CH,0
        MOV     AH,2
Print_Next_Space:
        CMP     CX,SI
        JLE     Print_Number_Loop
        MOV     DL,' '
        INT     21h
        DEC     CX
        JMP     Print_Next_Space
Print_Number_Loop:
        DEC     SI
        MOV     DL,[BP-14+SI]
        INT     21h
        OR      SI,SI
        JNZ     Print_Number_Loop
        ADD     SP,6
        POP     SI
        POP     DX
        POP     CX
        POP     AX
        POP     BP
        RET
_outint ENDP
;--------------------------------------
maxb    DB      128
sizeb   DB      0
buf     DB      128 dup(?)
posb    DB      0
;--------------------------------------
ReadBuf PROC    NEAR
        PUSH    AX
        PUSH    DX
        PUSH    DS
        MOV     DX,CS
        MOV     DS,DX
        LEA     DX,buf-2
        MOV     AH,0Ah
        INT     21h
        CALL    _newline
        INC     CS:sizeb
        MOV     CS:posb,0
        POP     DS
        POP     DX
        POP     AX
        RET
ReadBuf ENDP
;--------------------------------------
_flush  PROC    FAR
        PUSH    AX
        MOV     CS:sizeb,0
        MOV     CS:posb,0
        MOV     AH,0Ch
        MOV     AL,0
        INT     21h
        POP     AX
        RET
_flush  ENDP
;--------------------------------------
_inch   PROC    FAR
        PUSH    BX
Read_Next_Char:
        MOV     BL,CS:posb
        INC     BL
        CMP     BL,CS:sizeb
        JB      Read_Char_From_Buffer
        JNE     Read_New_String
        CMP     AL,0
        JNE     Read_Char_From_Buffer
Read_New_String:
        CALL    ReadBuf
        JMP     Read_Next_Char
Read_Char_From_Buffer:
        MOV     CS:posb,BL
        MOV     BH,0
        MOV     AL,CS:buf[BX-1]
        POP     BX
        RET
_inch   ENDP
;--------------------------------------
_inint  PROC    FAR
        PUSH    BX
        PUSH    CX
        PUSH    DX
Through_Spaces:
        MOV     AL,0
        CALL    _inch
        CMP     AL,' '
        JE      Through_Spaces
        XOR     BX,BX
        MOV     CX,BX
        MOV     DX,BX
        CMP     AL,'+'
        JE      Read_Next_Digit
        CMP     AL,'-'
        JNE     Not_A_Sign
        INC     CX
Read_Next_Digit:
        MOV     AL,1
        CALL    _inch
Not_A_Sign:
        CMP     AL,'9'
        JA      Not_Digit
        SUB     AL,'0'
        JB      Not_Digit
        MOV     AH,0
        XCHG    AX,BX
        MOV     DX,10
        MUL     DX
        JC      Overflow
        ADD     BX,AX
        JC      Overflow
        JMP     Read_Next_Digit
Not_Digit:
        MOV     AX,BX
        OR      DX,DX
        JNZ     Input_Error
        OR      CX,CX
        JZ      Positive_Number
        CMP     AX,8000h
        JA      Overflow
        NEG     AX
Positive_Number:
        POP     DX
        POP     CX
        POP     BX
        RET

Overflow:
        LEA     CX,Err_Overflow
        JMP     Print_Error_Message
Input_Error:
        LEA     CX,Err_NoDigit
Print_Error_Message:
        MOV     AX,CS
        MOV     DS,AX
        LEA     DX,Err_Msg
        MOV     AH,09h
        INT     21h
        MOV     DX,CX
        MOV     AH,09h
        INT     21h
        CALL    _newline
        MOV     AH,4Ch
        INT     21h

Err_Msg         DB      'Ошибка при вводе числа: ','$'
Err_Overflow    DB      'переполнение','$'
Err_NoDigit     DB      'нет цифры','$'

_inint  ENDP
;--------------------------------------
CODE_SEG        ENDS
        END
