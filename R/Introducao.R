

# Plano da Disciplina -----------------------------------------------------


#1)introducao a ciencia aberta
#2)organizacao dos projetos de analise
#3)Organizacao, formatacao e limpeza de dados
#4)analise exploratoria de dados
#5)graficos
#6)relatorios reproduziveis em R
#7)R para biologos




# Introducao --------------------------------------------------------------

#Al?m da coleta dos dados: o dado ? o meta-dado, ou seja, onde, quando, como, todos os detalhes sao extremamente importantes
#Software Zotero - tipo o Mendeley, para gerenciar a bibliografia
#Software git - para controlar as versoes dos seus projetos
#Software ImageJ ou GIMP - para processar imagens

#Dryad - repositorio que as revistas pedem pra uploadear os dados ou c?digo usado





# Organizacao dos projetos de analise -------------------------------------

#Repositorio oficial: CRAN (Comprehensive R archive network: http://cran.r-project.org)
#Outras fontes de pacotes: Bioconductor, github, rOpenSci.org


#para instalar pacotes e carregar:
install.packages("nome")
library("nome")

citation("nome") #como citar o pacote que foi usado para a analise

#utilizar caminhos relativos: ao inves de usar C://usuarios/stella/documentos etc, usar um ponto que diz "tudo antes disso ? relativo", o que vem depois do ponto ? compartilhavel ex: ./dados/resultados



#Explorando as op??es gerais do R e personalizando o studio

ls()  #para listar os objetos no workspace
rm(list = ls())  #para remover os objetos do workspace

#Nas op?oes, selecionar a aba Terminal e escolher o Shell Git Bash, ele reconhece depois que tem o Git instalado


#Qual ? a pasta de trabalho? get work domain
getwd()
#Criar um projeto na pasta que deseja trabalhar
getwd()


#GitHub é um repositorio que permite que os usuarios salvem versoes do codigo na nuvem e reconhecem as versoes diferentes dos arquivos. O Git é o sistema inventado para organizar o proprio codigo.
#Configuraçao de RStudio e de git: abrir a aba Terminal e digitar "pwd" para garantir que a pasta é a mesma do working directory. Digitar "git config user.name" e "git config user.email" pra ver se nao tem nenhum usuario cadastrado. Digitar "git init" para iniciar o git e digitar "git config user.name "stellamanes" " e "git config user.email "stellamanes@gmail.com" ". Ao final disso, vai abrir uma aba nova aba "Git" no workplace.

#Agora vai pegar uma senha do computador e levar pro site pra reconhecer o computador. Abrir Tools> Global options> git/SVN > Create RSA key > View public key > copiar chave e abrir o site do github. Se tiver mais de um computador é uma senha individual para cada. NO site do github, abrir settings> SSh> new key. Agora o computador está conectado com o R. Crie um diretorio no GitHub pra ser a workplace de la. E depois abrir o workplace no R usndo a linha de comando do Github. Para adicionar outros arquivos no seu GitHub, colocar o comando "add git nome.txt" para adicionar o arquivo. Depois fazer o commit "git commit -m "adicionar mensagem informativa" ". Depois é o push "git push -u origin master"
#O Add serve para adicionar os arquivos. O commit serve pra criar um corte temporal nos arquivos, pra fazer um corte no arquivo para modificar depois (como se tivesse fazendo uma copia do documento pra salvar ate aquele momento uma copia e modificar a partir de entao). O push é para enviar os arquivos para o site, podem ser feitos varios commits offline e quando tiver internet upar tudo ao mesmo tempo.

#Agora, depois de ter upado o arquivo ReadMe.txt, vamos modificar o arquivo. Abrir o arquivo e mexer nele. Agora se colocar "git status" vai dar pra ver que ele foi modificado. Agora vamos re-upar o arquivo no site do github


