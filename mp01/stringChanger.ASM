; micro project #1 for Computing-Architecture; Shulikov Aleksey 192; var #28
format PE console

entry start

include 'win32a.inc'

section '.data' data readable writable
        strIntro db 'Enter your line ', 10, 0
        strScanString db '%s', 0

        line dd 0

section '.code' code executable readable
start:

input:
        push strIntro
        call [printf]

        push line
        push strScanString
        call [scanf]

changer:
        mov eax, [line]
        add eax, 8

output:
        push line
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






