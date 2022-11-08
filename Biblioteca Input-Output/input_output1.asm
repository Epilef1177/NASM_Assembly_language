%include 'biblioteca.inc'
;nasm -f elf64 input_output1.asm && ld -s -o input_output input_output1.o && ./input_output
;cd GitHub/NASM_Assembly_language/Biblioteca\ Input-Output/
section .data
    msg db 'Hello World', LF, NULL
    tam_msg equ $- msg
    vector0 dw '100', LF, NULL
    x dd 30
section .bss

section .text

;Existem outros registradores de propósito geral que vão de r8d até r15d
global _start
_start:
    xor eax, eax
    mov ecx, 0x5
somador:
    add eax, 0AH
    sub ecx, 1
    cmp ecx, 0x0
    jnz somador
    call show_value_eax
    add eax, 0ah
    ;xor eax, eax
    add eax, 1h
    mov eax, 0x0
    call show_value_eax
    mov eax, 0h
    add eax, 1h
    add eax, 0xA
    add eax, 5h
    call show_value_eax
    call show_value_eax     ;depois que fazemos o chamado do output pro terminal temos que resetar o eax com novo valor, se não ele fica em 10d eternamente
    mov eax, [x]
    mov r8d, eax
    call show_value_eax
    mov eax, r8d
    call show_value_eax
;só podemos fazer o chamado para impressão do eax depois que tivermos feito todas as mudanças necessárias no registrador
    

call ending_program