;transformando caractere em maiúscula ou minúscula, lidando com endereços e impressão de strings
%include "io.inc"
section .data
    letter db "home", 0xA, 0x0  ;0xA == \n (quebra de linha) e 0x0 == \0 (símbolo de fim de string)
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging

    ;entendendo possíveis formatações para impressão
    PRINT_STRING letter     ;imprimindo string  
    PRINT_STRING [letter+1] ;imprimindo string pela metade
    PRINT_CHAR [letter+2]   ;imprimindo character é possível passar um ponteiro que não seja o primeiro da string
    PRINT_CHAR [letter+3]   ;idem
    NEWLINE
    
    mov edi, letter         ;edi = "h"  |   edi aponta para a primeira posição da string "letter"
    
    mov al, byte [edi]      ;al = 'h'   |   al recebe um caractere de edi
    PRINT_CHAR al
    NEWLINE
    sub al, 32              ;al -= 32   |   manipulamos o al. Ao subtrair 32 transformamos a letra em maiúscula
    PRINT_CHAR al
    NEWLINE
    mov byte [edi], al      ;edi = al   |   edi recebe sua letra maiúscula
    PRINT_STRING letter
    NEWLINE
    PRINT_CHAR letter
    NEWLINE      
                   
    PRINT_CHAR 97           ;97 == 'a'
    NEWLINE
    PRINT_CHAR 65           ;65 == 'A'
    
    xor eax, eax
    ret