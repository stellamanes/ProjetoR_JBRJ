

# Organizacao de planilhas e tabelas --------------------------------------

#Boas praticas de formatacao nas planilhas
#Principais problemas de formatacao
#Exportando os dados
#Controle de qualidade

#Formatacao de planilhas: 
#nao colocar tabelas soltas, nao escrever nada nas margens, nao colocar espacializada longe das margens, utilizar os campos para transmitir informacoes (nao colocar texto explicando os numeros)
#A planilha inicial é diferente da planilha final: ter só duas versoes, o original e o corrigido. Utilizar o git para keep track das changes. Registre as etapas criando um bloco de notas Metadados que explica o que cada um é
#Exportar os dados limpos como formato CSV, separado por virgulas
#Nao mesclar celulas, nao usar unidade junto do valor pq cada celula deve ter um valor apenas. Tirar toda a formatacao antes de exportar pro CSV pra nao ter algum erro 
#Substituir espacos por nada, nao deixar espacos nas celulas!!


#Exportando os dados: para CSV (separado por virgula em ingles e ponto e virgula em portugues) ou txt (separado por tabulacao). Quando for importar pro R, vai dizer qual eh o icone do decimal, qual eh o separados das colunas, etc.




#Manipulacao dos dados no R
# funcao (argumento1 = valor, argumento2 = valor, ...)

#para conseguir ajuda, apertar F1 em cima da funcao ou botar interrogacao na frente dela
list.files

#Quando tiver duvida das funcoes, abrir o help e ver os exemplos no final, pra entender como funciona
list.files(R.home())

#Pacote para rasters: raster
# install.packages("raster")
#Esse pacote raster no Help tem varios tutoriais imbutidos, pra aprender a mexer
library("raster")
crop #exemplo, funcao crop do pacote raster

#Classes principais usadas no R
#vetor: sequencia de letras, palavras ou numeros
#matriz: colecao de vetores em linhas e colunas, do mesmo tipo (numerico, caracteres ou logico)
#dataframe: aceita vetores de diferentes tipos
#list: aceita varios dataframes, matrizes e vetores que nao precisam ter o mesmo comprimento
#funcao: sao objetos do R com funcoes


#vetor: podem ser numeric, integer, character, factor, logical

#data frame: checagem rapida pra ver se a data frame ta tudo certo
dim()
str()
head()

#importacao de dados
read.table()
read.csv()
read.csv2()

#argumentos mais importantes
#header = TRUE ou FALSE. Se os dados tem cabecalho
#sep = ";"  separador de colunas
#dec = ","  decimal separado por virgula ou ponto

#quando for chamar a tabela, usar
read.table("./Data/exercicio_01_revisado.csv", dec = ",", sep = ";", header = TRUE)

#Salvando os dados
write.table()
write.csv()
write.csv2()


# Exercicios --------------------------------------------------------------

###Exercicio 1
#Você pode ver que existem três guias. Suponha que três estagiários conduziram a coleta de dados e os três registraram os dados à sua maneira. Agora você é a pessoa responsável por este projeto e quer poder começar a analisar os dados. Identifique o que está errado nesta planilha. Discuta com seus colegas as etapas necessárias para limpar as guias e colocá-las todas juntas em uma única planilha. Importante Não se esqueça do nosso primeiro conselho: para criar um novo arquivo (ou guia) para os dados limpos, nunca modifique seus dados originais (brutos).
# planilha_bruta: "./Data/exercicio_01.xlsx"
# planilha pos-revisao para corrigir os erros: "./Data/exercicio_01_revisado.xlsx"
planilha_revisada <- read.csv("./Data/exercicio_01_revisado.csv", dec = ",", sep = ";", header = TRUE)
planilha_revisada


###Exercício 2 - Dados de um experimento sobre a tolerância ao frio das espécies de gramíneas Echinochloa crus-galli. 

#Organize os dados em uma única tabela, Exporte para um arquivo de texto, Salve os metadados, Importe para o R:
# planilha_bruta: "./Data/exercicio_02.xlsx"
#planilha pos-revisao para corrigir os erros: "./Data/exercicio_02_revisado.xlsx"
read.csv("./Data/exercicio_02_revisado.csv", dec = ",", sep = ";", header = TRUE)
exercicio2 <- read.csv("./Data/exercicio_02_revisado.csv", dec = ",", sep = ";", header = TRUE)
exercicio2 <- exercicio2[,-5] #veio uma coluna a mais errada, retirei por indexacao
exercicio2

#Calcule a média de ‘uptake’ para ‘Quebec chilled’
exercicio2[exercicio2$study_area == "Quebec", ]
exercicio2[exercicio2$treatment == "chilled", ]
exercicio2[c(exercicio2$study_area == "Quebec" & exercicio2$treatment == "chilled"), ] 
quebec_chilled <- exercicio2[c(exercicio2$study_area == "Quebec" & exercicio2$treatment == "chilled"),]
quebec_chilled
mean(quebec_chilled$uptake)


###Exercicio 3 - Contagem de árvores em parcelas de 1 hectare na Ilha de Barro Colorado.
#Salve os dados em uma planilha, Exporte para um arquivo csv
#planilha bruta: "./Data/exercicio_03.xlsx"
#planilha como arquivo csv: ".Data/exercicio_03.csv"
exercicio3 <- read.csv2(file = "./Data/exercicio_03.csv", sep = ";", header = TRUE, row.names = 1) #colocando o row.names diz que o nome das especies nao eh um valor da dataframe, que eh o nome das colunas
exercicio3
colSums(exercicio3)

###Exercicio 4 - Dados do GBIF com 320 linhas e 45 colunas
#Leia o arquivo “0012594-190621201848488.csv”
#selecione apenas as colunas com o nome da espécie, longitude e latitude
#salve um arquivo com esses dados
#Dica: Use o help para descobrir outras funções para importar os dados.

exercicio4 <- read.delim("./Data/0012594-190621201848488.csv")
exercicio4

exercicio4_spp_long_lat <- exercicio4[c("species", "decimalLongitude", "decimalLatitude")]
exercicio4_spp_long_lat

write.table(exercicio4_spp_long_lat, file = "./data/exercicio4_spp_long_lat.txt", sep = ",", dec = ".")

