%TITLE "Ваш комментарий программы"
MODEL	small

ST1 SEGMENT             ;Описали сегмент стека;
	DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT

DATA ENDS


CODE SEGMENT            ;открыли сегмент кода;
ASSUME SS:ST1,DS:DATA,CS:CODE    ;связали регистровые сегменты с сегментами;

Start:
	push	ds
	push	ax
	mov	ax, data	
	mov	ds, ax
;========== Ниже пишите Ваш код ==============================
	xor ax,ax
	xor bx,bx;очищаем регистры
	xor dx,dx
	mov ah, 01h
	int 21h;вводим первое число
	cmp al,30h
	jl Z1;меньше 0
	cmp al,3ah
	jg Z1;больше 9
	jmp OK1
Z1:	mov al,30h;оставляем 0 при ошибке
OK1:sub al,30h;вычитаем код символа 0
	mov bl,al;сохраняем
	mov ah,02h
	mov dl,0ah;переход на следующую строку
	int 21h
	mov ah,01h
	int 21h;вводим второе число
	cmp al,30h
	jl Z2;меньше 0
	cmp al,3ah
	jg Z2;больше 9
	jmp OK2
Z2:	mov al,30h;оставляем 0 при ошибке
OK2:sub al,30h;вычитаем код символа 0
	add bl,al;сложение
	mov ah,02h
	mov dl,0ah;переход на следующую строку
	int 21h
	mov dl,bl;отправляем на вывод
	cmp dl,0ah;проверка размера числа
	jl GO
	mov dl,31h;выводим десяток
	int 21h
	mov dl,bl
	sub dl,0ah;
GO:	add dl,30h;добавляем код символа 0
	int 21h;вывод ответа
;========== Заканчивайте писать Ваш код======================
	pop	ax
	pop	ds
Exit:
	mov	AX,4C00h;сигнал завершения работы
	int	21h
ENDS

END	Start