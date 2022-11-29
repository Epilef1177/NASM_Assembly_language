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
    
    mov esi, msg2   ;string fonte
    mov edi, msg1   ;string destino
    cld
    movsb           ;msg1 = "Aello World"
    ; edi → “e”
    ; esi → “B”
    PRINT_STRING msg1
    NEWLINE
    add esi, 4
    add edi, 4
    movsb
    PRINT_STRING msg1
    NEWLINE
    
    
    mov esi, msg3   ;string fonte
    mov edi, msg1   ;string destino
    cld
    add edi, 10
    movsb           ;msg1 = "Aello World"
    PRINT_STRING msg1
    
    
                
    xor eax, eax
    ret