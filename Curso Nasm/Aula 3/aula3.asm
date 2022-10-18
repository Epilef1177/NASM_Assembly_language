;%include "io.inc"
;Segment é apenas uma subseção de uma section
segment .data 
    LF          equ 0xA ; Line Feed  - Quebra de linha \n  
    NULL        equ 0xD ; Final de string - Final de String \null 
    SYS_CALL    equ 0x80; Envia informação ao SO
    ; EAX
    SYS_EXIT    equ 0x1 ; Código de chamada para finalizar
    SYS_READ    equ 0x3 ; Operação de Leitura
    SYS_WRITE   equ 0x4 ; Operação de escrita
    ; EBX
    RET_EXIT    equ 0x0 ; Operação realizada com sucesso
    STD_IN      equ 0x0 ; Entrada padrão
    STD_OUT     equ 0x1 ; Saída padrão

section .data
    msg db "Entre com o seu nome: ", LF, NULL
    tam equ $- msg
    
section .bss
    nome resb 1
    
section .text
global _start
_start:

    ;saida
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msg 
    mov edx, tam
    int SYS_CALL
    ;entrada
    mov eax, SYS_READ
    mov ebx, STD_IN
    mov ecx, nome
    mov edx, 0xA
    int SYS_CALL
    ;finaliza programa
    mov eax, SYS_EXIT
    mov ebx, RET_EXIT
    int SYS_CALL

