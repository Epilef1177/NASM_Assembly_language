%include "io.inc"
section .data
msg1 db "Hello World", 0
msg2 db "ABCDEFGHIJK",0
msg3 db "Z",0
section .text
global CMAIN
CMAIN:
    PRINT_STRING msg1
    NEWLINE
    PRINT_STRING msg2
    NEWLINE
    NEWLINE
    
    ;modificando a primeira letra da string
    mov esi, msg2       ;esi = "A"              |   string fonte
    mov edi, msg1       ;edi = "H"              |   string destino
    cld                 ;DF = 0 (direction flag) |   clear direction flag 
    movsb               ;edi("H") = esi("A")    |   msg1 = "Aello World"
                        ;edi → "e"
                        ;esi → "B"
                        
    ;modificando uma letra no meio
    PRINT_STRING msg1
    NEWLINE
    add esi, 4          ;esi += 4   |   pulamos quatro bytes a partir do ponteiro atual do esi
    add edi, 4          ;edi += 4   |   pulamos quatro bytes a partir do ponteiro atual do edi
    movsb               ;edi(" ") = esi("F")    |   msg1 = "AelloFWorld"
    PRINT_STRING msg1
    NEWLINE
    
    ;modificando a última letra
    mov esi, msg3       ;esi = "Z"  |   string fonte
    mov edi, msg1       ;edi = "A"  |   string destino  |   resetando o ponteiro para msg1 para o início
    cld                 ;DF = 0 
    add edi, 10         ;edi += 10  |   edi("d")        |   ponteiro aponta para a última posição da string msg1 ("d")
    movsb               ;msg1 = "AelloFWorlZ"
    PRINT_STRING msg1

ending_program:
    xor eax, eax
    ret