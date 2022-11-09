section .text
global NParametros
NParametros:         ;pra serem passados mais de três parâmtros só passando como uma string
    mov eax, edi     ;1º paramêtro edi
    add eax, esi    ;2º paramêtro esi
    add eax, edx    ;3º paramêtro edx
    ret