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
    
    mov esi, msg2       ;string fonte           |   esi = "A" Aqui linkamos o esi à string msg2
    mov edi, msg1       ;string destino         |   edi = "H" Aqui linkamos o edi à string msg1
    cld                 ;clear direction  = 0
    movsb               ;edi("H") = esi("A")    |   msg1 = "Aello World"    |   move um byte
                        ;edi → "e"
                        ;esi → "B"
    PRINT_STRING msg1
    NEWLINE
    movsb               ;edi("e") = esi("B")   
    PRINT_STRING msg1
    NEWLINE
    movsb               ;edi("l") = esi("C")
    PRINT_STRING msg1
    NEWLINE
    movsb               ;edi("l") = esi("D")
    PRINT_STRING msg1
    NEWLINE
    movsb               ;edi("o") = esi("E")
    PRINT_STRING msg1
    NEWLINE
    movsb               ;edi(" ") = esi("F")
    PRINT_STRING msg1
    NEWLINE
    movsb               ;edi("W") = esi("G")
    PRINT_STRING msg1
    NEWLINE
    movsb               ;edi("o") = esi("H")
    PRINT_STRING msg1
    NEWLINE
    movsb               ;edi("r") = esi("I")
    PRINT_STRING msg1
    NEWLINE
    movsb               ;edi("l") = esi("J")
    PRINT_STRING msg1
    NEWLINE
    movsb               ;edi("d") = esi("K")
    PRINT_STRING msg1
    NEWLINE
                
    xor eax, eax
    ret