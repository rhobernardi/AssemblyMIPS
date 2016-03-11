
ASM = jogo_da_forca_vMARS.asm
SIM = Mars.jar
OTHERS = Makefile README.md jogo_forca_vSPIM.asm

all: run

code:
	#~/Área\ de\ Trabalho/sublime_text_3/sublime_text Makefile jogo_da_forca_vMARS.asm *.txt
	gedit Makefile *.asm

clean:
	@find -name "*~" | xargs rm -rf
	@rm -rf *.log

zip: clean
	@rm -f JogoDaForca.zip
	@zip -r JogoDaForca.zip $(ASM) $(SIM) $(OTHERS)

run:
	clear
	java -jar $(SIM) $(ASM)
