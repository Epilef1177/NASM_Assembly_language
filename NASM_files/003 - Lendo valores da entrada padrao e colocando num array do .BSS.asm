;Colocar esses valores abaixo no imput
;2 3 4 5 5 5

%include "io.inc"

section .data
msg    db "O vetor foi preenchido com sucesso",0

section .bss
	vetor resd 30

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging

;preparando os registradores com os valores desejados
    xor eax, eax    ;eax = 0
    xor ecx, ecx    ;ecx = 0
    mov ebx, 0      ;ebx = 0
    mov ecx, 6      ;ecx = 6

;recebe valores da entrada padrão, armazena no vetor do .data e imprime eles na saída padrão
inicio: 
    cmp ecx,0                   ;compara ecx com 0
    je fim                      ;se ecx = 0 pula para o label 'fim'
    GET_DEC 2, eax              ;eax = entrada padrão
    mov [vetor+ebx], eax        ;vetor[ebx] = eax
    PRINT_DEC 2,[vetor+ebx]     ;print(vetor[ebx])
    NEWLINE                     ;\n
    add ebx, 2                  ;ebx += 2
    dec ecx                     ;ecx -= 1
    jmp inicio                  ;pula pro label 'inicio'
fim:     
    PRINT_STRING msg            
    NEWLINE
    
;verificamos se todos os valores foram salvos corretamente imprimindo eles na saída padrão
    mov eax, 30                 ;eax = 30 | tamanho inicial do vetor
    mov ebx, 0                  ;ebx = 0  | inicio do vetor que será somado de 2 em 2
nova_impressao:
    cmp eax, 0                  ;compara eax com 0
    je end                      ;se eax = 0 pula para o label 'end'
    dec eax                     ;eax -= 1
    PRINT_DEC 2, [vetor+ebx]    ;print(vetor[ebx])
    NEWLINE                     ;\n
    add ebx, 2                  ;ebx += 2
    jmp nova_impressao          ;pula para o label 'nova_impressão'
end:
    NEWLINE
    NEWLINE
    ret                         ;finaliza o programa
    
    

	