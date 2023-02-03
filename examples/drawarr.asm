%TITLE "Ваш комментарий программы"
MODEL    small
 
ST1 SEGMENT             ;Описали сегмент стека;
    DB 128 DUP(?)
ST1 ENDS
 
DATA SEGMENT
x dw ?
y dw ?
h dw ?
w dw ?
rx dw ?
i dw 0
j dw 0
k dw 0
m db 64 dup(09h)
DATA ENDS
 
CODE SEGMENT            ;открыли сегмент кода;
ASSUME SS:ST1,DS:DATA,CS:CODE    ;связали регистровые сегменты с сегментами;
 
print proc
    
    
    mov cx,h
L2:    cmp y,cx
    jge E2
    push si
    mov si,rx
    mov x,si
    pop si
    mov dx,w
L:    cmp x,dx
    jge E
    
    push cx
    push dx
 
    mov cx,x;x coord
    mov dx,y;y coord
    int 10h;draw
    
    pop dx
    pop cx
 
    inc x
    jmp L
E:    inc y
    jmp L2
E2:
ret
print endp
 
Start:
    push    ds
    push    ax
    mov    ax, data    
    mov    ds, ax
;========== Ниже пишите Ваш код ==============================
    mov ax,4F02h;set draw mode
    mov bx,105h;1024x768 draw mode
    int 10h;draw mode enable
    
    mov ah,0Ch;draw pixel command
   
   mov m[0],6
   mov m[1],4
   mov m[7],4
   mov m[8],7
   
   mov m[63],7
   
S2: cmp j,80h
    jge G2
	mov i,0
S:  cmp i,80h
    jge G
    
	push bx
	mov bx,k
    mov al,m[bx]
	pop bx
	
	push di
	mov di,j
    mov y,di
	add di,10h
	mov h,di
    mov di,i
    mov rx,di
	add di,10h
	mov w,di
	pop di
    call print
	
	inc k
 
    add i,10h
    jmp S
G:  add j,10h
    jmp S2
G2:

    
	
    xor ax,ax
    int 16h;wait for key
    
    mov ax,0003h
    int 10h;restore text mode
;========== Заканчивайте писать Ваш код======================
    pop    ax
    pop    ds
Exit:
    mov    AX,4C00h;сигнал завершения работы
    int    21h
ENDS
 
END    Start