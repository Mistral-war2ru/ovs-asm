Echo Off
cls
If -%1== - GoTo Mess1
If not exist %1.Asm GoTo Mess2
Echo ��������� ...
TAsm %1.Asm /l
If ErrorLevel 1 GoTo ContErr
Echo �訡�� ��� ...
Echo ���������� ...
TLink %1.Obj IoProc.Obj
Del %1.Lst
Del %1.Map
Del %1.Obj

GoTo Exit

:ContErr
Echo !!!  ���� �訡�� ...
Echo �����⥫쭮 ᬮ�� *.Lst
Pause
Rem Type %1.Lst
Rem Pause
GoTo Exit

:Mess1
Echo ��� ��ࠬ��� ...
GoTo Exit
:Mess2
Echo ��� 䠩�� 1%.Asm
:Exit
