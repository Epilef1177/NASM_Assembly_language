;comparando duas strings diferentes
%include "io.inc"
section .data
    msg1 db "Hello World!!", 0
    tam1 equ $- msg1
    msg2 db "Hello World!!", 0
    msg3 db "Hello World**", 0
    igual db "As strings acima são iguais", 0
    nao_igual db "As strings acima não são iguais", 0
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    cld
    PRINT_STRING msg1
    NEWLINE
    mov esi, msg1
    PRINT_STRING msg2
    NEWLINE
    mov edi, msg2
    mov ecx, tam1
    repe cmpsb
    je true
    jne false
true:
    call equal
    jmp next
false:    
    call not_equal

next:
    cld
    PRINT_STRING msg1
    NEWLINE
    mov esi, msg1
    PRINT_STRING msg3
    NEWLINE
    mov edi, msg3
    mov ecx, tam1
    repe cmpsb
    je true1
    jne false2
true1:
    call equal
    jmp next
false2:    
    call not_equal
    jmp ending_program
    
;saídas pré-definidas    
equal:
    PRINT_STRING igual
    NEWLINE
    NEWLINE
    ret
not_equal:
    PRINT_STRING nao_igual
    NEWLINE
    NEWLINE
    ret
    
;fim do programa
ending_program:
    xor eax, eax
    ret