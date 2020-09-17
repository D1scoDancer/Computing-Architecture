; logic commands
; or xor and not test

format PE console

entry start

include 'win32a.inc'

section '.data' data readable writable
        resStr db 'Result: %d', 0
        str1 db 'ZF = 1, op result is FALSE', 0
        str2 db 'ZF = 0, op result is TRUE', 0


        A dw ?
        B dw ?
        C dw ?

        NULL = 0

section '.code' code executable readable
        start:
                ;mov eax, 110b
                ;and eax, 101b
                ;or eax, 101b
                ;xor eax, 1010b

                ;xor eax, eax
                ;mov al, 11111110b
                ;not al

                ;push eax
                ;push resStr
                ;call [printf]

                mov eax, 110b
                test eax, 001b

                jz ifZFTrue

                push str2
                call [printf]
                jmp finish

                ifZFTrue:
                         push str1
                         call [printf]

                finish:
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