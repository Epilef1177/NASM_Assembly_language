;Colar na entrada padrão
;Hello World!
%include "io.inc"
section .data
    hello db "hello World!", 0xA, 0x0
    zzz   db "Z", 0xA, 0x0
    
section .bss
    name resb 100
    nome resb 100
section .text
global CMAIN
CMAIN:
    mov ebp, esp            ; for correct debugging
    
    ;pega uma string da entrada padrão, salva ela num array e imprime na saída padrão
    GET_STRING  name, 100   ;GET_STRING data (variable), maxsz (length less than)
    PRINT_STRING name       ;print(name)
    NEWLINE
    
    mov edi, hello
    mov al, zzz
    add edi, 12
    stosb
    PRINT_STRING hello
    
_ending_program:
    xor eax, eax
    ret