;trabalharemos a partir de agora com os arquivos ASM sendo apenas bibliotecas de funções a serem invocadas no programa c
;o programa em c neste caso só será utilizado para tratar as entradas e saídas utilizadas
section .text
global GetValorASM
GetValorASM:
    mov eax, edi    ;o EDI é o registrador que recebe o parâmetro do arquivo c
    add eax, 1      ;o EAX é o registrador que guarda o valor de retorno da função realizada
    ret