;substitui os espaços em branco da string de label "msg" e e põe *
%include "io.inc"
section .data
    ;sapce = string que compararemos para verificar os espaços
    space db "                                                                                                                                 ", 0
    star db "*", 0          ;star = *   |   o asterístico deve substituir os espaços
    msg db "Do you speak english? No?!", 0  ;frase a ter os espaços substituídos
    tam equ $- msg  ;tamanho da string msg
section .text
global CMAIN
CMAIN:

    mov ecx, tam            ;ecx = length de msg
    mov eax, 0              ;eax = 0    |   eax guardará o valor da posição na string que está sendo comparada
_start:
    mov esi, space          ;esi = " "  |   esi é o ponteiro para space
    mov edi, msg            ;edi = "D"  |   edi é o ponteiro para msg
    add esi, eax            ;esi += eax |   o eax redireciona o ponteiro caso ele tenha perdido a localização do endereço
    add edi, eax            ;edi += eax |   o eax redireciona o ponteiro caso ele tenha perdido a localização do endereço
_fixing_space:
    inc eax                 ;eax++      |   o eax é incrementado de um em um byte para salvar o ponteiro para a localização atual na string
    cmpsb                   ;esi == edi |   compara os caracteres em nos dois registradores especiais
    je fixing               ;se esi == edi então pula pra função fixing
    loop _fixing_space      ;caso contrário, volta pro loop sem fazer nada no label "_fixing_space"
    jmp _ending_program     ;após retirar todos os espaços e substituir por asterístico vai para o fim do programa

;substitui o espaço por asterístico
fixing:
    mov esi, star           ;esi = "*"  |   símbolo para substituir o espaço
    dec edi                 ;edi--      |   como no último comando 'cmpsb' somou +1 ao ponteiro edi, o edi não aponta mais para o vazio, tendo que voltar um byte
    movsb                   ;edi = esi  |   espaço recebe asterístico
    PRINT_STRING msg
    NEWLINE 
    jmp _start              ;retorna para a função principal à procura de novos espaços
    
_ending_program:
    xor eax, eax
    ret