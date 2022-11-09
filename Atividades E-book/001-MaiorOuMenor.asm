%include 'biblioteca.inc'
section .data
    msg1 db 'X maior que Y', LF, NULL
    tam1 equ $- msg1
    msg2 db 'Y maior que X', LF, NULL
    tam2 equ $- msg2
    x dd 60
    y dd 50
section .bss

section .text
global _start
_start:
    mov eax, DWORD [x]
    mov ebx, DWORD [y]
    cmp eax, ebx
    jg xg
    jmp xle

xg:     ;imprime se X for maior que Y
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msg1
    mov edx, tam1
    int SYS_CALL
    jmp fim

xle:    ;imprime se Y for maior ou igual a X    
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, msg2
    mov edx, tam2
    int SYS_CALL
    jmp fim

fim:
    call ending_program