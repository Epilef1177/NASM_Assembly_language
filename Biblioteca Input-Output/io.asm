%include 'biblioteca.inc'
section .data
    msg db 'Digite seu nome: ', 0xA, 0X0
    tam equ $- msg
section .bss
    nome resb 1
section .text
global _start
_start:
mov eax, SYS_WRITE
mov ebx, STD_OUT
mov ecx, msg
mov edx, tam
int SYS_CALL

mov eax, SYS_READ
mov ebx, STD_IN
mov ecx, nome
mov edx, 0xA
int SYS_CALL

mov ecx, nome
mov edx, 0xA
call show_string
call ending_program
