
# ASSEMBLY MIPS - SIMULADOR MARS

Usei o Simulador MARS para fazer o Jogo da Forca. Testei no simulador SPIM também e o jogo roda perfeitamente,
mas talvez seja necessário ficar abaixando a barra de rolagem do console o tempo todo.
Caso queira rodar no MARS, deixei um arquivo Makefile pronto para rodar os programas por ele, que não necessita 
instalação, apenas ter o Java instalado é o suficiente. Roda tanto em Windows quanto em Linux, o comando de execução 
é o mesmo por ser através do Java, porem em Linux é mais facil pelo Makefile e no Windows o comando deve ser digitado 
manualmente.

Para rodar o jogo pelo SPIM, deve ser usado o arquivo 'jogo_forca_vSPIM.asm' pois seu montador é um pouco diferente do
do Simulador MARS.

Abaixo segue o procedimento para compilar através do Simulador MARS:


- Em Linux:

1- Descompactar arquivos e deixá-los na mesma pasta;

2- Abrir o terminal, ir na pasta em que os arquivos foram descompactados;

3- Há um arquivo Makefile junto do codigo de programa em Assembly MIPS e do pacote do simulador;

4- No terminal, inserir comando abaixo e aguardar a execução:
	
	$ make 

NOTA: Para abrir os arquivos de codigo (será necessario caso queira mudar a palavra secreta), basta inserir comando:
	
	$ make code


- Em Windows:

1- Descompactar arquivos e deixá-los na mesma pasta;

2- Abrir o cmd, ir na pasta em que os arquivos foram descompactados;

3- Inserir o comando abaixo no 'cmd' e aguardar a execução:

	C:\folder_name> java -jar Mars.jar jogo_da_forca_vMARS.asm