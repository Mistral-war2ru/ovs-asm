%TITLE "Ваш комментарий программы"
MODEL	small

ST1 SEGMENT             ;Описали сегмент стека;
	DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
x dw ?
y dw ?
ten db 10h
DATA ENDS


CODE SEGMENT            ;открыли сегмент кода;
ASSUME SS:ST1,DS:DATA,CS:CODE    ;связали регистровые сегменты с сегментами;

Start:
	push	ds
	push	ax
	mov	ax, data	
	mov	ds, ax
;========== Ниже пишите Ваш код ==============================
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
;========== Заканчивайте писать Ваш код======================
	pop	ax
	pop	ds
Exit:
	mov	AX,4C00h;сигнал завершения работы
	int	21h
ENDS

END	Start