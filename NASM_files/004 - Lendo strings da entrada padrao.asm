;Entendendo a aplicação do STOSB
;Colar na entrada padrão
;HELLO WORLD!
%include "io.inc"
section .data
    hello db "hello World!", 0xA, 0x0
    zzz   db "Z", 0xA, 0x0
    zero1 db 0x0
    
section .bss
    name resb 100
    nome resb 100
    arrayRD resd 10
section .text
global CMAIN
CMAIN:
    mov ebp, esp            ; for correct debugging
    
    ;pega uma string da entrada padrão, salva ela num array e imprime na saída padrão
    GET_STRING  name, 100   ;GET_STRING data (variable), maxsz (length less than)
    PRINT_STRING name       ;print(name)
    NEWLINE
    
    PRINT_STRING hello        
    mov edi, hello
    mov al, byte [zzz]
    add edi, 12
    stosb
    PRINT_STRING hello
    
    mov esi, zero1                  ;esi = zero     |       aponta para o primeiro valor de zero1 0
    mov edi, hello                  ;edi = "H"      |       aponta para o primeiro endereço de hello
    call size_string1               ;chama a função "size_string:" que calcula o tamanho da string colocada no edi corretamente
    PRINT_DEC 2, [arrayRD]          ;imprime o tamanho da string colocada na 1ª posição do arrayRD
    jmp _ending_program             ;pula para a label do final do programa
    
;FUNÇÕES    
;função que mede o coprimento de uma string    
size_string1:
    mov ebx, 0                      ;ebx = 0        |       ebx guardará o valor do tamanho da string
    add esi, 1                      ;esi += 1       |       como na próxima etapa temos que ficar decrementando o esi para ele apontar para seu único caractere (o '0x0', que corresponde ao fim de string), somamos +1 para que ele não perca a referêncis do ponteiro
loop_size_string1:
    dec esi                         ;esi -= 1       |       sempre fazendo o esi apontar para o seu único caractere o 0x0 (final de string)
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