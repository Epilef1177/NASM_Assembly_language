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
    mov ebp, esp                ; for correct debugging
    
    cld                         ;DF = 0
    PRINT_STRING msg1
    NEWLINE
    mov esi, msg1               ;esi = "H"  |   esi aponta para msg1
    PRINT_STRING msg2
    NEWLINE
    mov edi, msg2               ;edi = "H"  |   edi aponta para msg2
    mov ecx, tam1               ;ecx = tam1 |   tamanho das strings a serem comparadas
    repe cmpsb                  ;repete a comparação com todos os caracteres até o ecx igual à 0. ecx-- a cada interação
    je true                     ;se as strings forem iguais vai para a label "true"
    jne false                   ;se as strings não forem iguais vai para a label "false"
true:
    call equal                  ;chama a função equal
    jmp next                    ;pula para o label "next"
false:    
    call not_equal              ;chama a função not_equal

next:
    cld                         ;DF = 0
    PRINT_STRING msg1
    NEWLINE
    mov esi, msg1               ;esi = "H"  |   esi aponta para msg1  
    PRINT_STRING msg3
    NEWLINE
    mov edi, msg3               ;edi = "H"  |   edi aponta para msg3
    mov ecx, tam1               ;ecx = tam1 |   tamanho das strings a serem comparadas
    repe cmpsb                  ;repete a comparação com todos os caracteres até o ecx igual à 0. ecx-- a cada interação
    je true1                    ;se as strings forem iguais vai para a label "true"
    jne false2                  ;se as strings não forem iguais vai para a label "false"
true1:
    call equal                  ;chama a função equal
    jmp next                    ;pula para o label "next"
false2:    
    call not_equal              ;chama a função not_equal
    jmp ending_program          ;pula para o fim do programa
    
;saídas pré-definidas    
equal:
    PRINT_STRING igual          ;confirma que as strings são iguais
    NEWLINE
    NEWLINE
    ret
not_equal:
    PRINT_STRING nao_igual      ;confirma que as strings são diferentes
    NEWLINE
    NEWLINE
    ret
    
ending_program:
    xor eax, eax
    ret