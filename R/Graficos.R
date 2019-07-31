
# Graficos ----------------------------------------------------------------


#Como deixar o eixo y com valores em pe ao inves de deitados: o comando eh las=1 

#No R, quando faz um grafico de barras, que possui fatores (ex: alunos de uma turma classificados em iniciantes, intermediarios e experientes) ele cria automaticamente em ordem alfabetica. E nós queremos em ordem de conhecimento. Então tem que dizer pro R que o nivel é um fator e qual é a ordem deles usando a funcao factor.

d.Titanic <- as.data.frame(Titanic) #o R tem uma base de dados sobre sobreviventes do titanic

#Sites que tem Palhetas de cores
#Color brewer
#Adobe colors
#COLOR lovers

#The noun project - um banco de imagens em png com imagens pra tudo pra colocar nos graficos

#Codigos do R pra acessar os pacotes:
#wesanderson
#RColorBrewer
#swatches
#colourlovers

#Pacotes pra fazer graficos:
#ggplot2
#gganimate - cria gifs dos graficos mudando em funcao do tempo, os pontos mexendo! serie temporal



# Tutorial aula 07 --------------------------------------------------------

#Tutorial Graficos
#Gráfico de dispersão: plot com abline do modelo de regressão
#Carregue o arquivo contendo dados de salário de homens e mulheres em empresas de tecnologia que está no diretório da aula de hoje data/salario.csv. Salve o arquivo em sua pasta /data e vamos reproduzir o gráfico da aula.

## lendo os dados
sal <- read.table(file = "./Data/salarios.txt",  sep = ",", header = TRUE)
sal

## explore os dados com as funções head e summary
head(sal)
summary(sal)
colnames(sal)


# criando objetos para auxiliar a construção do gráfico.
mh <- lm(salario ~ experiencia, data=sal[sal$sexo=="H",])
mm <- lm(salario ~ experiencia, data=sal[sal$sexo=="M",])
mh
mm

# Criando modelos lineares
coefh <- coef(mh)
coefm <- coef(mm)

# definindo os limites dos eixos
limy <- c(min(sal$salario),max(sal$salario))
limx <- c(min(sal$experiencia),max(sal$experiencia))
## definindo os nomes dos eixos
labx <- "Experiência (anos)"
laby <- "Salário (R$)"

#Agora vamos construir o gráfico em si:

## define parametros graficos
par(mfrow=c(1,2), las=1, bty="l")

#plot dos valores de salario dos homens
plot(salario ~ experiencia, data=sal[sal$sexo=="H",], 
     col="tomato",
     ylim=limy, xlim=limx,
     ylab=laby, xlab=labx)

# linha do previsto pelo modelo
# a + b*x 
abline(a=coefh[1], b=coefh[2],
       col='tomato', lwd=2)

mtext("A", 3, adj=0, font=2)

# plot do salario das mulheres
plot(salario ~ experiencia, data=sal[sal$sexo=="M",], 
     col="navy",
     ylim=limy, xlim=limx,
     ylab="", xlab=labx)
mtext("B", 3, adj=0, font=2)

# linha do previsto pelo modelo
# a + b*x 
abline(a=coefm[1], b=coefm[2],
       col='navy', lwd=2)


#Exportando o gráfico com as funções png() e dev.off()
#Queremos exportar esse gráfico. Para isso, primeiro crie um diretório /figs em seu repositório. Para exportar o gráfico vamos usar a função png, especificando a resolução e dimensões da figura.Quando criamos gráficos com a função png o que fazemos é:
# anunciar qual extensão e arquivo vamos plotar o gráfico com a função png()
# determinar a sequência de comandos que cria o gráfico
# finalizar a construção do arquivo com a função dev.off()

# a funcao png cria o arquivo, daqui pra frente você não vai mais ver o gráfico
png("./figs/figura01.png", res=300, width=2400, height=1200)

#agora vou copiar tudo que ja foi criado pra ser armazenado dentro dessa figura png que foi criada. Tudo entre o png e o dev.off vai ser plotado dentro do grafico

# define parametros graficos
par(mfrow=c(1,2), las=1, bty="l")
# aqui estamos usando las e bty dentro do par para fixar para todas as janelas

# plot dos valores de salario dos homens
plot(salario ~ experiencia, data=sal[sal$sexo=="H",], 
     col="tomato",
     ylim=limy, xlim=limx,
     ylab=laby, xlab=labx)

# linha do previsto pelo modelo # a + b*x 
abline(a=coefh[1], b=coefh[2],
       col='tomato', lwd=2)
mtext("A", 3, adj=0, font=2)

# plot do salario das mulheres
plot(salario ~ experiencia, data=sal[sal$sexo=="M",], 
     col="navy",
     ylim=limy, xlim=limx,
     ylab="", xlab=labx)
mtext("B", 3, adj=0, font=2)

# linha do previsto pelo modelo # a + b*x 
abline(a=coefm[1], b=coefm[2],
       col='navy', lwd=2)


dev.off()
# para finalizar o gráfico e gerar o arquivo, precisamos rodar o dev.off()


#Usando a função legend() em gráficos de dispersão
#Vamos fazer o mesmo gráfico anterior, mas agora com todos os pontos em uma mesma janela gráfica. Agora, vamos usar a função legend() para diferenciar os pontos

par(mfrow=c(1,1), las=1, bty="l")

# plot dos valores de salario dos homens
plot(salario ~ experiencia, data=sal[sal$sexo=="H",], 
     col="tomato",
     ylim=limy, xlim=limx,
     ylab=laby, xlab=labx)
# linha do previsto pelo modelo # a + b*x 
abline(a=coefh[1], b=coefh[2],
       col='tomato', lwd=2)

## usando points para adicionar os pontos do salario das mulheres
points(salario ~ experiencia, data=sal[sal$sexo=="M",], 
       col="navy")
# linha do previsto pelo modelo das mulheres # a + b*x 
abline(a=coefm[1], b=coefm[2],
       col='navy', lwd=2)

# incluindo a legenda
legend("topleft", legend=c("homens", "mulheres"),
       col=c("tomato", "navy"),
       lty=1, bty='n')


### Agora fazendo o mesmo que acima so que exportando o grafico pra salvar no computador:


png("./figs/figura02.png", res=300, width=2400, height=1200)

# plot dos valores de salario dos homens
plot(salario ~ experiencia, data=sal[sal$sexo=="H",], 
     col="tomato",
     ylim=limy, xlim=limx,
     ylab=laby, xlab=labx)

abline(a=coefh[1], b=coefh[2],
       col='tomato', lwd=2)

## usando points para adicionar os pontos do salario das mulheres
points(salario ~ experiencia, data=sal[sal$sexo=="M",], 
       col="navy")
abline(a=coefm[1], b=coefm[2],
       col='navy', lwd=2)

# incluindo a legenda
legend("topleft", legend=c("homens", "mulheres"),
       col=c("tomato", "navy"),
       lty=1, bty='n')

dev.off()
#Fechando a criacao do grafico com dev.off


# Boxplot
#Vamos voltar à construção de box-plots. Desta vez vamos construir box-plots para cada espécie e variável com cada espécie de uma cor. A paleta de cores aqui utilizada é inspirada no filme Life Aquatic do diretor Wes Anderson e foi gerada no pacote de R wesanderson.

#Usando o argumento font
#E se quisermos colocar o nome das espécies em itálico no eixo? Isto é possível com o argumento font da função axis. As funções text e mtext também tem a opção font. Vamos ver como isto fica:

# criando vetor de cores
cores <- c("#3B9AB2", "#EBCC2A", "#F21A00")
# criando vetor com o nome das espécies
sp <- paste("I.", unique(iris$Species), sep=" ")

par(mfrow=c(2,2), bty='l', las=1)
boxplot(Sepal.Length ~ Species, data=iris, xlab="", col=cores,
        xaxt="n")
axis(1, at=1:3, labels=sp, font=3)
boxplot(Sepal.Width ~ Species, data=iris, xlab="", col=cores, 
        xaxt="n")
axis(1, at=1:3, labels=sp, font=3)
boxplot(Petal.Length ~ Species, data=iris,  col=cores,
        xaxt="n")
axis(1, at=1:3, labels=sp, font=3)
boxplot(Petal.Width ~ Species, data=iris, col=cores,
        xaxt="n")
axis(1, at=1:3, labels=sp, font=3)

par(mfrow=c(1,1))



#Gráfico de média com desvio padrão com arrows
#Vamos criar um data.frame com a média e desvio padrão de cinco variáveis. Atenção: estamos usando a função set.seed para que os valores gerados com a função sample sejam iguais para todxs os computadores.

# fixando uma semente de numeros aleatorios para manter o mesmo resultado no sample
set.seed(42)
# criando um data frame com valores medios e desvio padrão de uma variável
d2 <- data.frame(name=letters[1:5],
                 value=sample(seq(4,15),5),
                 sd=c(1,0.2,3,2,4))
d2

#Fazer o plot dos pontos
#Adicionar a configuração do eixo x na mão com a função axis
#Adicionar os valores de desvio padrão em torno da média com a função arrows

plot(x=1:5, d2$value, las=1, bty='l', ylim=c(0, 18), pch=19, xaxt='n',
     xlab="names", ylab="value")
axis(1, at=1:5, labels=d2$name)
arrows(x0=1:5,
       y0=d2$value+d2$sd,
       y1=d2$value-d2$sd, angle=90, length=0.05, code=3)






# Exercicios --------------------------------------------------------------

#Exercicio aula 07
#Use data(iris) para carregar os dados
data(iris)
iris

#construa uma janela grafica com 1 linha e 3 colunas seguindo as instrucoes abaixo
par(mfrow=c(1,3), bty='l', las=1) #colocando 3 graficos na mesma linha, com numeros em pé ao inves de deitados

#Comprimento da petala no eixo x e largura da sepala no eixo y, sendo cada especie em uma janela grafica. Plote cada especie com uma cor diferente
#plotando os graficos
plot(Sepal.Width ~ Petal.Length, data = iris[iris$Species == "setosa",], col = "purple")

plot(Sepal.Width ~ Petal.Length, data = iris[iris$Species == "versicolor",], col = "gold")

plot(Sepal.Width ~ Petal.Length, data = iris[iris$Species == "virginica",], col = "violet")

#Adicione a reta do modelo linear
#configurando as linhas abline
a <- lm(Sepal.Width ~ Petal.Length, data = iris[iris$Species == "setosa",])
b <- lm(Sepal.Width ~ Petal.Length, data = iris[iris$Species == "versicolor",])
c <- lm(Sepal.Width ~ Petal.Length, data = iris[iris$Species == "virginica",])

coefa <- coef(a)
coefb <- coef(b)
coefc <- coef(c)


#Inclua rotulos A, B e C em cada uma das janelas graficas. Crie um diretorio /figs em seu repositorio. Salve o grafico em png em uma boa resolucao, com o tamanho dos pontos e eixos legiveis no diretorio /figs.
#Plotando com as linhas e exportando em uma figura 

png(filename = "./figs/grafico_iris.png", res=300, width=2400, height=1200)

par(mfrow=c(1,3), bty='l', las=1) 

plot(Sepal.Width ~ Petal.Length, data = iris[iris$Species == "setosa",], col = "purple")
abline(a=coefa[1], b=coefa[2], col = "purple")
mtext("A", 3, adj=0, font=2)

plot(Sepal.Width ~ Petal.Length, data = iris[iris$Species == "versicolor",], col = "gold")
abline(a=coefb[1], b=coefb[2], col = "gold")
mtext("B", 3, adj=0, font=2)

plot(Sepal.Width ~ Petal.Length, data = iris[iris$Species == "virginica",], col = "violet")
abline(a=coefc[1], b=coefc[2], col = "violet")
mtext("C", 3, adj=0, font=2)

dev.off()




# Desafio Aula 07 ---------------------------------------------------------
#Construa um grafico de pontos, contendo cada uma das variaveis (comprimento da sepala, largura da sepala, comprimento da petala, largura da petala) no eixo x e os valores medios no eixo y. Inclua as barras de erro (representando o desvio padrao em torno da media). Salve o grafico em png no diretorio figs

# criando um data frame com valores medios de iris e desvio padrão das variáveis
#Primeiro vou criar objetos pra cada um dos valores
parametros <- c("comp_sep", "larg_sep", "comp_pet", "larg_pet")
medias <- c(mean(iris$Sepal.Length), mean(iris$Sepal.Width), mean(iris$Petal.Length), mean(iris$Petal.Width))
sd <- c(sd(iris$Sepal.Length), sd(iris$Sepal.Width), sd(iris$Petal.Length),sd(iris$Petal.Width))

#Agora criando um data frame com esses tres objetos
desafio <- data.frame(parametros, medias, sd) 
desafio

#Fazer o plot dos pontos
#Adicionar a configuração do eixo x na mão com a função axis
#Adicionar os valores de desvio padrão em torno da média com a função arrows
plot(x=1:4, desafio$medias, las=1, bty='l', ylim=c(0, 10), pch=19, xaxt='n',
     xlab="parametros", ylab="medias")
axis(1, at=1:4, labels=desafio$parametros)
arrows(x0=1:4,
       y0=desafio$medias+desafio$sd,
       y1=desafio$medias-desafio$sd,
       angle=90, length=0.05, code=3)

#Salvando em png o grafico no diretorio figs
png("./figs/desafio.png", res=300, width=2400, height=1200)
plot(x=1:4, desafio$medias, las=1, bty='l', ylim=c(0, 10), pch=19, xaxt='n',
     xlab="parametros", ylab="medias")
axis(1, at=1:4, labels=desafio$parametros)
arrows(x0=1:4,
       y0=desafio$medias+desafio$sd,
       y1=desafio$medias-desafio$sd,
       angle=90, length=0.05, code=3)
dev.off()





