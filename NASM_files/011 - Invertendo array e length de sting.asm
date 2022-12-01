;Entendendo como contar o tamanho de um string que foi recebida externamente
;Entendendo como inverter um array

%include "io.inc"
section .data
    array dd 50, 40, 30, 20, 10
    space db " ", 0x0
    hello db "Hello World!", 0xA, 0x0
    zero db 000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    zero1 db 0x0
section .bss
    arrayRD resd 10
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    mov eax, [array]                ;eax = 50       |   passamos o valor de um array já declarado
    mov [arrayRD], eax              ;arrayRD = 50   |   arrayRD sendo inicializado com seu primeiro valor
    add eax, [array+4]              ;eax = 40       |   utilizando o segundo valor do array já inicializado
    PRINT_DEC 2, eax
    PRINT_CHAR space
    PRINT_DEC 2, [arrayRD]
    NEWLINE
    
    mov ecx, 16                     ;ecx = 16       |   endereço máximo do array já inicializado no .data
    mov ebx, 0                      ;ebx = 0        |   endereço que receberá novos valores do arrayRD não inializado no .bss
_inverte:
    mov eax, [array+ecx]            ;1º)eax = 10 (array[4])    2º)eax = 20 (array[3])     3º)eax = 30 (array[2])     4º)eax = 40 (array[1])     5º)eax = 50 (array[0])
    mov [arrayRD+ebx], eax          ;1º)arrayRD[0] = 10        2º)arrayRD[1] = 20         3º)arrayRD[2] = 30         4º)arrayRD[3] = 40         5º)arrayRD[4] = 50 
    sub ecx, 4                      ;ecx -= 4
    add ebx, 4                      ;ebx += 4
    cmp ecx, 0                      ;compara ecx com 0
    jl  _next                       ;se ecx < 0 pula para o label "_next:"
    jmp _inverte                    ;se não, pula para a label "_inverte:"
    
_next:
    mov ecx, 0                      ;ecx = 0    |   endereço inicial do vetor a ser percorrido
_imprime:
    PRINT_DEC 2, [arrayRD+ecx]      ;imprimindo os valores de todos os endereços do arrayRD pra verificar corretude
    PRINT_STRING space              ;espaço entre cada valor
    add ecx, 4                      ;ecx += 4   |   dd = endereçamento como double word (4 em 4 bytes)
    
    cmp ecx, 16                     ;compara ecx com 16     |   último endereço do arrayRD
    jg  _next1                      ;se ecx > 16 pula para o label "_next1:"
    jmp _imprime                    ;se não, pula para o label "_imprime:"

_next1:
    PRINT_STRING zero               ;como só são vários símbolos de fim de string não imprime nada
    PRINT_CHAR   zero1              ;como só é um símbolo de fim de string não imprime nada
    NEWLINE
    
    ;primeira forma de contar o tamanho da string
    mov esi, zero                   ;esi = zero     |       aponta para o primeiro valor de zero 0
    mov edi, hello                  ;edi = "H"      |       aponta para o primeiro endereço de hello
    call size_string                ;chama a função "size_string:" que calcula o tamanho da string colocada no edi + 1
    PRINT_DEC 2, [arrayRD]          ;imprime o tamanho da string colocada na 1ª posição do arrayRD
    NEWLINE
    
    ;segunda forma de contar o tamanho da string
    mov esi, zero1                  ;esi = zero     |       aponta para o primeiro valor de zero1 0
    mov edi, hello                  ;edi = "H"      |       aponta para o primeiro endereço de hello
    call size_string1               ;chama a função "size_string:" que calcula o tamanho da string colocada no edi corretamente
    PRINT_DEC 2, [arrayRD]          ;imprime o tamanho da string colocada na 1ª posição do arrayRD
    jmp _ending_program             ;pula para a label do final do programa
    
;FUNÇÕES    |   PARTE NÃO SEQUENCIAL

;função que mede o coprimento de uma string +1
size_string:
    mov ebx, 0                      ;ebx = 0        |       ebx guardará o valor do tamanho da string
loop_size_string:
    mov al, byte [edi]              ;al = edi       |       al recebe o byte mais à direita de edi, já que o tamanho de edi é de 32 bits ou 4 bytes
    PRINT_CHAR al
    inc ebx                         ;ebx++
    cmpsb                           ;compara esi com edi
    je end_size_string              ;se esi == edi então pula para o label "end_size_string:"
    jne loop_size_string            ;se não, pula para o label "loop_size_string:"
end_size_string:
    mov [arrayRD], ebx              ;arrayRD[0] = ebx   |   taamanho da string calculado e armazenado
    ret                             ;return

;função que mede o coprimento de uma string    
size_string1:
    mov ebx, 0                      ;ebx = 0        |       ebx guardará o valor do tamanho da string
    add esi, 1                      ;esi += 1       |       como na próxima etapa temos que ficar decrementando o esi para ele apontar para seu único caractere (o '0x0', que corresponde ao fim de string), somamos +1 para que ele não perca a referêncis do ponteiro
loop_size_string1:
    dec esi                         ;esi -= 1       |       sempre fazendo o esi apontar para o seu único caractere o 0x0 (final de string)
    mov al, byte [edi]              ;al = edi       |       al recebe o byte mais à direita de edi, já que o tamanho de edi é de 32 bits ou 4 bytes
    PRINT_CHAR al
    inc ebx                         ;ebx++ 
    cmpsb                           ;compara esi com edi
    je end_size_string1             ;se esi == edi então pula para o label "end_size_string1:"
    jne loop_size_string1           ;se não, pula para o label "loop_size_string1:"
end_size_string1:
    mov [arrayRD], ebx              ;arrayRD[0] = ebx   |   taamanho da string calculado e armazenado
    ret                             ;return
    
_ending_program:
    xor eax, eax
    ret