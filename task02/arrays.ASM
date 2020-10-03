format PE console

entry main

include 'win32a.inc'

section '.data' data readable writable
        strVecSize      db 'size of vector? ', 0
        strIncorSize    db 'Incorrect size of vector = %d', 10, 0
        strVecElemI     db '[%d]? ', 0
        strScanInt      db '%d', 0
        strSumValue     db 'Summa = %d', 10, 0
        strVecElemOut   db '[%d] = %d', 10, 0
        strEmptyLine    db '', 10, 0

        vec_size     dd 0
        i            dd ?
        tmp          dd ?
        tmpStack     dd ?
        vecIn        rd 100
        vecOut       rd 100
        NULL = 0
        FIVE dd 5
        NFIVE dd -5


section '.code' code executable readable
main:
;input
        call VectorInput
;operations
        call VectorChanger
;output
        push strEmptyLine
        call [printf]

        mov ebx, vecIn
        call VectorOutput

        push strEmptyLine
        call [printf]

        ;mov ebx, vecOut
        ;call VectorOutput
;end
        call finish
;1-----------------------------------------------------------------------
VectorInput:
        push strVecSize
        call [printf]
        add esp, 4

        push vec_size
        push strScanInt
        call [scanf]
        add esp, 8

        mov eax, [vec_size]
        cmp eax, 0
        jg  getVector

        push vec_size
        push strIncorSize
        call [printf]
        call finish
getVector:
        xor ecx, ecx
        mov ebx, vecIn
getVecLoop:
        mov [tmp], ebx
        cmp ecx, [vec_size]
        jge endInputVector       ; to end of loop

        ; input element
        mov [i], ecx
        push ecx
        push strVecElemI
        call [printf]
        add esp, 8

        push ebx
        push strScanInt
        call [scanf]
        add esp, 8

        mov ecx, [i]
        inc ecx
        mov ebx, [tmp]
        add ebx, 4
        jmp getVecLoop
endInputVector:
        ret
;-----------------------------------------------------------------------1

;2-----------------------------------------------------------------------
VectorChanger:
        xor ecx, ecx
        mov eax, vecIn
        mov ebx, vecOut
changeLoop:
        cmp ecx, [vec_size]
        je endChange

        cmp [eax], dword 5
        jle notMore5
;if a[i]>5
        mov ebx, eax
        add [ebx],dword 5
        jmp littleEnd
notMore5:
        cmp [eax], dword -5
        jge between
;if a[i]<-5
        mov ebx, eax
        sub [ebx], dword 5
        jmp littleEnd
between:
        mov [eax], dword 0
        mov ebx, eax
        jmp littleEnd
littleEnd:
        add eax, 4
        add ebx, 4
        inc ecx
        jmp changeLoop
endChange:
        ret

;-----------------------------------------------------------------------2

;3-----------------------------------------------------------------------
VectorOutput:
        mov [tmpStack], esp
        xor ecx, ecx            ; ecx = 0
putVecLoop:
        mov [tmp], ebx
        cmp ecx, [vec_size]
        je endOutputVector      ; to end of loop
        mov [i], ecx

        ; output element
        push dword [ebx]
        push ecx
        push strVecElemOut
        call [printf]

        mov ecx, [i]
        inc ecx
        mov ebx, [tmp]
        add ebx, 4
        jmp putVecLoop
endOutputVector:
        mov esp, [tmpStack]
        ret
;-----------------------------------------------------------------------3

finish:
        call [getch]
        push NULL
        call [ExitProcess]


;-------------------------IMPORT-SECTION---------------------------------
section '.idata' import data readable
        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt,\
               getch, '_getch',\
               printf, 'printf',\
               scanf, 'scanf'






