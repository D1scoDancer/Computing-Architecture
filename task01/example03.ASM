; simple arithmetic

format PE console

entry start

include 'win32a.inc'

section '.data' data readable writable
        resStr db 'Result: %d', 0
        emptyStr db '%d', 0
        point db ',', 0

        A dd ?
        B dd ?
        C dd ?

        NULL = 0

section '.code' code readable writable
        start:
                mov [A], 12
                mov [B], 5
                inc [A] ;++
                dec [B] ;--
                ;neg [A] ;*(-1)
                ;mov ecx, [A]
                ;add ecx, [B]
                ;sub ecx, [B]
                ;imul ecx, [B]

                ;mov eax, [A]
                ;mul [B]
                ;push eax

                mov eax, [A]
                mov ecx, [B]
                mov edx, 0
                div ecx
                mov [C], edx
                push eax

                ;push ecx
                push resStr
                call [printf]

                push point
                call [printf]

                        mov ebx, 0
                        lp:
                                mov eax, [C]
                                mov ecx, [B]
                                imul eax, 10

                                mov edx, 0
                                div ecx
                                mov [C], edx

                                push eax
                                push emptyStr
                                call [printf]

                                add ebx, 1
                                cmp ebx, 3
                        jne lp

                call [getch]

                push NULL
                call [ExitProcess]

section '.idata' import data readable
        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt,\
               printf, 'printf',\
               getch, '_getch',\
               scanf, 'scanf'

