format PE console

entry start

include 'win32a.inc'

section '.data' data readable writable


section '.code' code executable readable
        start:




section '.idata' import readable writable
        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt,\
               getch, '_getch',\
               printf, 'printf',\
               scanf, 'scanf'






