
#*******************************************************************#
#																	#
#				Organizacao de Computadores Digitais				#
#																	#
#					Trabalho 2	- Jogo da Forca						#
#																	#
#																	#
#			   - Rodrigo das Neves Bernardi  8066395				#
#																	#
#*******************************************************************#


#==================================================      DATA IN MEMORY      ==================================================#

	.data
title: .asciiz "\n\t\t\t    <<<< JOGO DA FORCA >>>>\n\n"				#(string) 	titulo
pedido: .asciiz "\n\n\n\t\t\t     == Digite uma letra ==\n\t\t\t\t         "			#(string) 	para pedir a letra a ser digitada
pedido2: .asciiz " resp: "

palavra: .asciiz "DICOTILEDONIA" #	<--- MUDAR AQUI					#(string) 	palavra chave do jogo em maiuscula(jogo possui
																	#           conversor de letra digitada para maiuscula)

tam_palavra: .half 13 #				<--- MUDAR AQUI					#(short int) tamanho da palavra chave - armazena inteiro
letra: .space 2 													#(char)		letra digitada - armazena caractere

flag: .space 2														#(short int) flag para erro - 0 se tiver erro, 1 caso contrario

str_erros: .asciiz "\n\nErros: "
array_erros: .space 7				  								#(char[7])	vetor com caracteres errados e espacos - vetor de caracteres
array_acertos: .space 50											#(char[tam_palavra])vetor com caracteres certos - vetor de caracteres

limpa_tela: .asciiz "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"	#(string) 	limpa a tela
espacamento: .asciiz "\t\t\t\t  "
new_line: .asciiz "\n"

#(string) 	desenho da forca e do boneco
forca0: .asciiz "\n\n    |------------|\n    |            |\n    |            |\n    |             \n    |\n    |\n    |\n    |\n  -----\n\n"
forca1: .asciiz "\n\n    |------------|\n    |            |\n    |            |\n    |            O\n    |\n    |\n    |\n    |\n  -----\n\n"
forca2: .asciiz "\n\n    |------------|\n    |            |\n    |            |\n    |            O\n    |            |\n    |\n    |\n    |\n  -----\n\n"
forca3: .asciiz "\n\n    |------------|\n    |            |\n    |            |\n    |            O\n    |           /|  \n    |\n    |\n    |\n  -----\n\n"
forca4: .asciiz "\n\n    |------------|\n    |            |\n    |            |\n    |            O\n    |           /|\\ \n    |\n    |\n    |\n  -----\n\n"
forca5: .asciiz "\n\n    |------------|\n    |            |\n    |            |\n    |            O\n    |           /|\\ \n    |           /\n    |\n    |\n  -----\n\n"
forca6: .asciiz "\n\n    |------------|\n    |            |\n    |            |\n    |            O\n    |           /|\\ \n    |           / \\ \n    |\n    |\n  -----\n\n"

win: .asciiz "\n\n\n\t\t\t\tVENCEU! \n\n"											#(string) 	vitoria
lose: .asciiz "\n\n\n\t\t\t\tPERDEU... \n\n"										#(string) 	derrota



	.text
	.globl main

#==================================================       THE GAME       ==================================================#
main:
		#contador de letras erradas comecando em 0 e vai ate 6
		li 		$s0, 0
		#contador de letras certas comecando em 0 e vai ate 6
		li 		$s4, 0
		
		#preenche arrays com espacos
		la 		$a0, array_acertos
		lh 		$a1, tam_palavra
		jal preenche_array

		la 		$a0, limpa_tela
		li 		$v0, 4
		syscall
		
		#comeca o jogo
		j GAME

#==================================================       THE GAME       ==================================================#
GAME:
		#carrega ponteiro para a palavra chave e o tamanho dela
		la 		$s1, palavra
		lh 		$s2, tam_palavra
		
		#printa titulo e forca
		jal print_game

		#printa quantidade de letras certas e erradas em baixo da forca
		jal print_arrays

		#pede a letra para o jogador
		la 		$a0, pedido
		li 		$v0, 4
		syscall
		
		#la 		$a0, limpa_tela
		#li 		$v0, 4
		#syscall
		
		#le a letra do teclado
		la 		$a0, letra
		li 		$a1, 2 									# tam 2 por causa do char e do '\0'
		li 		$v0, 8
		syscall

		#carrega a letra para converter em maiuscula
		la 		$t0, letra
		lb 		$a0, ($t0)
		jal convert

		#compara letra com as letras da palavra e coloca nos arrays
		la 		$a0, letra 				#letra
		move 	$a1, $s1				#pointer palavra chave
		move 	$a2, $s2				#tamanho da palavra chave
		jal compara

		la 		$a0, limpa_tela
		li 		$v0, 4
		syscall
		
		#Confere se perdeu vendo a quantidade de erros. Se teve 6 erros, perde.
		li 		$t4, 6
		beq 	$s0, $t4, print_LOSE

		#Se não, ve se a quantidade de letras que acertou é a mesma do tamanho da palavra. Se não, joga de novo
		move 	$t0, $s2
		blt $s4, $t0, GAME

		#Se sim, ganhou o jogo.
		j print_WIN
#==================================================      END GAME      ==================================================#







#==================================================       SUBROUTINES      ==================================================#

# Confere se o caractere eh uma letra minuscula. Se sim, converte pra maiuscula.
# Se nao, ve se é uma letra maiuscula. Se sim, apenas coloca na memoria.
# Se nao for letra, nao acontece nada.

convert:							# Input: A0 (To Be Converted)
		li 		$t0,0x61			# Letter 'a' (ASCII)
		li 		$t1,0x7A			# Letter 'z' (ASCII)
		
		li 		$t8,0x41			# Letter 'A' (ASCII)
		li 		$t9,0x5A			# Letter 'Z' (ASCII)

		li 		$t2,0x20			# Distance from 'a' to 'A'
		la 		$t5, letra
		move 	$t4,$a0 			# Separate each letter (4 bytes = 4 char)
		
		blt 	$t4,$t0,pula1   	# Less than 'a',    do nothing
        bgt 	$t4,$t1,pula1		# Greater than 'z', do nothing
		sub 	$t4,$t4,$t2     	# Covert lower case to upper case

		move 	$a0,$t4	    		# Return: A0 (converted)
		
		sb 		$a0, ($t5)

		jr  $ra						# Return

pula1:
		blt $t4,$t8,pula   			# Less than 'A',    do nothing
        bgt $t4,$t9,pula			# Greater than 'Z', do nothing
		
		sb 	$a0, ($t5)

		jr  $ra						# Return
		
pula:
		la 		$a0, limpa_tela
		li 		$v0, 4
		syscall	

	j GAME

#================================================== COMPARE SUBROUTINE ==================================================#
# Compara a letra digitada com a string de palavra chave.
# Se houver letras iguais, o vetor de acertos é preenchido com essa letra em todas as posicoes que a palavra chave tiver
#e conta os acertos de acordo com o numero de vezes que a letra foi colocada no vetor.

# Se nao, coloca a letra no vetor de erros e soma um erro para o jogador.

compara:
		lb		$t0, ($a0)				#letra
		move 	$t1, $a1				#pointer palavra chave
		move 	$t2, $a2				#tamanho da palavra chave
		
		la 		$a2, array_erros 		#pointer array_erros
		move 	$a3, $a2 

		li 		$t9, 0 					#$t9 � flag de acerto
		la 		$t7, flag
		sh 		$t9, ($t7)
		
		loop_cmp:
				sub 	$t4, $t1, $a1

				lb 		$t3, ($t1) 		#letra da palavra chave na posicao ($t1)
				beq 	$t3, $t0, confere

			retorno:
				addi 	$t1, $t1, 1
				bne 	$t2, $t4, loop_cmp
				
				lh 		$t9, flag
				beq 	$t9, $zero, confere_erros
				

			retorno2:
				jr $ra

confere:
		li 		$t6, '-'
		
		move 	$t7, $a1
		sub 	$t7, $t1, $t7
		la 		$t8, array_acertos
		
		add 	$t8, $t8, $t7
		lb		$t7, ($t8)

		beq 	$t6, $t7, put_array_acertos
		bne 	$t6, $t7, put_array_acertos_sem_soma

		j retorno


put_array_acertos:
		la 		$t7, flag
		li  	$t9, 1
		sh 		$t9, ($t7)

		move 	$t7, $a1
		sub 	$t7, $t1, $t7

		la 		$t8, array_acertos
		add 	$t8, $t8, $t7

		sb 		$t3, ($t8)

		addi 	$s4, $s4, 1

		j retorno

#Se a letra ja houver sido digitada, eh colocada por cima novamente mas nao eh contado ponto
put_array_acertos_sem_soma:
		la 		$t7, flag
		li  	$t9, 1
		sh 		$t9, ($t7)

		move 	$t7, $a1
		sub 	$t7, $t1, $t7

		la 		$t8, array_acertos
		add 	$t8, $t8, $t7

		sb 		$t3, ($t8)

		j retorno

# Se houver erros, coloca no array de erros
confere_erros:
		la 		$t8, array_erros
		la 		$t7, array_erros
		move 	$t4, $s0

		beq 	$t4, $zero, put_array_erros

		loop_confere_erros:

			sub 	$t9, $t8, $t7
			lb 		$t6, ($t8)
			beq 	$t0, $t6, retorno2
			beq		$t9, $t4, put_array_erros

			addi 	$t8, $t8, 1

			j loop_confere_erros


put_array_erros:
		sb 		$t0, ($t8)
		addi 	$s0, $s0, 1

		j retorno2


#==================================================       PREENCHE SUBROUTINE       ==================================================#
# Preenche inicialmente o array de acertos com traços indicando a quantidade de letras que a palavra possui.
preenche_array:
		move 	$t0, $a0			#pointer do array
		move 	$t1, $a1			#tamanho
		li		$t2, '-'
		addi 	$t1, $t1, -1

		loop_p:							#loop para preencher o array
			sub 	$t3, $t0, $a0
			sb 		$t2, ($t0)
			beq 	$t3, $t1, sai_loop_p
			
			addi 	$t0, $t0, 1
			
			j loop_p
			
		
		sai_loop_p:
			
			jr $ra
			
		


#==================================================       PRINT SUBROUTINES       ==================================================#
# Print do cenario, titulo e vetores estão todos aqui.
print_game:
	
		la 		$a0, title
		li 		$v0, 4
		syscall

		move 	$t0, $s0

	#compara com o numero de vidas e printa a forca com a parte do boneco correspondente
		li 		$t1, 0
		beq 	$t0, $t1, forca_0

		li 		$t1, 1
		beq 	$t0, $t1, forca_1

		li 		$t1, 2
		beq 	$t0, $t1, forca_2

		li 		$t1, 3
		beq 	$t0, $t1, forca_3

		li 		$t1, 4
		beq 	$t0, $t1, forca_4

		li 		$t1, 5
		beq 	$t0, $t1, forca_5

		li 		$t1, 6
		beq 	$t0, $t1, forca_6

	end_print:
		jr $ra

# A selecao das strings pra printar o boneco eh feita atraves da analise da quantidade de erros que o jogador possui
forca_0:
		la 		$a0, forca0 		#forca
		li 		$v0, 4
		syscall

	j end_print

forca_1:
		la 		$a0, forca1  		#cabeca do boneco
		li 		$v0, 4
		syscall

	j end_print

forca_2:
		la 		$a0, forca2 		#torso do boneco
		li 		$v0, 4
		syscall

	j end_print

forca_3:
		la 		$a0, forca3 		#braco direito do boneco
		li 		$v0, 4
		syscall

	j end_print

forca_4:
		la 		$a0, forca4 		#braco esquerdo do boneco
		li 		$v0, 4
		syscall

	j end_print

forca_5:
		la 		$a0, forca5 		#perna direita do boneco
		li 		$v0, 4
		syscall

	j end_print

forca_6:
		la 		$a0, forca6 		#perna esquerda do boneco
		li 		$v0, 4
		syscall

	j end_print


# Imprime os vetores na tela vazios ou não.
print_arrays:
		la 		$a0, espacamento
		li 		$v0, 4
		syscall

		la 		$a0, array_acertos
		move 	$a1, $s2
		j		print_acertos
		
		ret1:
		la 		$a0, str_erros
		li 		$v0, 4
		syscall

		la 		$a0, array_erros
		li		$a1, 6
		j		print_erros
		
		ret2:

		jr $ra

# Imprime os acertos.
print_acertos:
		move 	$a3, $a0   	
		move 	$t0, $a3	#pointer array

		move 	$t2, $a1	#tamanho do array

		loop_acertos:
				sub 	$t4, $t0, $a3

				lb 		$t3, ($t0) 									#letra da palavra chave na posicao ($t1)

				move 	$a0, $t3
				li 		$v0, 11
				syscall

				addi 	$t0, $t0, 1
				bne 	$t2, $t4, loop_acertos

		j ret1

# Imprime os erros.
print_erros:
		move 	$a3, $a0   	
		move 	$t0, $a3	# $t0 eh pointer array

		move 	$t2, $a1	# $t2 eh tamanho do array

		loop_erros:
				sub 	$t4, $t0, $a3

				lb 		$t3, ($t0) 									#letra da palavra chave na posicao ($t1)

				move 	$a0, $t3
				li 		$v0, 11
				syscall

				li 		$a0, ' '
				li 		$v0, 11
				syscall

				addi 	$t0, $t0, 1
				bne 	$t2, $t4, loop_erros

		j ret2

# Imprime a mensagem de que o jogador perdeu o jogo.
print_LOSE:
		jal print_game

		la 		$a0, lose
		li 		$v0, 4
		syscall

		j end_program

# Imprime a mensagem de que o jogador ganhou o jogo.
print_WIN:
		jal print_game

		jal print_arrays

		la 		$a0, win
		li 		$v0, 4
		syscall

		j end_program


#==================================================       END PROGRAM - HALT       ==================================================#
# Halt no programa.
end_program:
		li 		$v0, 10
		syscall

