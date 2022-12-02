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
    
    ;(2ª QUESTÃO)
    quantidade_letter   db "Quantidade de ", 0x0
    letter_a            db "a", 0x0
    letter_m            db "m", 0x0
    espaco              db " ", 0x0
    dois_pontos         db ":", 0x0
section .bss
    dados_salvos resd 10        ;2ªQ - [0] == quantidade('a'), [1] == quantidade('m'), 3ªQ - [2] == ponteiro para a string original analisada
    entrada resb 100
    ;(1ª QUESTÃO) && (3ª QUESTÃO) && (5ª QUESTÃO)
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
    add esi, 9      ;esi = 9    |   começo da cópia
    mov ecx, 39     ;ecx = 39   |   fim da cópia

;fazendo cópia para a sub_string
_loop_movsb:
    movsb                       ;edi = esi  |   cópia do conteúdo do endereço do source index da string principal vai para o endereço da string secundária
    loop _loop_movsb            ;ecx -= 1, se ecx != 0 faça o loop
    
    ;imprimindo retorno
    PRINT_STRING resposta1      ;string principal
    PRINT_STRING sub_entrada    ;string cópia
    ret

;//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//

;FUNÇÃO ENCONTRAR_A_M: (2ª QUESTÃO)
;a quantidade de A's será armazenada no vetor/array dados_salvos[0]
;a quantidade de M's será armazenada no vetor/array dados_salvos[1]
ENCONTRAR_A_M:
    ;contando a letra 'a'   |   parâmetros para chamar a função "encontrar_repeticao_letra:"
    mov edi, sub_entrada            ;edi = sub_entrada[0]*  | 1º endereço da string "sub_entrada" vai para o edi, que atua como um ponteiro
    mov ecx, 100                    ;ecx = 100  |   ecx = length da string principal
    mov esi, letter_a               ;esi = letter[0]*   |   esi atua como ponteiro para primeira posição de "letter_a"
    call encontrar_repeticao_letra  ;função que calcula repetição da letra escolhida
    mov [dados_salvos], edx         ;dados_salvos[0] = edx  |   edx contém o retorno da função "encontrar_repetcao_letra:" == quantidade de letras 'a'

    ;contando a letra 'm'   |   parâmetros para chamar a função "encontrar_repeticao_letra:"
    mov edi, sub_entrada            ;edi = sub_entrada[0]*  | 1º endereço da string "sub_entrada" vai para o edi, que atua como um ponteiro
    mov ecx, 100                    ;ecx = 100  |   ecx = length da string principal
    mov esi, letter_m               ;esi = letter[0]*   |   esi atua como ponteiro para primeira posição de "letter_a"
    call encontrar_repeticao_letra  ;função que calcula repetição da letra escolhida
    mov [dados_salvos+4], edx       ;dados_salvos[1] = edx  |   edx contém o retorno da função "encontrar_repetcao_letra:" == quantidade de letras 'a'

    ;imprimindo retorno
    PRINT_STRING resposta2          ;saída pré-definida no .data
    mov eax, [dados_salvos]         ;eax = dados_salvos[0]  |   passando a quantidade de a's pro EAX
    mov bl, byte [letter_a]         ;bl = letter_a[0] *     |   BL == byte [EAX]    |   passando a string "a" para imprimir a resposta bonitinha
    call imprime_quantidade_letra   ;função que imprime os dados bonitinhos

    mov eax, [dados_salvos+4]       ;eax = dados_salvos[1]  |   passando a quantidade de m's pro EAX
    mov bl, byte [letter_m]         ;bl = letter_a[0] *     |   BL == byte [EAX]    |   passando a string "m" para imprimir a resposta bonitinha
    call imprime_quantidade_letra   ;função que imprime os dados bonitinhos
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
    cld                     ;df = 0     |   percorre a string da esquerda para a direita
    lodsb                   ;eax = esi  |   carrega o valor esi para o EAX para ser manipulado posteriormente
    mov edx, 0              ;edx = 0    |   EDX carrega a quantidade de repetições da letra dada como parâmetros no AL (== byte [EAX])
_loop:
    scasb                   ;compara esi com o eax  |   estamos procurando um caractere dentro da string igual ao que está no EAX
    jne _pula_incremento    ;se esi != eax então vai para o label "_pula_incremento:"
    inc edx                 ;edx += 1   |   guarda o valor das repetições do caractere
_pula_incremento:
    loop _loop              ;ecx -= 1   |   controla o laço repetindo até o fim da string
    ret
;________________________________________________________________________________________________________________________________________________________________________________________________
;impressão da resposta
;PARÂMETROS
;mov eax, quantidade_repetições_letra   |   eax = int
imprime_quantidade_letra:               ;concatenações de strings
    PRINT_STRING    quantidade_letter   ;saída pré-definida no .data
    PRINT_CHAR      bl                  ;letra da analisada
    PRINT_CHAR      espaco              ;espaço em branco
    PRINT_CHAR      dois_pontos         ;símbolo de dois pontos
    PRINT_CHAR      espaco              ;espaço em branco
    PRINT_DEC 2,    eax                 ;repetições da letra
    NEWLINE
    ret

;//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//

;FUNÇÃO INVERTER_STRING: (3ª QUESTÃO)
INVERTER_STRING:
    mov esi, sub_entrada        ;esi = sub_entrada[0]*
    add esi, 38                 ;esi = 38   |   38 é a quantidade de caracteres da "sub_entrada"
    mov ecx, 38                 ;ecx = 38   |   38 é a quantidade de caracteres da "sub_entrada"
    std                         ;df = 1     |   set direction   |   percorre a string de trás para frente quando se utiliza as palavras reservadas LOSD, STOS, SCAS e MOVS (que podem ter terminações B, W e D)
    PRINT_STRING resposta3
    
_loop1:
    lodsb                       ;eax = esi* |   recebe conteúdo do ponteiro ESI
    PRINT_CHAR al               ;imprime a string de trás pra frente
    loop _loop1                 ;ecx -= 1   |   se ecx != 0 pula para o label "_loop1:"
    
    lodsb                       ;eax = esi* |   como o loop não executa quando o ecx == 0, fazemos mais uma vez antes de retornar a função
    PRINT_CHAR al               ;print(sub_entrada[0])  |   imprime o valor da primeira posição da string
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
    mov esi, espaco                                 ;esi = espaco[0]*
    lodsb                                           ;eax = esi[0]*
    mov edi, sub_entrada                            ;edi = sub_entrada[0]*
    mov ebx, 0                                      ;ebx = 0                |   Variará entre 0 e 5, quando o ebx <= 2, a letra ficará maiúscula, quando o ebx > 2 a letra continuará menúscula
    mov ecx, 38                                     ;ecx = 38               |   Quantidade total de caracteres na string, útil para não transformar caracteres em lixo eletrônico (caracteres incompreensíveis)
    PRINT_STRING resposta5                          ;imprimindo retorno

_transformar_para_maiuscula:
;verifica se o ponteiro EDI aponta para um caractere " " (espaço)
    scasb                                           ;compara edi com o eax
    je _continua_transformar_para_maiuscula         ;se esi == eax então vai pro label "_continua_transformar_para_maiuscula:", para não transformara a letra em MAIÚSCULA
;verfica se o EBX está entre 1 e 2 - [1,2]
    inc ebx                                         ;ebx += 1   |   EBX é no máximo 5
    cmp ebx, 2                                      ;compara ebx com o 2
    jg _soma_ebx_transformar_para_maiuscula         ;se ebx > 2 então vai para o label "_soma_ebx_transformar_para_maiuscula:", para não transformara a letra em MAIÚSCULA
;imprime os caracteres em MAIÚSCULO quando o EBX estiver entre 1 e 2 - [1,2]
    dec edi                                         ;edi -= 1   |   volta o EDI para a posição em que ele foi comparado, se não vamos pegar o próximo caractere
    mov dl, byte [edi]                              ;dl = edi   |   DL == byte [EDX]    |   caractere da string pronto para ser impresso
    sub dl, 32                                      ;dl -= 32   |   transforma caractere para menúsculo segundo a tabela ASCII
    PRINT_CHAR dl                                   ;imprime o caractere em MAIÚSCULO
    inc edi                                         ;edi += 1   |   avança o EDI um endereço, preparando-o para a próxima comparação
    jmp _continua_transformar_para_maiuscula        ;pula para a label "_continua_transformar_para_maiuscula:" para não alterar o valor do ebx e nem imprimir o caractere novamente
;imprime os caracteres em menúsculo quando o EBX estiver entre 3 e 5 - [3,5]
_soma_ebx_transformar_para_maiuscula:
    dec edi                                         ;edi -= 1   |   volta o EDI para a posição em que ele foi comparado, se não vamos pegar o próximo caractere
    mov dl, byte [edi]                              ;dl = edi   |   DL == byte [EDX]    |   caractere da string pronto para ser impresso
    PRINT_CHAR dl                                   ;imprime o caractere em menúsculo
    inc edi                                         ;edi += 1   |   avança o EDI um endereço, preparando-o para a próxima comparação
    cmp ebx, 5                                      ;compara o ebx com o 5
    jl _continua_transformar_para_maiuscula         ;se o ebx < 5 então pula para o label "_continua_transformar_para_maiuscula:" para não zerar o EBX
    mov ebx, 0                                      ;ebx = 0    |   zera o EBX para manter o controle de qual letra é transformada para MAIÚSCULA ou não
;controle de laço
_continua_transformar_para_maiuscula:
    cmp ecx, 0                                      ;compara o ecx com 0    |   quando ECX == 0 chegou-se no fim da string
    je _fim_transformar_para_maiuscula              ;se ecx == 0 vai para o label "_fim_transformar_para_maiuscula:" e o laço acaba
    dec ecx                                         ;ecx -= 1   |   (des)acumulador de controle
    jmp _transformar_para_maiuscula                 ;pula para o label "_transformar_para_maiuscula:" continuando o laço até zerar o ECX
_fim_transformar_para_maiuscula:                    ;função finalizada e string transformada e impressa 
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