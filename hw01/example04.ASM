; bit shift
; ror rol shl shr

format PE console

entry start

include 'win32a.inc'

section '.data' data readable writable
        resStr db 'Result: %d', 0

        A dw ?
        B dw ?
        C dw ?

        NULL = 0

section '.code' code readable executable
        start:
                ;mov ecx, 250
                ;shr ecx, 2

                xor eax, eax
                mov al, 250
                rol al, 1

                push eax

                ;push ecx
                push resStr
                call [printf]

                call [getch]

                push NULL
                call [ExitProcess]


section '.idata' import readable writable
        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt,\
               getch, '_getch',\
               printf, 'printf',\
               scanf, 'scanf'