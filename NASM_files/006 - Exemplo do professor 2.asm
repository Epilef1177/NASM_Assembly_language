%include "io.inc"
section .data
    array1 dd 1,2,3,4,5
    array2 dd 6,7,8,9,10
section .text
global CMAIN
CMAIN:
    mov ebp, esp        ;for correct debugging
    mov esi, array1     ;esi = 1    |   linkando o esi com o array1
    mov edi, array2     ;edi = 6    |   linkando o edi com o array2
    mov ecx, 5          ;ecx = 5
    
    ;cld -> DF = 0  |   cld == define leitura do array do início para o fim (direita)
    ;fazendo com que cada vez que chamemos o movs[b,w,d,q] ele adicione 1 ao esi e/ou edi
    
    ;std -> DF = 1  |   std == define leitura do array do fim para o início (esquerda)
    ;fazendo com que cada vez que chamemos o movs[b,w,d,q] ele subtraia 1 ao esi e/ou edi
    
    cld                 ;DF = 0     |   clear direction flag    
    
    mark:
    movsd               ;array2 = 1,2,3,4,5
    loop mark           ;loop gerenciado automaticamente    |   continua até o ecx ser zerado
    call _print         ;chamada para função
    jmp ending          ;pula para o final do programa
    
_print:                         ;função que printa um array de 5 espaços
    mov eax, 0                  ;eax = 0    |   será o índice do vetor
_start_print:                   ;ponto de retorno para o loop
    cmp eax, 20                 ;compara o valor de eax com 20  |   20 é o tamanho de bytes que um vetor com 5 espaços do tipo double (dd) possui
    jge _return_print           ;se eax >= 20 então vai para o label "_return_print"
    PRINT_DEC 2, [array2+eax]   ;imprime o valor do array
    NEWLINE
    add eax, 4                  ;eax += 4   |   o enderaçamento é feito de 4 em 4 pois estamos utilizando o double (dd)
    jmp _start_print            ;repetição de loop até quebrar a condição
_return_print:                  ;label de finalização
    ret                         ;retorno para o local onde a função foi chamada pelo call
    

ending:                         ;sinalização para o sistema de que o programa finalizou sem erros
    xor eax, eax
    ret