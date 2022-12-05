;ALUNOS: FELIPE DE SANTANA ANGELO FERREIRA (220115562), GUSTAVO JORGE NOVAES SILVA (220216974) e TAUANE PEREIRA SALES (220216969)

;Entrada: Qual e a importancia da escola na democratizacao da sociedade
%include "io.inc"
section .data
    ;(*  QUESTÃO)
    resposta1            db           "Resposta da primeira questao:", 0xA, 0x0
    resposta2            db 0xa, 0xA, "Resposta da segunda questao:", 0xA, 0x0
    resposta3            db      0xA, "Resposta da terceira questao:", 0xA, 0x0
    resposta4            db 0xa, 0xA, "Resposta da quarta questao:", 0xA, 0x0
    resposta5            db 0xa, 0xA, "Resposta da quinta questao:", 0xA, 0x0
    resposta6            db 0xa, 0xA, "Resposta da sexta questao:", 0xA, 0x0
    resposta7            db 0xa, 0xA, "Resposta da setima questao:", 0xA, 0x0
    
    ;(2ª QUESTÃO)
    quantidade_letter   db "Quantidade de ", 0x0
    letter_a            db "a", 0x0
    letter_m            db "m", 0x0
    espaco              db " ", 0x0
    dois_pontos         db ":", 0x0
    
        
    ;(6ª e 7 QUESTÃO)
    rightArrow          db " -> ", 0x0
    virgula             db ", ", 0x0
    msgVetorCrescente   db "Vetor de posicoes em ordem CRESCENTE: ", 0x0
    msgVetorDecrescente db "Vetor de posicoes em ordem DECRESCENTE: ", 0x0
    msgMedia            db "Media do vetor de posicoes: ", 0x0
    frequencyCounter times 26 db 0
    posicoesCrescentes times 36 db 0
    posicoesDecrescentes times 36 db 0
    
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
    add esi, 7      ;esi = 7    |   começo da cópia
    mov ecx, 41     ;ecx = 41   |   fim da cópia

;fazendo cópia para a sub_string
    repe movsb                       ;edi = esi  |   cópia do conteúdo do endereço do source index da string principal vai para o endereço da string secundária
    
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
    add esi, 40                 ;esi = 40   |   40 é a quantidade de caracteres da "sub_entrada"
    mov ecx, 40                 ;ecx = 40   |   40 é a quantidade de caracteres da "sub_entrada"
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
    mov ecx, 40                                     ;ecx = 40               |   Quantidade total de caracteres na string, útil para não transformar caracteres em lixo eletrônico (caracteres incompreensíveis)
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

;SUMÁRIO:
    ;As questões 6 e 7 são baseadas no algoritmo Counting Sort. 
    ;Iremos criar um vetor chamado 'frequencyCounter' com 26 posições. Cada posição refere-se a posição de cada letra no alfabeto.
    ;Iremos percorrer a string 'sub_entrada' e contaremos a quantidade de vezes que cada caractere aparece. 
    ;Essa contagem será feita de maneira ordenada, isto é, a quantidade de a´s ficará na posição 0 do vetor, a quantidade de b's na posição 1 e assim sucessivamente. 
    ;Com esse vetor de frequência em mãos, sabemos com qual caractere estamos trabalhando (por sua ordem no vetor coincidir com a ordem alfabética), a posição do caractere no alfabeto e quantas vezes apareceu na string. 
    
;--------- Passo 1 - Criando o vetor 'frequencyCounter' ---------
;--> Iremos neste passo criar o vetor de frequência de cada caractere na string.

    mov esi, sub_entrada            ;esi = sub_entrada[0]*  | 1º endereço da string "sub_entrada" vai para o esi, que atua como um ponteiro
    mov edi, frequencyCounter       ;edi = frequencyCounter[0]* | edi atua como ponteiro para primeira posição de "frequencyCounter"
    mov ecx, 41                     ;ecx = 41  |   ecx = tamanho da sub_string principal
    cld                             ;df = 0     |   percorre a string da esquerda para a direita
    PRINT_STRING resposta6
    
_loop_lodsb:
    lodsb                           ;eax = esi  |  carrega o valor apontado por esi para o EAX 
    cmp eax, 32                     ;Verificando se o eax contém um espaço. Na tabela ASCII, o espaco corresponde a 32 em decimal. 
    je pulandoEspaco                ;Se em eax contiver o caractere de espaço, nós pulamos uma posição do vetor. 
    sub eax, 97                     ;Encontrando a posição do caractere no vetor. Queremos colocar a frequência de cada caractere de acordo a sua posição alfabética (começando em 0). Temos que na tabela ASCII o 'a' é 97, 'b' 98... Portanto, para saber a posição deles no vetor basta subtrair 97. Assim, 'a' ta na posição 0, 'b' na 1...
    mov edx, edi                    ;Salvando o endereço de edi em edx. Ele será somado ao valor que está em eax para ser endereçado corretamente na posição no alfabeto referente ao caractere. Finalizando o processo, ele deverá voltar a apontar para o início da string. 
    ;Adicionando eax ao edi para edi apontar corretamente para a posição do caractere no alfabeto. Exemplo: seja 'c' o caractere. Temos que ele ficará na posição 2 do alfabeto, assim, 99 (correspondente ao 'c') - 97 = posição 2 no vetor frequencyCounter. Todo 'c' encontrado iremos inc 1 a posição 2 do vetor. 
    add edi, eax
    ;Como não podemos somar 1 diretamente na memória, vamos passar o conteúdo da memoria para ebx, somar ebx e em seguida devolver o conteúdo somado para a memória. 
    mov ebx, [edi]
    inc ebx
    mov [edi], ebx
    ;Após incrementar em 1 o valor contido na posição apontada pelo edi, devemos fazer com que o edi aponte novamente para o início da string. Isso é essencial para encontrarmos as posições dos caracteres no alfabeto. Sempre devemos somar a partir da primeira posição, o 0. 
    mov edi, edx    
        
    pulandoEspaco:                  ;caso eax contenha um espaço, pulamos uma posição no vetor sem processar o caractere. 
    loop _loop_lodsb                ;ecx -= 1, se ecx != 0 faça o loop

;--------- Passo 2 - Imprimindo as posições dos caracteres no alfabeto e Preenchendo o vetor 'posicoesCrescentes' ---------
    
    mov esi, frequencyCounter       ;esi = frequencyCounter[0]*  | 1º endereço do vetor "frequencyCounter" vai para o esi, que atua como um ponteiro
    mov edi, posicoesCrescentes     ;edi = posicoesCrescentes[0]* | edi atua como ponteiro para primeira posição de "posicoesCrescentes"
    mov ecx, 1                      ;Posições dos caracteres no alfabeto. Começando a contar em 1 para terminar em 26, garantindo a ordem usual do alfabeto (começando em 1 e não em 0).
    xor ebx, ebx                    ;Parâmetro da função 'preenchendo_vetor_posicoesCrescentes'
    cld                             ;df = 0     |   percorre a string da esquerda para a direita
    
_loop_lodsb2:                       ;For externo percorrendo o vetor frequencyCounter
    cmp ecx, 26                     ;comparando se ecx = 26
    je _fim_loop_lodsb2             ;se ecx = 26 então chegamos ao final do nosso vetor frequencyCounter e finalizamos o loop.
    
    lodsb                           ;eax = esi  |  carrega o valor apontado por esi para o EAX 
    cmp eax, 0                      ;Se for 0, significa que o caractere da posição em questão (lembre-se: está em ordem alfabética) não apareceu na string. 
    je incrementandoPosicao         ;Sendo eax = 0, devemos simplesmente pular o caractere (não processando-o) e adicionar 1 no ecx. 
     
   
    ;Imprimindo cada caractere e sua respectiva posição no alfabeto
    call imprimir_posicoes
    
    ;Preenchendo o vetor 'posicoesCrescentes'
    call preenchendo_vetor_posicoesCrescentes    
    
    incrementandoPosicao:           ;se eax = 0 devemos pular o caractere e não processar ele. 
    inc ecx                         ;ecx += 1
    jmp _loop_lodsb2   

_fim_loop_lodsb2: 
    call imprimir_posicoes          ;perceba que o loop sai se ecx = 26. Portanto, a última posição do vetor acaba não sendo processada. Essa linha corrige isso, processa o último elemento. 
    lodsb                           ;eax = esi  |  carrega o valor apontado por esi para o EAX  (que é um argumento da função preenchendo_vetor_posicoesCrescentes) 
    call preenchendo_vetor_posicoesCrescentes ;o mesmo acontece aqui. O último elemento acada não sendo adicionado ao vetor posicoesCrescentes. Aqui nós adicionamos ele. 

    ret
;________________________________________________________________________________________________________________________________________________________________________________________________
;Recuperando o caractere e imprimindo-o juntamente com sua posição no alfabeto. 
;PARÂMETROS
;mov edx, posição_do_caractere_no_alfabeto (ecx) |   edx = ecx
;RETORNO
;vazio -> Apenas estamos imprimindo no console.     
 
imprimir_posicoes:
    ;Recuperando o caractere presente em a cada posição do vetor frequencyCounter.
        ;Exemplo: caractere da posição 0: letra 'a' (ecx + 96), caractere da posição 2: letra 'c' (ecx + 96)... Neste caso temos que ecx começa em 1. Então, 1 + 96 = 97 (letra 'a' na tabela ASCII) e assim sucessivamente.
    
    mov edx, ecx                    ;edx = ecx
    add edx, 96                     ;edx = edx + 96. Comando necessário para recuperar o caractere da posição 'ecx + 96' da tabela ASCII. 
    sub edx, 32                     ;edx = edx - 32. Com o caractere já recuperado e armazenado em edx, para ficar de acordo com o exemplo presente no enunciado queremos obter a letra maiúscula. Para isso, basta subtrair 32. 
    PRINT_CHAR edx                  ;Imprimindo caractere maiúsculo
    PRINT_STRING rightArrow         ;Imprimindo seta para direita: ' -> '  
    PRINT_DEC 2, ecx                ;Imprimindo posição do caractere no alfabeto
    PRINT_STRING virgula            ;Imprimindo vírgula
     
    ret
;________________________________________________________________________________________________________________________________________________________________________________________________
;Preenchendo o vetor 'posicoesCrescentes' com as posições dos caracteres no alfabeto (ordenado crescentemente)
;PARÂMETROS
;mov edi, string_analisada      |   edi = string_analisada | Definido no início da função 'POSICAO_ALFA_NUMERICA'
;mov ebx, contador_dfrequencia_de_cada_letra   |   ebx = quantidade de vezes que cada letra apareceu na string_analisada | Resetado antes de entramos na função
;mov [edi+ebx], posição_do_caractere_no_alfabeto (ecx) |   ecx = ecx | Perceba que ebx é incrementado a cada iteração
;RETORNO
;edi = vetor 'posicoesCrescentes' preenchido de forma crescente

preenchendo_vetor_posicoesCrescentes:

    _loop_preenche_posicoesCrescentes: ;For prenchendo o vetor 'posicoesCrescentes'. Em cada posição do vetor 'frequencyCounter' nós obtemos a posição do caractere no alfabeto e a quantidade de vezes em que apareceu. 
    ;Com isso, preenchemos o vetor 'posicoesCrescentes' com a posição do caractere eax vezes.   
            mov [edi+ebx], ecx      ;Movendo para cada posição '[edi+ebx]' no vetor posicoesCrescentes a posição do caractere no alfabeto
            inc ebx                 ;ebx = ebx +1
            dec eax                 ;eax = eax - 1. 'eax' armazena o conteúdo de cada elemento do vetor frequencyCounter, que se refere a frequencia que cada caractere apareceu na string.
            jnz _loop_preenche_posicoesCrescentes ;jump enquanto eax!=0
    ret

;//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//

;FUNÇÃO ORDENAR_MEDIA: (7ª QUESTÃO)
ORDENAR_MEDIA:
    PRINT_STRING resposta7
;--->Imprimindo o vetor 'posicoesCrescentes' | parâmetros para chamar a função "imprimindo_vetor_posicoesCrescentes:"
   
    mov esi, posicoesCrescentes     ;esi = posicoesCrescentes[0]*  | 1º endereço do vetor "posicoesCrescentes" vai para o esi, que atua como um ponteiro
    mov ecx, 36                     ;ecx = 35, tamanho do vetor posicoesCrescentes
    call imprimindo_vetor_posicoesCrescentes
    
    
   ;---> Ordenando o vetor de posições de forma decrescente. 
        ;Para isso, basta percorremos o vetor 'posicoesCrescentes' da direta para a esquerda (de trás para frente). A cada iteração nós copiamos o conteúdo do vetor 'posicoesCrescentes' para o vetor 'posicoesDecrescentes'
        
    mov esi, posicoesCrescentes     ;esi = posicoesCrescentes[0]*  | 1º endereço do vetor "posicoesCrescentes" vai para o esi, que atua como um ponteiro
    add esi, 35                     ;esi = 35 |   35 é a última posição do vetor 'posicoesCrescentes'
    mov edi, posicoesDecrescentes   ;edi = posicoesDecrescentes[0]* | edi atua como ponteiro para primeira posição de "posicoesDecrescentes"
    mov ecx, 36                     ;ecx = 36, tamanho do vetor posicoesCrescentes
    xor ebx, ebx                    ;usando ebx como contador. É ele que utilizaremos para incrementar o edi a cada iteração sob o vetor 'posicoesDecrescentes'
    std                             ;df = 1     |   set direction   |   percorre a string de trás para frente quando se utiliza as palavras reservadas LOSD, STOS, SCAS e MOVS (que podem ter terminações B, W e D)
    
    ;Observação: Perceba que estamos percorrendo o vetor 'posicoesCrescentes' da direita para a esquerda e estamos percorrendo o vetor 'posicoesDecrescentes' da esquerda para a direita.
    
    _loop_reverse_vector:
        lodsb                       ;eax = esi  |  carrega o valor apontado por esi para o eax. eax contém o conteúdo de 'posicoesCrescentes' da direita para a esquerda (do maior para o menor).
        mov [edi+ebx], eax          ; movemos o conteúdo de eax para a posição [edi+ebx] do vetor 'posicoesDecrescentes'. Lembre-se: este vetor está sendo percorrido da esquerda para a direita.  
        inc ebx                     ;ebx = ebx + 1
        dec ecx                     ;ecx = ecx + 1
        jnz _loop_reverse_vector    ;jump enquanto ecx!=0
       
     ;--->Imprimindo o vetor 'posicoesDecrescentes' e somando, a cada iteração, seus elementos. A soma final ficará salva em edx para em seguida obtermos a média. 
     
     mov esi, posicoesDecrescentes  ;esi = posicoesDecrescentes[0]*  | 1º endereço do vetor "posicoesDecrescentes" vai para o esi, que atua como um ponteiro
     mov ecx, 36                    ;ecx = 36, tamanho do vetor posicoesDecrescentes
     xor edx, edx                   ;edx será usado como um acumulador. Para isso, nós o resetamos. 
     cld                            ;df = 0     |   percorre a string da esquerda para a direita
        
     PRINT_STRING msgVetorDecrescente ;saída pré-definida no .data
     NEWLINE
    
     _loop_printVetorReverse:
         lodsb                      ;eax = esi  |  carrega o valor apontado por esi para o eax. eax contém o conteúdo de 'posicoesCrescentes' da direita para a esquerda (do maior para o menor).
         PRINT_DEC 2, eax           ;imprimindo o conteúdo de eax.
         PRINT_STRING virgula       ;saída pré-definida no .data
         add edx, eax               ;edx = edx + eax. Aqui temos o processo de soma dos elementos do vetor. 
         dec ecx                    ;ecx = ecx - 1
         jnz _loop_printVetorReverse ;jump enquanto ecx!=0
            
         NEWLINE
         NEWLINE
 
     ;--->Obtendo a média. 
        ;Com o valor da soma no edx, basta dividirmos o valor em edx pelo tamanho do vetor e obtemos a média.
        
     mov eax, edx                   ;A divisão sempre é feita com o operando no eax. 
     mov ebx, 36                    ;A divisão sempre é feita com o operador no ebx.
     cdq                            ;Estendendo o sinal do operando para edx.
     idiv ebx                       ;Realizando a divisão e salvando o resultado em eax
     PRINT_STRING msgMedia          ;saída pré-definida no .data
     PRINT_DEC 2, eax               ;imprimindo a média
     

    ret
    
;________________________________________________________________________________________________________________________________________________________________________________________________
;Imprimindo o vetor 'posicoesCrescentes'
;PARÂMETROS
;mov esi, vetor_analisado      |   esi = vetor_analisado
;mov ecx, tamanho_do_vetor     |   ecx = tamanho do vetor posicoesCrescentes
;RETORNO
;vazio -> Apenas estamos imprimindo no console.     

imprimindo_vetor_posicoesCrescentes:
    PRINT_STRING msgVetorCrescente  ;saída pré-definida no .data
    NEWLINE
    cld                             ;df = 0     |   percorre a string da esquerda para a direita
    
    _loop_printLodsb:
        lodsb                       ;eax = esi  |  carrega o valor apontado por esi para o eax.
        PRINT_DEC 2, eax            ;imprimindo o conteúdo de eax.
        PRINT_STRING virgula        ;saída pré-definida no .data
        dec ecx                     ;ecx = ecx - 1
        jnz _loop_printLodsb        ;jump enquanto ecx!=0
        
        NEWLINE
        NEWLINE
    ret
    
;//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//-/-//