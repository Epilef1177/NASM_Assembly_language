%include biblioteca.inc

section .data
    v1 dw '105', LF, NULL

global _start
_start:
    call converter_valor
    call mostrar_valor

    mov eax, SYS_EXIT
    mov ebx, RET_EXIT
    int SYS_CALL

converter_valor:
    lea esi, [v1]               ;associa a variável 'v1' do .bss com o esi
    mov ecx, 0x3                ;passamos o tamanho da string para a função string_to_int saber a quantidade de loops
    call string_to_int
    add eax, 0x2                ;adicionou 2 só para fazer graça
    ret

mostrar_valor:
    call int_to_string
    call saidaResultado
    ret

;-------------------------------------------|
;---------------String to Int---------------|
;-------------------------------------------|
;Entrada: ESI (valor convertido) ECX (tam)  |
;Saída..: EAX                               |
;-------------------------------------------|
string_to_int:
    xor ebx, ebx                ;ebx = 0
.prox_digitoSI:
    movzx eax, byte[esi]        ;associa dois sub-endereços entre dois registradores (parecido com ponteiro)
    inc esi                     ;seleciona o endereço do dígito desejado
    sub al, '0'                 ;transforma para inteiro
    imul ebx, 0xA               ;ebx = ebx * 10
    add ebx, eax                ;ebc = ebx + eax
    loop .prox_digitoSI         ;while (--ecx)
    mov eax, ebx
    ret

;-------------------------------------------|
;---------------Int to String---------------|
;-------------------------------------------|
;Entrada: Inteiro em EAX                    |
;Saída..: BUFFER(Valor ECX) TAM_BUFFER(EDX) |
;-------------------------------------------|
int_to_string:
    lea esi, [BUFFER]               ;lea => associa uma variável do section.bss com um registrador (parecido com ponteiro)
    add esi, 0x9
    mov byte[esi], 0xA
    mov ebx, 0xA
.prox_digitoIS:
    xor edx, edx
    div ebx
    add dl, '0'
    dec esi
    mov [esi], dl
    test eax, eax
    jnz .prox_digitoIS
    ret