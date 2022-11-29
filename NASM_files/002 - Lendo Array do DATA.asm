%include "io.inc"

section .data
    dados dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10  ;declarando os valores do array
    
section .bss
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    xor eax, eax    ;eax = 0
    mov ebx, 10     ;ebx = 10
    mov ecx, 0      ;ecx = 0
    
;pegando os valores do array, passando eles para o eax e imprimindo eles
inicio:
    cmp ebx, 0              ;compara ebx com 0
    je fim                  ;pula para o label 'fim'
    dec ebx                 ;ebx -= 1
    mov eax, [dados+ecx]    ;eax = dados[ecx]
    ;GET_DEC 2, eax
    PRINT_DEC 2, eax        ;print(eax)
    NEWLINE                 ;\n
    add ecx, 4              ;eax += 4
    jmp inicio              ;pula para o label 'inicio'
fim:
    ;End
    xor eax, eax
    ret