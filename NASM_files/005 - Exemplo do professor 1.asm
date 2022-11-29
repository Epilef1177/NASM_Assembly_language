%include "io.inc"
section .data
msg1 db "Hello World", 0
msg2 db "ABCDEFGHIJK",0
section .text
global CMAIN
CMAIN:
    PRINT_STRING msg1
    NEWLINE
    PRINT_STRING msg2
    NEWLINE
    NEWLINE
    
    mov esi, msg2   ;string fonte   |   esi =  Aqui linkamos o esi à string msg2
    mov edi, msg1   ;string destino |
    cld
    movsb           ;msg1 = "Aello World"
    ; edi → "e"
    ; esi → "B"
    PRINT_STRING msg1
    NEWLINE
    movsb
    PRINT_STRING msg1
    NEWLINE
    movsb
    PRINT_STRING msg1
    NEWLINE
    movsb
    PRINT_STRING msg1
    NEWLINE
    movsb
    PRINT_STRING msg1
    NEWLINE
    movsb
    PRINT_STRING msg1
    NEWLINE
    movsb
    PRINT_STRING msg1
    NEWLINE
    movsb
    PRINT_STRING msg1
    NEWLINE
    movsb
    PRINT_STRING msg1
    NEWLINE
    movsb
    PRINT_STRING msg1
    NEWLINE
    movsb
    PRINT_STRING msg1
    NEWLINE
    movsb
                
    xor eax, eax
    ret