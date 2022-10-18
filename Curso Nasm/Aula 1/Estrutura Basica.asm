    ;;compilador
        ;nasm -f elf64 'nome.programa'
    ;Linkeditar - transformar o progrma de linguagem de máquina para um executável
        ;ld -s -o 'nomeprogramabin' 'nomeprogramabin.o'
%include "io.inc"
section .data   ;Define todas as constantes
    ;apontamento apontam pra espaços na memória
    msg db 'Hello World!'
    tam equ $- msg ;conta a quantidade de caracteres para a qual a label aponta
section .bss    ;Define todas as variáveis

section .text   ;Começa o programa
global CMAIN    ;Label Global
CMAIN:
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, msg
    mov edx, tam
    int 0x80
    ;ret
    ;write your code here
    ;xor eax, eax
    mov eax, 0x1 ; SO estou terminando o programa
    mov ebx, 0x0 ; SO o valor de retorno é 0
    int 0x80     ; termina o programa
    ;ret
