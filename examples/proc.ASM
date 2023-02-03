%TITLE "Ваш комментарий программы"
INCLUDE IO.ASM

MODEL	small

ST1 SEGMENT             ;Описали сегмент стека;
	DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT

DATA ENDS

CODE SEGMENT            ;открыли сегмент кода;
ASSUME SS:ST1,DS:DATA,CS:CODE    ;связали регистровые сегменты с сегментами;

my_p proc
	regs EQU 4
	arg0 EQU 2+regs
	push bp
	push bx
	mov bp,sp
	mov bx,[bp+arg0]
	add bx,5
	mov ax,bx
	pop bx
	pop bp
	ret 2
my_p endp

max proc
	regs EQU 4
	arg_y EQU 2+regs
	arg_x EQU 4+regs
	push bp
	push bx
	mov bp,sp
	
	mov bx,[bp+arg_x]
	mov ax,[bp+arg_y]
	cmp bx,ax
	jg MX
	jmp MXE
MX:	mov ax,[bp+arg_x]
MXE:
	pop bx
	pop bp
	ret 4
max endp

Start:
	push	ds
	push	ax
	mov	ax, data	
	mov	ds, ax
;========== Ниже пишите Ваш код ==============================
	inint	ax
	inint	bx
	push ax
	call my_p
	push ax
	push bx
	call max
	outint 	ax
;========== Заканчивайте писать Ваш код======================
	pop	ax
	pop	ds
Exit:
	finish
ENDS

END	Start