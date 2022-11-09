NOME = 001-MaiorOuMenor

all: $(NOME).o
	ld -s -o $(NOME).bin $(NOME).o
	rm -rf *.o;

%.o: %.asm
	nasm -f elf64 $<

