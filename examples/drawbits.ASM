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
	mov al,0
	mov y,0
L2:	cmp y,300h
	jnge G
	jmp far ptr E2;far jmp
G:
	mov x,0
L:	cmp x,400h
	jnge G2
	jmp far ptr E;far jmp
G2:	
	cmp y,100h
	jl F1
	cmp x,100h
	jl F4
	cmp y,200h
	jl F2
	cmp x,200h
	jg F3
	mov dx,x
	add dx,y
	mov al,dl
	jmp short DRW
F4: mov dx,y
	and dx,x
	xor al,dl
	jmp short DRW
F3: mov dx,y
	rol dx,1
	xor dx,y
	ror dx,1
	add dx,x
	xor al,dl
	jmp short DRW
F2:	mov dx,y
	ror dx,1
	sub dx,x
	rol dx,1
	rol dx,1
	rol dx,1
	xor al,dh
	jmp short DRW
F1:	mov dx,x
	cmp x,100h
	jg F5
	xor dh,dl
	rol dx,1
	rol dx,1
	add al,dh
	jmp short DRW
F5:
	and dx,y
	xor al,dl
DRW:	;color stored in al
	mov cx,x;x coord
	mov dx,y;y coord
	int 10h;draw
DRW2:
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