segment .data
	LF	  		equ 0xA
	NULL	  	equ 0xD
	SYS_CALL  	equ 0x80
	;eax
	SYS_EXIT  	equ 0x1
	SYS_READ  	equ 0x3
	SYS_WRITE 	equ 0x4
	;ebx
	RET_EXIT  	equ 0x0
	STD_IN		equ 0x0
	STD_OUT		equ 0x1

	TAM_BUFFER equ 0xA

segment .bss
	BUFFER resb 0x1

segment .text

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

saidaResultado:
	;jmp  -> GOTO para um ponto
	;call -> GOSUB para um ponto - volta pra chamada depois do ret
	mov eax, SYS_WRITE
	mov ebx, STD_OUT
	mov ecx, BUFFER
	mov edx, TAM_BUFFER
	int SYS_CALL
	ret