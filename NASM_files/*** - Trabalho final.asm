;Entrada: Qual é a importância da escola na democratização da sociedade
%include "io.inc"
section .data

section .bss
    dados_salvos resd 10
    entrada resb 100
    sub_entrada resb 100

section .text
global CMAIN
CMAIN:
;FUNÇÃO MAIN()
    call PEGAR_ENTRADA      ;(0ª QUESTÃO)
    call DIVIDIR_STRING     ;(1ª QUESTÃO)
    call ENCONTRAR_A_M      ;(2ª QUESTÃO)

_fim_programa:
    xor eax, eax
    ret

;//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//

;FUNÇÕES SECUNDÁRIAS

;//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//

;FUNÇÃO PEGAR_ENTRADA:
PEGAR_ENTRADA:
    GET_STRING entrada, 100
    ret


;FUNÇÃO DIVIDIR_STRING: (1ª QUESTÃO)
DIVIDIR_STRING:
    mov esi, entrada
    mov edi, sub_entrada

    add esi, 8
    mov ecx, 44

_loop_movsb:
    movsb
    loop _loop_movsb

    PRINT_STRING sub_entrada
    ret

;//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//

;FUNÇÃO ENCONTRAR_A_M: (2ª QUESTÃO)
;a quantidade de A's será armazenada no vetor/array dados_salvos[0]
;a quantidade de M's será armazenada no vetor/array dados_salvos[1]
ENCONTRAR_A_M:
    
    ret

;________________________________________________________________________________________________________________________________________________________________________________________________