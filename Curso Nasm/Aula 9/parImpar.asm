section .text
global ParImpar
ParImpar:
    mov eax, edi            ;o EDI é o registrador que recebe o parâmetro do arquivo c
    call restoDivisao       ;o EAX é o registrador que guarda o valor de retorno da função realizada
    ret                     ;este ret é dispensável, pois quando damos o ret (return) em qualquer outro lugar do programa ele já retorna o valor de eax naquele ponto
                            ;agora o ret tem função, pois chamei o label restoDivisao com o call e não com o jmp
restoDivisao:
    mov edx, 0x0            ;resto da divisão
    mov ebx, 0x2            ;divisor
    div ebx
    cmp edx, 0x0
    jz par
    jg impar
    
volta:                      ;label criada para estudar o comportamento do ret e as chamadas call
    ;mov eax, 0x2
    ;ret
impar:
    mov eax, 0x1
    ret
    ;jmp volta

par:
    mov eax, 0x0
    ret
    ;jmp volta