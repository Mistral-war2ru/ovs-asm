%TITLE "��� �������਩ �ணࠬ��"
MODEL	small

ST1 SEGMENT             ;���ᠫ� ᥣ���� �⥪�;
	DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
x dw ?
y dw ?
ten db 10h
DATA ENDS


CODE SEGMENT            ;���뫨 ᥣ���� ����;
ASSUME SS:ST1,DS:DATA,CS:CODE    ;�易�� ॣ���஢� ᥣ����� � ᥣ���⠬�;

Start:
	push	ds
	push	ax
	mov	ax, data	
	mov	ds, ax
;========== ���� ���� ��� ��� ==============================
	mov ax,4F02h;set draw mode
	mov bx,105h;1024x768 draw mode
	int 10h;draw mode enable
	
	mov ah,0Ch;draw pixel command
	mov al,09h;color
	
	mov y,100h
L2:	cmp y,200h
	jge E2
	mov x,100h
L:	cmp x,200h
	jge E

	mov cx,220h;x coord
	mov dx,200h;y coord
	int 10h;draw

	inc x
	jmp L
E:	inc y
	jmp L2
E2:
	xor ax,ax
	int 16h;wait for key
	
	mov ax,0003h
	int 10h;restore text mode
;========== �����稢��� ����� ��� ���======================
	pop	ax
	pop	ds
Exit:
	mov	AX,4C00h;ᨣ��� �����襭�� ࠡ���
	int	21h
ENDS

END	Start