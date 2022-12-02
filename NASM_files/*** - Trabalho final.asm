;Entrada: Qual e a importancia da escola na democratizacao da sociedade
%include "io.inc"
section .data
    ;(*  QUESTÃO)
    resposta1            db           "Resposta da 1ª questão:", 0xA, 0x0
    resposta2            db 0xa, 0xA, "Resposta da 2ª questão:", 0xA, 0x0
    resposta3            db      0xA, "Resposta da 3ª questão:", 0xA, 0x0
    resposta4            db 0xa, 0xA, "Resposta da 4ª questão:", 0xA, 0x0
    resposta5            db 0xa, 0xA, "Resposta da 5ª questão:", 0xA, 0x0
    resposta6            db 0xa, 0xA, "Resposta da 6ª questão:", 0xA, 0x0
    resposta7            db 0xa, 0xA, "Resposta da 7ª questão:", 0xA, 0x0
    ;(1ª QUESTÃO)
    
    ;(2ª QUESTÃO)
    quantidade_letter   db "Quantidade de ", 0x0
    letter_a            db "a", 0x0
    letter_m            db "m", 0x0
    espaco              db " ", 0x0
    dois_pontos         db ":", 0x0
section .bss
    dados_salvos resd 10        ;2ªQ - [0] == quantidade('a'), [1] == quantidade('m'), 3ªQ - [2] == ponteiro para a string original analisada
    entrada resb 100
    ;(1ª QUESTÃO)
    sub_entrada resb 100
    ;(4ª QUESTÃO)
    sub_entrada_concatenada resb 100

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
;FUNÇÃO MAIN()
    call PEGAR_ENTRADA          ;(0ª QUESTÃO)
    call DIVIDIR_STRING         ;(1ª QUESTÃO)
    call ENCONTRAR_A_M          ;(2ª QUESTÃO)
    call INVERTER_STRING        ;(3ª QUESTÃO)
    call CONCATENAR_STRING      ;(4ª QUESTÃO)
    call MAIUSCULA_MENUSCULA    ;(5ª QUESTÃO)
    call POSICAO_ALFA_NUMERICA  ;(6ª QUESTÃO)
    call ORDENAR_MEDIA          ;(7ª QUESTÃO)

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

;//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//

;FUNÇÃO DIVIDIR_STRING: (1ª QUESTÃO)
DIVIDIR_STRING:
    ;linkando os ponteiros de source index e destination index
    mov esi, entrada
    mov edi, sub_entrada

    ;definindo o começo de onde deve ser copiado e quantos caracteres devem ser copiados
    add esi, 9
    mov ecx, 39

    ;fazendo cópia para a sub_string
_loop_movsb:
    movsb
    loop _loop_movsb
    
    ;imprimindo retorno
    PRINT_STRING resposta1
    PRINT_STRING sub_entrada
    ret

;//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//

;FUNÇÃO ENCONTRAR_A_M: (2ª QUESTÃO)
;a quantidade de A's será armazenada no vetor/array dados_salvos[0]
;a quantidade de M's será armazenada no vetor/array dados_salvos[1]
ENCONTRAR_A_M:
    ;contando a letra 'a'   |   parâmetros para chamar a função "encontrar_repeticao_letra:"
    mov edi, sub_entrada
    mov ecx, 100
    mov esi, letter_a
    call encontrar_repeticao_letra
    mov [dados_salvos], edx

    ;contando a letra 'm'   |   parâmetros para chamar a função "encontrar_repeticao_letra:"
    mov edi, sub_entrada
    mov ecx, 100
    mov esi, letter_m
    call encontrar_repeticao_letra
    mov [dados_salvos+4], edx

    ;imprimindo retorno
    PRINT_STRING resposta2
    mov eax, [dados_salvos]
    mov bl, byte [letter_a]
    call imprime_quantidade_letra
    mov eax, [dados_salvos+4]
    mov bl, byte [letter_m]
    call imprime_quantidade_letra
    ret
;________________________________________________________________________________________________________________________________________________________________________________________________
;contagem de quantas letras '*' (qualquer) a string possui
;PARÂMETROS
;mov edi, string_analisada      |   edi = string_analisada
;mov ecx, tamanho_string        |   ecx = tamanho_string
;mov esi, caractere_procurado   |   esi = caractere_procurado
;RETORNO
;edx = quantidade de repetições da letra escolhida
encontrar_repeticao_letra:
    cld
    lodsb
    
    mov edx, 0
_loop:
    scasb
    jne _pula_incremento
    inc edx
_pula_incremento:
    loop _loop
    ret
;________________________________________________________________________________________________________________________________________________________________________________________________
;impressão da resposta
;PARÂMETROS
;mov eax, quantidade_repetições_letra   |   eax = int
imprime_quantidade_letra:
    PRINT_STRING    quantidade_letter
    PRINT_CHAR      bl
    PRINT_CHAR      espaco
    PRINT_CHAR      dois_pontos
    PRINT_CHAR      espaco
    PRINT_DEC 2,    eax
    NEWLINE
    ret

;//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//

;FUNÇÃO INVERTER_STRING: (3ª QUESTÃO)
INVERTER_STRING:
    mov esi, sub_entrada
    add esi, 38
    mov ecx, 38
    std
    PRINT_STRING resposta3
    
_loop1:
    lodsb
    PRINT_CHAR al
    loop _loop1
    
    lodsb
    PRINT_CHAR al
    
    ret

;//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//

;FUNÇÃO CONCATENAR_STRING: (4ª QUESTÃO)
CONCATENAR_STRING:
    cld
    mov edi, sub_entrada
    mov ecx, 100                        ;ecx = 100  |   tamanho da string a ser concatenada
    mov ebx, 0                          ;ebx = 0    |   ponteiro para a última posição analisada da string a ser concatenada    |   em outro momento será passada para o dados_salvos[2] para ser utilizada como um ponteiro para a posição que um determinado valor estaria com a string sem espaços
    mov edx, 0                          ;edx = 0    |   quantidade de espaços na string
    mov esi, espaco                     ;esi = " "
    lodsb                               ;eax = " "  |   utilizaremos esse registrador para comparar e achar os espaços da string com o comando scasb

_concatena_string:
    inc ebx                             ;ebx += 1   |   ponteiro para a posição atual na string
    scasb                               ;compara edi com eax
    je _conta_espaco                    ;se edi == eax então, pula para o label "_conta_espaco:"
                                        ;se não, continua o programa na sequência
    mov [dados_salvos+8], ebx           ;dados_salvos[2] = ebx
    sub ebx, edx                        ;ebx -= edx |   retira a quantidade de espaços que o ponteiro ebx possui, fazendo apontar para uma posição igual (caso não tenha espaços na string) ou anterior (caso tenha espaços na string)
    ;EDI e ESI representam o mesmo conceito aqui, mas o poteiro de verdade é o EDI, o EAX é como se fosse uma cópia de back up. A variável dados_salvos[2] fará esse papel de ser uma cópia de EDI posteriormente
    dec ebx                             ;ebx -= 1   |   como fizemos o comando SCASB o ponteiro já recebeu +1 e está apontando para a próxima posição e não a que comparamos com o EAX  | Esse é uma cópia do valor de EDI
    dec edi                             ;edi -= 1   |   como fizemos o comando SCASB o ponteiro já recebeu +1 e está apontando para a próxima posição e não a que comparamos com o EAX
    mov al, byte [edi]                  ;al = edi   |   recebe a letra a ser copiada para a string concatenada        
    ;PRINT_CHAR al                      ;código para debbug
    mov edi, sub_entrada_concatenada    ;edi = string_concatenada[0]*   |   colocamos o novo endereço para onde faremos uma cópia da letra da string principal
    add edi, ebx                        ;edi += ebx |   ponteiro apontará para a respectiva posicção da letra na string principal subtraída dos espaços
    mov byte [edi], al                  ;edi = "*"  |   string_concatenada recebe a letra na posição correta sem espaço
    mov ebx, [dados_salvos+8]           ;ebx = dados_salvos[2]  |   restaurando o endereço original do ponteiro para a string principal sem espaços
    mov edi, sub_entrada                ;edi = sub_entrada[0]   |   restaurando o ponteiro EDI para o primeiro endereço da string principal
    add edi, ebx                        ;edi += ebx             |   restaurando o ponteiro EDI para o último endereço a ser comparado com o espaço na string principal
    mov esi, espaco                     ;esi = " "
    lodsb                               ;eax = " "  |   os dois últimos passos são necessários para podermos usar o comando SCASB que compara o EDI com o EAX, que nesse caso queremos que seja vazio
    jmp _continua                       ;pula para o label "_continua:", já que não queremos adicionar +1 ao EDX que contabiliza os espaços já comparados na string principal
_conta_espaco:
    inc edx                             ;ecx += 1   |   contabiliza os espaços ja comparados
_continua:
    dec ecx                             ;ecx -= 1   |   próximos passos fazem o controle do loop (percorre todo o tamanho da string)
    cmp ecx, 0                          ;compara ecx com o 0
    jne _concatena_string               ;se ecx == 0 então pula para o label "_concatena_string:"

    ;imprimindo retorno    
    PRINT_STRING resposta4
    PRINT_STRING sub_entrada_concatenada
    ret

;//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//

;FUNÇÃO MAIUSCULA_MENUSCULA: (5ª QUESTÃO)
MAIUSCULA_MENUSCULA:

    ret

;//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//

;FUNÇÃO POSICAO_ALFA_NUMERICA: (6ª QUESTÃO)
POSICAO_ALFA_NUMERICA:

    ret

;//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//

;FUNÇÃO ORDENAR_MEDIA: (7ª QUESTÃO)
ORDENAR_MEDIA:

    ret
    
;//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//