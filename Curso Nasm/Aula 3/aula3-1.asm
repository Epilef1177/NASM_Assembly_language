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
	x dd 10 ; db=1 dw=2 dd=4 dq=4 dt=10
	y dd 50
	msg1 db 'X maior que Y', LF, NULL
	tam1 equ $ -msg1
	msg2 db 'Y maior que X', LF, NULL
	tam2 equ $ -msg2
section .bss
    
section .text
global _start
_start:
	mov eax, DWORD[x]
	mov ebx, DWORD[y]
	;if - condição
	cmp eax, ebx ;Salto condicional
	;je = , jge >= , jg >, jle <= , jl < , jne !=
	jge maior ; eax >= ebx
	mov ecx, msg2
	mov edx, tam2
	;Salto incondicional
	jmp final

maior:
	mov ecx, msg1
	mov edx, tam1

final:
	mov eax, SYS_WRITE
	mov ebx, STD_OUT
	int SYS_CALL

	mov eax, SYS_EXIT
	mov ebx, RET_EXIT ; ou xor ebx, ebx -> == 0
	int SYS_CALL
	







