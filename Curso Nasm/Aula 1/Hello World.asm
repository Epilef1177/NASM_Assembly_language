;%include "io.inc"
;COMPILAR: nasm -f elf64 nome_arquivo.asm
;LINKEDITAR: ld -s -o nome_executavel nome_arquivo.o
section .data   ;Define todas as constantes
    msg0 db '', 0xA,0xA
    msg1 db 'Hello World!', 0xA
    tam1 equ $- msg1
    msg2 db 'hello world', 0xA
    tam2 equ $- msg2
    tam0 equ $- msg0
;section .bss    ;Define todas as variáveis

section .text   ;Começa o programa
global _start    ;Label Global
_start:
    ;mov ebp, esp; for correct debugging
    ;write your code here
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, msg1
    mov edx, tam1
    int 0x80
    
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, msg2
    mov edx, tam2
    int 0x80
    
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, msg0
    mov edx, tam0
    int 0x80
    
    
_saida:    
    ;xor eax, eax
    ;ret
    mov eax, 0x1
    mov ebx, 0x0
    int 0x80
