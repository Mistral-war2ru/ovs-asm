.xlist
;--------------------------------------
;  Завершение работы программы
;--------------------------------------
finish	MACRO

	MOV	AX,4C00h
	INT	21h

	ENDM
;--------------------------------------
;  Переход на новую строку
;--------------------------------------
	EXTRN	_newline:FAR

newline	MACRO

	CALL	_newline

	ENDM
;--------------------------------------
;  Вывод символа
;	Обращение: outch c
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
;  Вывод строки символов
;    In:  ds:dx - начальный адрес строки
;  Замечание: строка должна заканчиваться
;    символом '$'.
;--------------------------------------
outstr	MACRO

	PUSH	AX
	MOV	AH,09h
	INT	21h
	POP	AX

	ENDM
;--------------------------------------
;  Вывод целого со знаком размером в слово
;	Обращение:  outint num [,leng]
;         num  - выводимое число i16, r16, m16
;	  leng - ширина поля вывода i8, r8, m8
;  Замечание:
;    если поле больше, чем надо, то слева
;    добавляются пробелы,
;    если меньше - выводится только число (полностью)
;    leng=0 по умолчанию
;--------------------------------------
	EXTRN	_outint:FAR
	
outint	MACRO	num,leng

	outnum	<num>,<leng>,1

	ENDM
;--------------------------------------
;  Вывод целого без знака размером в слово
;	Обращение: outword num [,leng]
;--------------------------------------
outword	MACRO	num,leng

	outnum	<num>,<leng>,0
	
	ENDM
;--------------------------------------
; Вспомогательный макрос проверки
; написания имени разными (большими
; и малыми) буквами
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
; Вспомогательный макрос для outint и outword
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
;  Очистка буфера ввода с клавиатуры
;--------------------------------------
	EXTRN	_flush:FAR
	
flush	MACRO

	CALL	_flush
	
	ENDM
;--------------------------------------
; Ввод символа (без Enter)
;	Обращение: inch x
;   x - r8, m8
; Out: x - введенный символ
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
;  Ввод целого числа размером в слово
;	Обращение: inint x
;    x - r16, m16
;  Out: x - введенное число
;  Замечание:
;    пропускаются все пробелы и концы
;    строк перед числом;
;    число должно начинаться с цифры или
;    знака;
;    ввод идет до первой нецифры(в т.ч. до Enter);
;    при ошибке программа завершается с
;    аварийным сообщением.
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