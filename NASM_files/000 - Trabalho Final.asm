;temos registradores adicionais do r8d até o r15d
%include "io.inc"
section .data
    array dd 50, 40, 30, 20, 10
    space db " ", 0x0
    hello db "Hello World!", 0xA, 0x0
    zero db 000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
section .bss
    arrayRD resd 10
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    mov eax, [array]
    mov [arrayRD], eax
    add eax, [array+4]
    PRINT_DEC 2, eax
    PRINT_CHAR space
    PRINT_DEC 2, [arrayRD]
    NEWLINE
    
    mov ecx, 16
    mov ebx, 0
_inverte:
    mov eax, [array+ecx]
    mov [arrayRD+ebx], eax
    sub ecx, 4
    add ebx, 4
    cmp ecx, 0
    jl  _next
    jmp _inverte
    
_next:
    mov ecx, 0
_imprime:
    PRINT_DEC 2, [arrayRD+ecx]
    PRINT_STRING space
    add ecx, 4
    
    cmp ecx, 16
    jg  _next1
    jmp _imprime

_next1:
    PRINT_STRING zero
    PRINT_CHAR   zero
    mov esi, zero
    mov edi, hello
    call size_string
    ;PRINT_CHAR 97
    PRINT_DEC 2, [arrayRD]
    jmp _ending_program
    
;FUNÇÕES    |   PARTE NÃO SEQUENCIAL

;função que mede o coprimento de uma string
size_string:
    ;mov esi, hello |   Isso deve ser feito fora da função para ela poder ser reutilizada
    mov eax, 0
loop_size_string:
    inc eax
    cmpsb
    je end_size_string
    jne loop_size_string
end_size_string:
    mov [arrayRD], eax
    ret
    
_ending_program:
    xor eax, eax
    ret