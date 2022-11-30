;substitui os espaços em branco da string de label "msg" e e põe *
%include "io.inc"
section .data
    ;sapce = string que compararemos para verificar os espaços
    space db "                                                                                                                                 ", 0
    star db "*", 0          ;star = * deve
    msg db "Do you speak english? No?!", 0
    tam equ $- msg
section .text
global CMAIN
CMAIN:

    mov ecx, tam            ;ecx = length de msg
    mov eax, 0              ;eax = 0    |   eax guardará o valor da posição na string que está sendo comparada
_start:
    mov esi, space          ;
    mov edi, msg
    add esi, eax
    add edi, eax
_fixing_space:
    inc eax
    cmpsb
    je fixing
    loop _fixing_space
    jmp _ending_program
    ;jne not_equal
fixing:
    mov esi, star
    dec edi
    movsb
    PRINT_STRING msg
    NEWLINE 
    jmp _start
    
_ending_program:
    xor eax, eax
    ret