; byte++ 1 ����
; Hello world

; ������ ��������� �����
format PE console

; ����� �����
entry start

; ������������ ������
include 'win32a.inc'

section '.code' code readable executable
        start:
        ; ��� ���������
              push helloStr
              call [printf]

              call [getch]

              push NULL
              call [ExitProcess]

section '.data' data readable writable
        ; ������ ������������ ���������� (�����)
        helloStr db 'Hello, world!', 0
        NULL = 0

section '.idata' import readable
        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt,\
               printf, 'printf',\
               getch, '_getch'



