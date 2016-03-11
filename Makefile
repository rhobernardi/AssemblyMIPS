all: run

code:
	#~/Área\ de\ Trabalho/sublime_text_3/sublime_text Makefile jogo_da_forca_vMARS.asm *.txt
	gedit Makefile *.asm

clean:
	@find -name "*~" | xargs rm -rf
	@rm -rf *.log

zip: clean
	@rm -f Trabalho_2.zip
	@zip -r Trabalho_2.zip jogo_da_forca_vMARS.asm jogo_forca_vSPIM.asm Makefile README.txt Mars.jar

run:
	clear
	java -jar Mars.jar jogo_da_forca_vMARS.asm
