%TITLE "Ваш комментарий программы"
MODEL	small

ST1 SEGMENT             ;Описали сегмент стека;
	DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
x dw ?
y dw ?
w dw ?
h dw ?
rx dw ?
ten db 10h
DATA ENDS


CODE SEGMENT            ;открыли сегмент кода;
ASSUME SS:ST1,DS:DATA,CS:CODE    ;связали регистровые сегменты с сегментами;

paint PROC

	mov cx,h
L23:cmp y,cx
	jge E23
	push si
	mov si,rx
	mov x,si
	pop si
	mov dx,w
L3:	cmp x,dx
	jge E3
	push cx
	push dx
	mov cx,x;x coord
	mov dx,y;y coord
	int 10h;draw
	pop dx
	pop cx
	inc x
	jmp L3
E3:	inc y
	jmp L23
E23:

ret
paint endp

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
	
	mov al,0D0h;color
	mov y,0h
	mov rx,0h
	mov h,10h
	mov w,80h
	call paint
	
	mov al,0D0h;color
	mov y,10h
	mov rx,0h
	mov h,20h
	mov w,80h
	call paint

	mov al,0D0h;color
	mov y,20h
	mov rx,0h
	mov h,30h
	mov w,10h
	call paint

	mov al,42h;color
	mov y,20h
	mov rx,10h
	mov h,30h
	mov w,70h
	call paint

	mov al,0D0h;color
	mov y,20h
	mov rx,70h
	mov h,30h
	mov w,80h
	call paint

	mov al,42h;color
	mov y,30h
	mov rx,0h
	mov h,40h
	mov w,80h
	call paint

	mov al,42h;color
	mov y,40h
	mov rx,0h
	mov h,50h
	mov w,10h
	call paint

	mov al,1Fh;color
	mov y,40h
	mov rx,10h
	mov h,50h
	mov w,20h
	call paint
	
	mov al,22h;color
	mov y,40h
	mov rx,20h
	mov h,50h
	mov w,30h
	call paint

	mov al,42h;color
	mov y,40h
	mov rx,30h
	mov h,50h
	mov w,50h
	call paint

	mov al,22h;color
	mov y,40h
	mov rx,50h
	mov h,50h
	mov w,60h
	call paint

	mov al,1Fh;color
	mov y,40h
	mov rx,60h
	mov h,50h
	mov w,70h
	call paint

	mov al,42h;color
	mov y,40h
	mov rx,70h
	mov h,50h
	mov w,80h
	call paint

	mov al,42h;color
	mov y,50h
	mov rx,0h
	mov h,60h
	mov w,30h
	call paint

	mov al,72h;color
	mov y,50h
	mov rx,30h
	mov h,60h
	mov w,50h
	call paint

	mov al,42h;color
	mov y,50h
	mov rx,50h
	mov h,60h
	mov w,80h
	call paint

	mov al,42h;color
	mov y,60h
	mov rx,0h
	mov h,70h	
	mov w,20h
	call paint

	mov al,0B9h;color
	mov y,60h
	mov rx,20h
	mov h,70h
	mov w,30h
	call paint

	mov al,87h;color
	mov y,60h
	mov rx,30h
	mov h,70h
	mov w,50h
	call paint

	mov al,0B9h;color
	mov y,60h
	mov rx,50h
	mov h,70h
	mov w,60h
	call paint

	mov al,42h;color
	mov y,60h
	mov rx,60h
	mov h,70h
	mov w,80h
	call paint

	mov al,42h;color
	mov y,70h
	mov rx,0h
	mov h,80h
	mov w,20h
	call paint

	mov al,0B9h;color
	mov y,70h
	mov rx,20h
	mov h,80h
	mov w,60h
	call paint

	mov al,42h;color
	mov y,70h
	mov rx,60h
	mov h,80h
	mov w,80h
	call paint

	mov al,0B7h;color
	mov y,0h
	mov rx,100h
	mov h,20h
	mov w,130h
	call paint

	mov al,19h;color
	mov y,0h
	mov rx,130h
	mov h,20h
	mov w,160h
	call paint

	mov al,19h;color
	mov y,0h
	mov rx,160h
	mov h,10h
	mov w,170h
	call paint

	mov al,0B7h;color
	mov y,0h
	mov rx,170h
	mov h,10h
	mov w,180h
	call paint

	mov al,0B7h;color
	mov y,10h
	mov rx,160h
	mov h,20h
	mov w,180h
	call paint

	mov al,1Ch;color
	mov y,20h
	mov rx,100h
	mov h,30h
	mov w,120h
	call paint 

	mov al,0B7h;color
	mov y,20h
	mov rx,120h
	mov h,30h
	mov w,130h
	call paint

	mov al,19h;color
	mov y,20h
	mov rx,130h
	mov h,30h
	mov w,150h
	call paint

	mov al,0B7h;color
	mov y,20h
	mov rx,150h
	mov h,30h
	mov w,160h
	call paint

	mov al,1Ch;color
	mov y,20h
	mov rx,160h
	mov h,30h
	mov w,180h
	call paint

	mov al,13h;color
	mov y,30h
	mov rx,100h
	mov h,40h
	mov w,110h
	call paint

	mov al,1Fh;color
	mov y,30h
	mov rx,110h
	mov h,40h
	mov w,120h
	call paint

	mov al,0B7h;color
	mov y,30h
	mov rx,120h
	mov h,40h
	mov w,130h
	call paint

	mov al,19h;color
	mov y,30h
	mov rx,130h
	mov h,40h
	mov w,140h
	call paint

	mov al,0B7h;color
	mov y,30h
	mov rx,140h
	mov h,40h
	mov w,160h
	call paint

	mov al,1Fh;color
	mov y,30h
	mov rx,160h
	mov h,40h
	mov w,170h
	call paint

	mov al,13h;color
	mov y,30h
	mov rx,170h
	mov h,40h
	mov w,180h
	call paint

	mov al,0B7h;color
	mov y,40h
	mov rx,100h
	mov h,50h
	mov w,180h
	call paint

	mov al,0B7h;color
	mov y,50h
	mov rx,100h
	mov h,60h
	mov w,120h
	call paint

	mov al,1Dh;color
	mov y,50h
	mov rx,120h
	mov h,60h
	mov w,160h
	call paint

	mov al,0B7h;color
	mov y,50h
	mov rx,160h
	mov h,60h
	mov w,180h
	call paint

	mov al,0B7h;color
	mov y,60h
	mov rx,100h
	mov h,80h
	mov w,110h
	call paint

	mov al,1Dh;color
	mov y,60h
	mov rx,110h
	mov h,80h
	mov w,120h
	call paint

	mov al,11h;color
	mov y,60h
	mov rx,120h
	mov h,70h
	mov w,130h
	call paint

	mov al,17h;color
	mov y,70h
	mov rx,120h
	mov h,80h
	mov w,130h
	call paint

	mov al,17h;color
	mov y,60h
	mov rx,130h
	mov h,70h
	mov w,150h
	call paint

	mov al,14h;color
	mov y,70h
	mov rx,130h
	mov h,80h
	mov w,150h
	call paint

	mov al,11h;color
	mov y,60h
	mov rx,150h
	mov h,70h
	mov w,160h
	call paint

	mov al,17h;color
	mov y,70h
	mov rx,150h
	mov h,80h
	mov w,160h
	call paint

	mov al,1Dh;color
	mov y,60h
	mov rx,160h
	mov h,80h
	mov w,170h
	call paint

	mov al,0B7h;color
	mov y,60h
	mov rx,170h
	mov h,80h
	mov w,180h
	call paint
	
	mov al,42h;color
	mov y,0h
	mov rx,200h
	mov h,30h
	mov w,280h
	call paint
	
	mov al,42h;color
	mov y,30h
	mov rx,200h
	mov h,50h
	mov w,210h
	call paint
	
	mov al,6Fh;color
	mov y,30h
	mov rx,210h
	mov h,40h
	mov w,270h
	call paint
	
	mov al,42h;color
	mov y,3h
	mov rx,270h
	mov h,50h
	mov w,280h
	call paint
	
	mov al,1Fh;color
	mov y,40h
	mov rx,210h
	mov h,50h
	mov w,220h
	call paint
	
	mov al,31h;color
	mov y,40h
	mov rx,220h
	mov h,50h
	mov w,230h
	call paint
	
	mov al,42h;color
	mov y,40h
	mov rx,230h
	mov h,50h
	mov w,250h
	call paint
	
	mov al,31h;color
	mov y,40h
	mov rx,250h
	mov h,50h
	mov w,260h
	call paint
	
	mov al,1Fh;color
	mov y,40h
	mov rx,260h
	mov h,50h
	mov w,270h
	call paint
	
	mov al,8Ah;color
	mov y,50h
	mov rx,200h
	mov h,80h
	mov w,210h
	call paint
	
	mov al,42h;color
	mov y,50h
	mov rx,210h
	mov h,80h
	mov w,220h
	call paint
	
	mov al,42h;color
	mov y,50h
	mov rx,220h
	mov h,60h
	mov w,230h
	call paint
	
	mov al,04h;color
	mov y,60h
	mov rx,220h
	mov h,70h
	mov w,230h
	call paint
	
	mov al,42h;color
	mov y,70h
	mov rx,220h
	mov h,80h
	mov w,230h
	call paint
	
	mov al,8Ah;color
	mov y,50h
	mov rx,230h
	mov h,80h
	mov w,250h
	call paint
	
	mov al,42h;color
	mov y,50h
	mov rx,250h
	mov h,80h
	mov w,260h
	call paint
	
	mov al,42h;color
	mov y,50h
	mov rx,250h
	mov h,60h
	mov w,260h
	call paint
	
	mov al,04h;color
	mov y,60h
	mov rx,250h
	mov h,70h
	mov w,260h
	call paint
	
	mov al,42h;color
	mov y,70h
	mov rx,250h
	mov h,80h
	mov w,260h
	call paint
	
	mov al,42h;color
	mov y,50h
	mov rx,260h
	mov h,80h
	mov w,280h
	call paint
	
	mov al,8Ah;color
	mov y,50h
	mov rx,270h
	mov h,80h
	mov w,280h
	call paint

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