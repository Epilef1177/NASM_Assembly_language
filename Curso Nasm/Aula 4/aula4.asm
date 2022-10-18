%include 'biblioteca.inc'

section .text

global _start

_start:
	;Unindo vetor buffer com registrador esi e trasformando em string
	lea esi, [BUFFER]	;Load Effective Address
	add esi, 0x9 		;Na tabela hex 0x9 é o começo de uma string
	mov byte[esi], 0xA 	;Definimos o final da string com LF = \n. esi = '\n'
	
	;Adicionando valores de trás pra frente em nossa pilha esi/buffer
	dec esi			;Vamos para a primeira posição da sring. 'x\n' onde está o x
	mov dl, 0x11		;Colocamos a letra A(0x11-ASCII) em dl. a(0x31).
	add dl, '0'		;Transformamos o valor inteiro de dl em string
	mov [esi], dl		;Colocamos o valor em string de dl na posição em que fizemos o dec(decremento)
	
	dec esi
	mov dl, 0x12		;B(0x11)
	add dl, '0'
	mov [esi], dl

	dec esi
	mov dl, 0x16		;F(0x16)
	add dl, '0'
	mov [esi], dl

	dec esi
	mov dl, 0x25
	add dl, '0'
	mov [esi], dl

	;chamada retornara "UFBA", pois adicionei todos os valores no BUFFER por meio do link com o esi
	call saidaResultado 	;Faz a chamada da "função"(não existe em assembly) na biblioteca.inc e retorna ao programa atual

	;retorno_fim
	mov eax, SYS_EXIT
	mov ebx, RET_EXIT
	int SYS_CALL
