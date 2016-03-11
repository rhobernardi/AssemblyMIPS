
# COMPILAÇÃO DE PROGRAMAS ASSEMBLY MIPS - SIMULADOR MARS

Usei o Simulador MARS para fazer o Jogo da Forca. Testei no simulador SPIM tambem e o jogo roda perfeitamente,
mas talvez seja necessario ficar abaixando a barra de rolagem do console todo tempo.
Caso queira rodar no Mars, deixei um arquivo Makefile pronto para rodar os programas por ele, que não necessita 
instalação, apenas ter o Java instalado é o suficiente. Roda tanto em Windows quanto em Linux, o comando de execução 
é o mesmo por ser através do Java, porem em Linux é mais facil pelo Makefile e no Windows o comando deve ser digitado 
manualmente.

Para rodar o jogo pelo SPIM, deve ser usado o arquivo jogo_forca_vSPIM.asm pois seu montador é um pouco diferente do
do Simulador MARS.

Abaixo segue o procedimento para compilar através do MARS:


Em Linux:
1- Descompactar arquivos e deixá-los na mesma pasta;

2- Abrir o terminal, ir na pasta em que os arquivos foram descompactados;

3- Há um arquivo Makefile junto do codigo de programa em Assembly MIPS e do pacote do simulador;

4- No terminal, digitar "make" e aguardar a execução do programa. Para abrir os arquivos, basta digitar "make code".


Em Windows:
1- Descompactar arquivos e deixá-los na mesma pasta;

2- Abrir o cmd, ir na pasta em que os arquivos foram descompactados;

3- Digitar o comando "java -jar Mars.jar jogo_da_forca_vMARS.asm" no cmd e aguardar a execução.