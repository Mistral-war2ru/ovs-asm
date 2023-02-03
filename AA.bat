Echo Off
cls
If -%1== - GoTo Mess1
If not exist %1.Asm GoTo Mess2
Echo Компиляция ...
TAsm %1.Asm /l
If ErrorLevel 1 GoTo ContErr
Echo Ошибок нет ...
Echo Компановка ...
TLink %1.Obj IoProc.Obj
Del %1.Lst
Del %1.Map
Del %1.Obj

GoTo Exit

:ContErr
Echo !!!  Есть ошибки ...
Echo Внимательно смотри *.Lst
Pause
Rem Type %1.Lst
Rem Pause
GoTo Exit

:Mess1
Echo Нет параметра ...
GoTo Exit
:Mess2
Echo Нет файла 1%.Asm
:Exit
