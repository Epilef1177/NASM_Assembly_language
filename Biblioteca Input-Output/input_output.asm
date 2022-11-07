%include 'biblioteca.inc'
section .data
    msg db 'Hello World', LF, NULL
    tam_msg equ $- msg
    vector0 dw '100', LF, NULL
    x dd 30
section .bss

section .text
global _start
_start:

;imprimindo string
mov ecx, msg
mov edx, tam_msg
call show_string

;imprimindo qualquer valor em EAX
mov eax, 0x2
call show_value_eax

;imprimindo variável
mov eax, [x]
call show_value_eax

;imprimindo string
lea esi, [vector0]
mov ecx, 0x3
call convert_value_esi
add eax, 0xA
call show_value_eax

;terminando programa
call ending_program