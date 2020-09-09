; byte++ 1 урок
; Hello world

; формат выходного файла
format PE console

; точка входа
entry start

; подключаемые модули
include 'win32a.inc'

section '.code' code readable executable
        start:
        ; код программы
              push helloStr
              call [printf]

              call [getch]

              push NULL
              call [ExitProcess]

section '.data' data readable writable
        ; данные используемые программой (метки)
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



