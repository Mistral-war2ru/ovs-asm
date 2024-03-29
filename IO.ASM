.xlist
;--------------------------------------
;  �����襭�� ࠡ��� �ணࠬ��
;--------------------------------------
finish	MACRO

	MOV	AX,4C00h
	INT	21h

	ENDM
;--------------------------------------
;  ���室 �� ����� ��ப�
;--------------------------------------
	EXTRN	_newline:FAR

newline	MACRO

	CALL	_newline

	ENDM
;--------------------------------------
;  �뢮� ᨬ����
;	���饭��: outch c
;    c - i8, r8, m8
;--------------------------------------
outch	MACRO	c

	PUSH	DX
	PUSH	AX
	MOV	DL,c
	MOV	AH,2
	INT	21h
	POP	AX
	POP	DX

	ENDM
;--------------------------------------
;  �뢮� ��ப� ᨬ�����
;    In:  ds:dx - ��砫�� ���� ��ப�
;  ����砭��: ��ப� ������ �����稢�����
;    ᨬ����� '$'.
;--------------------------------------
outstr	MACRO

	PUSH	AX
	MOV	AH,09h
	INT	21h
	POP	AX

	ENDM
;--------------------------------------
;  �뢮� 楫��� � ������ ࠧ��஬ � ᫮��
;	���饭��:  outint num [,leng]
;         num  - �뢮����� �᫮ i16, r16, m16
;	  leng - �ਭ� ���� �뢮�� i8, r8, m8
;  ����砭��:
;    �᫨ ���� �����, 祬 ����, � ᫥��
;    ����������� �஡���,
;    �᫨ ����� - �뢮����� ⮫쪮 �᫮ (���������)
;    leng=0 �� 㬮�砭��
;--------------------------------------
	EXTRN	_outint:FAR
	
outint	MACRO	num,leng

	outnum	<num>,<leng>,1

	ENDM
;--------------------------------------
;  �뢮� 楫��� ��� ����� ࠧ��஬ � ᫮��
;	���饭��: outword num [,leng]
;--------------------------------------
outword	MACRO	num,leng

	outnum	<num>,<leng>,0
	
	ENDM
;--------------------------------------
; �ᯮ����⥫�� ����� �஢�ન
; ����ᠭ�� ����� ࠧ�묨 (����訬�
; � ���묨) �㪢���
;--------------------------------------
same	MACRO	name,variants,ans

	ans=0
	IRP	v,<variants>
	IFIDN	<name>,<v>
	ans=1
	EXITM
	ENDIF
	ENDM

	ENDM
;--------------------------------------
; �ᯮ����⥫�� ����� ��� outint � outword
;--------------------------------------
outnum	MACRO	num,leng,sign

	LOCAL	regdx?
	PUSH	AX
	PUSH	DX
	same	<num>,<dx,DX,Dx,dX>,regdx?
	IF	regdx?
		IFB	<leng>
			MOV	AL,0
		ELSE
			MOV	AL,leng
		ENDIF
		XCHG	AX,DX
	ELSE
		IFB	<leng>
			MOV	DL,0
		ELSE
			MOV	DL,leng
		ENDIF
		MOV	AX,num
	ENDIF
	MOV	DH,sign
	CALL	_outint
	POP	DX
	POP	AX
	
	ENDM
;--------------------------------------
;  ���⪠ ���� ����� � ����������
;--------------------------------------
	EXTRN	_flush:FAR
	
flush	MACRO

	CALL	_flush
	
	ENDM
;--------------------------------------
; ���� ᨬ���� (��� Enter)
;	���饭��: inch x
;   x - r8, m8
; Out: x - �������� ᨬ���
;--------------------------------------
	EXTRN	_inch:FAR

inch	MACRO	x

	LOCAL	regax?
	same	<x>,<ah,AH,Ah,aH>,regax?
	IF	regax?
		XCHG	AH,AL
		MOV	AL,0
		CALL	_inch
		XCHG	AH,AL
	ELSE
		same	<x>,<al,AL,Al,aL>,regax?
		IF	regax?
			MOV	AL,0
			CALL	_inch
		ELSE
			PUSH	AX
			MOV	AL,0
			CALL	_inch
			MOV	x,AL
			POP	AX
		ENDIF
	ENDIF

	ENDM
	
;--------------------------------------
;  ���� 楫��� �᫠ ࠧ��஬ � ᫮��
;	���饭��: inint x
;    x - r16, m16
;  Out: x - ��������� �᫮
;  ����砭��:
;    �ய�᪠���� �� �஡��� � �����
;    ��ப ��। �᫮�;
;    �᫮ ������ ��稭����� � ���� ���
;    �����;
;    ���� ���� �� ��ࢮ� ������(� �.�. �� Enter);
;    �� �訡�� �ணࠬ�� �����蠥��� �
;    ���਩�� ᮮ�饭���.
;--------------------------------------
	EXTRN	_inint:FAR
	
inint	MACRO	x
	
	LOCAL	regax?
	same	<x>,<ax,AX,Ax,aX>,regax?
	IF	regax?
	CALL	_inint
	ELSE
	PUSH	AX
	CALL	_inint
	MOV	x,AX
	POP	AX
	ENDIF
	
	ENDM
;--------------------------------------
.list