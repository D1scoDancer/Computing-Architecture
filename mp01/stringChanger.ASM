; micro project #1 for Computing-Architecture; Shulikov Aleksey 192; var #28
format PE console

entry start

include 'win32a.inc'

section '.data' data readable writable
        strIntro db 'Enter your line ', 10, 0
        strScanString db '%s', 10

        line rb 100h

section '.code' code executable readable
start:
        ;int3
input:
        push strIntro
        call [printf]
        add esp, 4

        push line
        push strScanString
        call [scanf]
        ;add esp, 8

output:
        push line
        call [printf]
        add esp, 4

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






