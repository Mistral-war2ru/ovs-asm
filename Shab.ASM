%TITLE "��� �������਩ �ணࠬ��"
MODEL	small

ST1 SEGMENT             ;���ᠫ� ᥣ���� �⥪�;
	DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT

DATA ENDS


CODE SEGMENT            ;���뫨 ᥣ���� ����;
ASSUME SS:ST1,DS:DATA,CS:CODE    ;�易�� ॣ���஢� ᥣ����� � ᥣ���⠬�;

Start:
	push	ds
	push	ax
	mov	ax, data	
	mov	ds, ax
;========== ���� ���� ��� ��� ==============================
	xor ax,ax
	xor bx,bx;��頥� ॣ�����
	xor dx,dx
	mov ah, 01h
	int 21h;������ ��ࢮ� �᫮
	cmp al,30h
	jl Z1;����� 0
	cmp al,3ah
	jg Z1;����� 9
	jmp OK1
Z1:	mov al,30h;��⠢�塞 0 �� �訡��
OK1:sub al,30h;���⠥� ��� ᨬ���� 0
	mov bl,al;��࠭塞
	mov ah,02h
	mov dl,0ah;���室 �� ᫥������ ��ப�
	int 21h
	mov ah,01h
	int 21h;������ ��஥ �᫮
	cmp al,30h
	jl Z2;����� 0
	cmp al,3ah
	jg Z2;����� 9
	jmp OK2
Z2:	mov al,30h;��⠢�塞 0 �� �訡��
OK2:sub al,30h;���⠥� ��� ᨬ���� 0
	add bl,al;᫮�����
	mov ah,02h
	mov dl,0ah;���室 �� ᫥������ ��ப�
	int 21h
	mov dl,bl;��ࠢ�塞 �� �뢮�
	cmp dl,0ah;�஢�ઠ ࠧ��� �᫠
	jl GO
	mov dl,31h;�뢮��� ����⮪
	int 21h
	mov dl,bl
	sub dl,0ah;
GO:	add dl,30h;������塞 ��� ᨬ���� 0
	int 21h;�뢮� �⢥�
;========== �����稢��� ����� ��� ���======================
	pop	ax
	pop	ds
Exit:
	mov	AX,4C00h;ᨣ��� �����襭�� ࠡ���
	int	21h
ENDS

END	Start