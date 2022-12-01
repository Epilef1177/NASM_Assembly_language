;tudo que se faça com o STOS(b,w,d) ou o LODS(b,w,d) vai para o eax
%include "io.inc"
section .data
    array1 dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    space db "                  ", 0x0
    eaxs db "Valores do eax", 0x0
    vetor db "Valores do vetor", 0x0
section .bss
    array2 resd 10
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp        ; for correct debugging
    cld                 ;DF = 0             |       clear direction flag
    mov esi, array1     ;esi = array1[0]*
    mov edi, array2     ;edi = array2[0]*

    mov ecx, 9         ;ecx = 10           |       acumulador que determina a quantidade de vezes que o loop irá acontecer
    mov ebx, 0         ;ebx = 0            |       endereços do vetor .bss
    
    PRINT_STRING eaxs
    NEWLINE
_loop:
    lodsd               ;eax = esi          |       recebe conteúdo do ponteiro esi
    stosd               ;esi = eax          |       recebe conteúdo do eax
    
    PRINT_DEC 2, eax
    PRINT_CHAR space
    
    cmp ecx, 0
    je _next
    dec ecx
    jmp _loop

_next:
    mov ecx, 9
    mov ebx, 0
    NEWLINE
    PRINT_STRING vetor
    NEWLINE
_loop1:

    PRINT_DEC 2, [array2+ebx]
    PRINT_CHAR space

    cmp ecx, 0
    je _ending_program
    dec ecx
    add ebx, 4
    jmp _loop1

_ending_program:
    xor eax, eax
    ret