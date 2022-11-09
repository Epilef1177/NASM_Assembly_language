%include "io.inc"

section .data
    msg1 db 'X maior que Y', 0xA, 0xD
    tam1 equ $- msg1
    msg2 db 'Y maior que X', 0xA, 0xD
    tam2 equ $- msg2
    x dd 60
    y dd 50
section .bss

section .text
global CMAIN
CMAIN:
    mov eax, DWORD [x]
    mov ebx, DWORD [y]
    cmp eax, ebx
    jg xg
    jmp xle

xg:     ;imprime se X for maior que Y
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, msg1
    mov edx, tam1
    int 0x80
    jmp fim

xle:    ;imprime se Y for maior ou igual a X    
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, msg2
    mov edx, tam2
    int 0x80
    jmp fim

fim:
    mov eax, 0xF
    PRINT_DEC 2, eax
    NEWLINE
    PRINT_DEC 2, eax
    NEWLINE
    PRINT_DEC 2, eax
    NEWLINE
    ret