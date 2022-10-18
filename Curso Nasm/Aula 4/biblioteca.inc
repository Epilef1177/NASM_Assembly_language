segment .data
	LF	  	equ 0xA
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

saidaResultado:
	;jmp  -> GOTO para um ponto
	;call -> GOSUB para um ponto - volta pra chamada depois do ret
	mov eax, SYS_WRITE
	mov ebx, STD_OUT
	mov ecx, BUFFER
	mov edx, TAM_BUFFER
	int SYS_CALL
	ret
