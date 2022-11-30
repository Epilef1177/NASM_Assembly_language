;Colar na entrada padrão
;Hello World!
%include "io.inc"
section .bss
    name resb 100
    nome resb 100
section .text
global CMAIN
CMAIN:
    ;pega uma string da entrada padrão, salva ela num array e imprime na saída padrão
    mov ebp, esp            ; for correct debugging
    GET_STRING  name, 100   ;GET_STRING data (variable), maxsz (length less than)
    PRINT_STRING name       ;print(name)
    NEWLINE
    
    ;AINDA NÃO FUNCIONA ESSA PARTE
    ;movsb nome, name
    ;lodsb 
    ;PRINT_STRING nome
    
_ending_program:
    xor eax, eax
    ret