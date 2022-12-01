;como funciona o SCAS
;string a ser colocada da entrada padrão
;eu gosto de comer
%include "io.inc"
section .data
    letter db "m", 0x0
    founded db "Letra encontrada!", 0xA, 0x0
    not_founded db "Letra não encontrada!", 0xA, 0x0
section .bss
    array resb 100

section .text
global CMAIN
CMAIN:
    GET_STRING array, 100
    PRINT_STRING array
    NEWLINE

    cld
    mov edi, array
    mov ecx, 100
    mov esi, letter
    lodsb

;contagem de quantas letras 'm' a string possui
    mov edx, 0
_lp:
    scasb
    PRINT_DEC 2, edx
    jne _continue
_plus:
    inc edx
_continue: 
    loop _lp
    cmp edx, 0
    je _not_founded

_found:
    NEWLINE
    PRINT_STRING founded
    PRINT_DEC 2, edx
    jmp _ending_program
    
_not_founded:
    NEWLINE
    PRINT_STRING not_founded    
    
_ending_program:
    xor eax, eax
    ret