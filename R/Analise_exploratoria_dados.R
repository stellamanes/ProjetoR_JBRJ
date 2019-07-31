

# Relembrando o GitHub ----------------------------------------------------


#Git eh o sistema chave pra controle de versoes de dados. O github nao eh um site independente, so funciona porque tem o git instalado. Outros exemplos sao gitlab ou bitbucket

#comandos basicos localmente
#git init pra iniciar um repositorio. Se fosse clonar um repositorio ja existente seria git clone URL

#git status para checar em que pe esta

#git pull origin master para atualizar o repositorio local

#git add filename para adicionar um arquivo novo ou para adicionar mudancas a arquivo ja foram adicionados antes

#se um arquivo for modificado ele vai aparecer como modificado mas a modificacao so vai ser salva ao fazer git add

#git commit -m "uma mensagem informativa para entender oq foi feito"

#git remote -v ve os arquivos remotos


#como faz entao pra usar pela primeira vez:
git init
git add remote
(...) #trabalha
git add
(...)
git add
git commit
(...)
git add
(...)

#Nas proximas vezes que for usar:
git pull origin master
(...)
git add
git commit
git push origin master

#explorando o github, tem sites com referencias na aula 5



# Analise Exploratoria de Dados -------------------------------------------

#perguntas pra fazer pros dados: 
#Existem dados faltantes?
is.na(objeto) #pra perguntar se existe algum NA nos dados
which(is.na(objeto)) #qual valor é o NA?

#Existem muitos zeros? certificar que o zero eh zero mesmo
objeto == 0 #se tem zeros no resultado
sum(objeto == 0) #quantos zeros tem? Somar o resultado do teste logico pra saber quantos tem

#Onde os dados tao centrados? como eles estao espalhados? sao simetricos? Existem valores extremos? qual a distribuicao da variavel?





# Tutorial aula 6 -------------------------------------------------------

#Quarteto de Anscombe
data("anscombe")
anscombe

dim(anscombe) # dimensao dos dados, N de linhas e N de colunas
head(anscombe) # seis primeiras linhas dos dados
class(anscombe) # classe do objeto
str(anscombe) # estrutura do objeto

#Fazendo a media por colunas do objeto
mean(anscombe$x1)
mean(anscombe$x2)
mean(anscombe$x3)
mean(anscombe$x4)
#Os numeros sao todos diferentes mas mesmo assim todas as medias sao as mesmas

#Agora usando a funcao apply para fazer a mesma tarefa, mas agora usando apenas em 1 linha de comando. Apply aplica uma funcao a todas as linhas de um objeto:
apply(anscombe[,1:4], 2, mean) # media de todos os vetores x
apply(anscombe[,5:8], 2, mean) # media de todos os vetores y

#Descrição estatística dos dados
apply(anscombe, 2, var)  # variância dos dados

#Ententendo a correlação e coeficiente de regressão dos conjuntos x e y.
# correlação
cor(anscombe$x1, anscombe$y1)
cor(anscombe$x2, anscombe$y2)
cor(anscombe$x3, anscombe$y3)
cor(anscombe$x4, anscombe$y4)

# coeficiente de regressão
## primeiro criamos objetos com as regressoes dos quatro conjuntos
m1 <- lm(anscombe$y1 ~ anscombe$x1)
m2 <- lm(anscombe$y2 ~ anscombe$x2)
m3 <- lm(anscombe$y3 ~ anscombe$x3)
m4 <- lm(anscombe$y4 ~ anscombe$x4)

## vamos criar agora uma lista com todos os modelos para facilitar o trabalho
mlist <- list(m1, m2, m3, m4)
summary(mlist)
summary(mlist[[1]])

## agora sim podemos calcular de forma menos repetitiva os coeficientes de regressao (intercepto e inclinacao da reta)
lapply(mlist, coef)

#Os dados têm mesma média, mesma variância, mesma correlação e mesmo valores dos coeficientes (intercepto e inclinação do modelo linear). Em que os dados são diferentes?
anscombe

#Os valores parecem difentes. Mas quão diferentes? Vamos abrir em graficos:
  
# funcao par para definir as configuracoes da janela grafica entre em ?par
  par(mfrow=c(2,2), #abre uma janela gráfica com 2 linhas e 2 colunas
      las=1, # deixa as legendas dos eixos na vertical
      bty="l") # tipo do box do grafico em L 
  
plot(anscombe$y1 ~ anscombe$x1) #plot das variaveis
abline(mlist[[1]]) # adicionando a reta prevista pelo modelo de regressao
plot(anscombe$y2 ~ anscombe$x2)
abline(mlist[[2]])
plot(anscombe$y3 ~ anscombe$x3)
abline(mlist[[3]])
plot(anscombe$y4 ~ anscombe$x4)
abline(mlist[[4]])

par(mfrow=c(1,1)) # retorna a janela grafica para o padrao de 1 linha e 1 coluna


# Parte 2: Uma rotina (entre muitas possíveis) de análise exploratória. Exemplo: Padrões morfológicos de espécies de Iris
data(iris)

#Após carregar o conjunto de dados, use o comando ?iris para entender mais sobre o conjunto de dados. Vamos então começar com as inspeções básicas do arquivo.
?iris
head(iris)
summary(iris) 

## Conhecendo as funções aggregate e tapply

#Quantas informações por espécie?
table(iris$Species)

#Qual a média das variáveis por espécie? Vamos usar as funções agreggate e tapply. As duas funções são semelhantes, o que muda são os argumentos e o formato de saída de cada uma delas.

# media do comprimento de sepala por especie
tapply(X = iris$Sepal.Length, INDEX = list(iris$Species), FUN = mean)

# a mesma tarefa, executada por outra funcao. Outros argumentos e outra saída
aggregate(x = iris$Sepal.Length, by = list(iris$Species), FUN = mean)

# ainda a mesma tarefa, com a mesma função mas em uma notação diferente
aggregate(Sepal.Length ~ Species, data=iris, mean)

#Podemos fazer o mesmo para as outras variáveis.
aggregate(Sepal.Length ~ Species, data=iris, mean)
aggregate(Sepal.Width ~ Species, data=iris, mean)
aggregate(Petal.Length ~ Species, data=iris, mean)

#E agora vamos calcular o desvio padrão das variáveis.
tapply(X = iris$Sepal.Length, INDEX = list(iris$Species), FUN = sd)
tapply(X = iris$Sepal.Width, INDEX = list(iris$Species), FUN = sd)
tapply(X = iris$Petal.Length, INDEX = list(iris$Species), FUN = sd)
tapply(X = iris$Petal.Width, INDEX = list(iris$Species), FUN = sd)

#Sempre que você está copiando e colando um comando, pense que existe uma maneira melhor de executar a sequência de tarefas. Afinal, se você tivesse 99 variáveis, copiar e colar 99x um comando não parece uma boa ideia. Veja abaixo uma solução de como calular a média por espécie de todas as variáveis. Para isso, vamos usar o comando for e executar todas as tarefas em um mesmo ciclo.

# criando matriz de 3 colunas - uma para cada sp - e 4 linhas - uma para cada metrica
medias <- matrix(NA, ncol=3, nrow=4)
medias

# definindo o nome das colunas e das linhas da matriz
colnames(medias) <- unique(iris$Species)
rownames(medias) <- names(iris)[-5]
medias

for (i in 1:4){
  medias[i,] <- tapply(iris[,i], iris$Species, mean)  
}
medias


#Estatísticas descritivas

#Medidas de tendência central
#Média
vars <- iris[,-5]
vars
apply(vars, 2, mean)

#Mediana: 50º quantil, de forma que divide os dados em duas metades
apply(vars, 2, median)

#Moda: valor mais frequente na amostra
freq_sl <- sort(table(iris$Sepal.Length), decreasing = TRUE)
freq_sl[1]

#Medidas de dispersão
#Variância: desvio da média
apply(vars, 2, var)

#Desvio padrão: raiz quadrada da variância
sd01 <- apply(vars, 2, sd)
sd01

# outra forma:
sd02 <- apply(vars, 2, function(x) sqrt(var(x)))
sd01
sd02
sd01==sd02

#Coeficiente de variação: medida relativa de desvio padrão
#Não existe no R base uma função para calcular o coeficiente de variação. Isto não é um problema. Vamos formalmente criar nossa primeira função de R. Para isso, usamos a função function

cv <- function(x){
  sd(x)/mean(x)*100
}

cv

apply(vars, 2, cv)


#Quantis ou percentis
#É o valor que corta a enésima porcentagem de valores dos dados quando ordenados de forma ascendente. Por padrão, a função quantile retorna o mínimo, o 25º percentil, a mediana, o 50º percentil, o 75º percentil e o máximo, também conhecidos pelo sumário de cinco números proposto por Tuckey (que também é o retorno da função summary de um vetor numérico). Os cinco números dividem os dados em quatro quantis, que, por isso são chamados de quartis. Os quartis são uma métrica bastante útil para descrever os dados pois possuem uma interpretação simples e não são afetados pela distribuição dos dados. É possível modificar os percentis desejados com o argumento probs.

# sumario de 5 numeros
apply(vars, 2, quantile)
# 5%, 50% e 95%
apply(vars, 2, quantile, probs=c(0.05, 0.5, 0.95))

#Intervalo (range). O intervalo é a diferença entre o maior e o menor valor de determinada variável.
# a funcao range nos retorna os valores minimo e maximo
apply(vars, 2, range)

# aplicando a funcao diff ao resultado do range, temos o valor desejado
# uma boa pratica é nunca sobrescrever um objeto já existente no R, por isso
# nunca nomeie um objeto com um nome já existente
my_range <- function(x){ 
  diff(range(x)) 
}
apply(vars, 2, my_range)

#Intervalo interquartil (IIQ)
#O IIQ é a diferença entre o quartil superior (75%) e o quartil inferior (25%).
apply(vars, 2, IQR)

#Correlação
#Uma matriz de correlação é uma tabela com os valores de correlação entre cada uma das variáveis par a par. As variáveis podem ser correlacionadas positivamentes (valores positivos) ou negativamente (valores negativos). O que são variáveis altamente correlacionadas? Uma boa “regra de dedão” é que qualquer correlação ≥0.7 é considerada uma alta correlação.
cor(vars)


# R Reference Card - eh um pdf na internet que fala sobre as funcoes mais usadas



#Métodos gráficos
#Olhar para a distribuição dos dados é essencial (Anscombe já dizia). As distribuições de frequência são úteis porquenos ajudam a visualizar o centro e a distribuição dos dados. Estamos muito acostumados com a distribuição normal, mas os dados biológicos podem assumir diferentes distribuições de probabilidade contínuas ou discretas.
#Uma breve descrição dos métodos gráficos:

###    install.packages("ggplot2")
library(ggplot2)

#Gráfico de barras - Um gráfico de barras mostra a frequência de de observações em uma dada classe.
barplot(table(iris$Species))

#Histograma
#O histograma é o equivalente do gráfico de barras para variáveis contínuas. Cada barra representa um intervalo de valores. O número de intervalos pode ser especificado pelo usuário e afeta a percepção da distribuição dos dados.Vamos ver um exemplo de histograma padrão para os dados das espécies de Iris.

par(mfrow=c(2,2))
hist(iris$Sepal.Length)
hist(iris$Sepal.Width)
hist(iris$Petal.Length)
hist(iris$Petal.Length)

par(mfrow=c(1,1))

par(mfrow=c(1,2))
hist(iris$Sepal.Width)
hist(iris$Sepal.Width, breaks = 4)

par(mfrow=c(1,2))
hist(iris$Sepal.Width)
hist(iris$Sepal.Width, freq = FALSE)

par(mfrow=c(1,2))
# plot da curva de densidade
plot(density(iris$Sepal.Width))
# plot da curva de densidade sobre o histograma de densidade
hist(iris$Sepal.Width, freq = FALSE)
lines(density(iris$Sepal.Width), col="blue") # note que agora estamos usando a funcao o comando add=TRUE

par(mfrow=c(1,1))

#Box-plot ou box-whisker plot
#Box-plots são gráficos que representam o sumário de cinco números de Tuckey mostrando os quartis (25%, 50% e 75%), valores mínimos, máximo e outliers. O box-plot mostra a forma da distrubuição dos dados, a forma da distribuição e a habilidade de comparar com outras variáveis na mesma escala. A caixa do boxplot contém o primeiro quartil (25%, quartil inferior) e o terceiro quartil (75%, quartil superior). A mediana (50%, segundo quartil) é a linha preta no interior da caixa. Os extremos do gráfico (“bigodes”) mostram os dados a uma distância \(1.5\times\)IIQ acima e abaixo o terceiro quartil e o primeiro quartil. Qualquer dado além do segmento é considerado um outlier.

#O que é um outlier? Outliers não são um erro (necessariamente, mas podem ser). Outliers representam valores extremos comparados ao restante dos dados. É sempre importante avaliar os outliers para garantir que sejam medidas corretas. Vamos agora fazer os box-plots das variáveis contidas no objeto iris. Vamos começar com as variáveis gerais.

boxplot(iris$Sepal.Length)
boxplot(iris$Sepal.Width)
boxplot(iris$Petal.Length)
boxplot(iris$Petal.Width)

#Agora vamos olhar para os valores por espécie.
boxplot(Sepal.Length ~ Species, data=iris)
boxplot(Sepal.Width ~ Species, data=iris)
boxplot(Petal.Length ~ Species, data=iris)
boxplot(Petal.Width ~ Species, data=iris)

#Você identifica outliers no conjunto de dados? Como podemos checar os outliers? Vamos usar a própria função boxplot para identificar os outliers.
boxplot(iris$Sepal.Width)

my_boxplot <- boxplot(iris$Sepal.Width, plot=FALSE)
my_boxplot
## o objeto é uma lista e os valores outliers estão guardados no elemento $out da lista
outliers <- my_boxplot$out
#qual a posicao dos outliers?
which(iris$Sepal.Width %in% outliers)
# vamos usar a posicao para indexar o objeto
iris[which(iris$Sepal.Width %in% outliers), c("Sepal.Width", "Species")]

#No caso anterior consideramos outliers em relação à distribuição da variável para todas as espécies juntas. É razoável assumir que cada espécie tenha um padrão morfométrico distinto de modo que poderíamos identificar outliers de maneira espécie específica.
boxplot(Sepal.Width ~ Species, data=iris)

my_boxplot2 <- boxplot(Sepal.Width ~ Species, data=iris, plot=FALSE)
my_boxplot2
# o objeto é uma lista e os valores outliers estão guardados no elemento $out da lista
outliers2 <- my_boxplot2$out
# neste caso, queremos apenas os outliers da especie setosa
# vamos usar a posicao para indexar o objeto
iris[iris$Sepal.Width %in% outliers2 & 
       iris$Species=="setosa", 
     c("Sepal.Width", "Species")]


#Entendendo a distribuição dos dados
#Para muitas análises estatístca espera-se que os dados assumam uma distribuição normal. Isto nem sempre é o padrão em dados biológicos. O tipo de distribuição do dado vai depender da natureza do dado. Alguns exemplos de distribuicoes de probabilidade sao: normal, binomial, poisson, log-normal.
#Se o seu dado não segue uma distribuição normal, isto pode ser tanto porque a natureza do dado não é normal (gaussiana) ou você não tem um tamanho amostral suficiente. Se o dado não é normal, uma abordagem pode ser transformar o dado ou encontrar uma análise apropriada ao tipo de distribuição do dado (por exemplo, se está fazendo uma regressão linear, pode fazer um modelo linear generalizado adequado à sus distribuição). Vamos olhar para os dados morfométricos das espécies de Iris e comparar com uma distribuição normal. No R, isto pode ser feito de forma visual com as funções qqnorm e qqline.

par(mfrow=c(1,3))
qqnorm(iris$Sepal.Length[iris$Species=="setosa"], 
       main="setosa")
qqline(iris$Sepal.Length[iris$Species=="setosa"])
qqnorm(iris$Sepal.Length[iris$Species=="versicolor"], 
       main="versicolor")
qqline(iris$Sepal.Length[iris$Species=="versicolor"])
qqnorm(iris$Sepal.Length[iris$Species=="virginica"], 
       main="virginica")
qqline(iris$Sepal.Length[iris$Species=="virginica"])

par(mfrow=c(1,1))

#Relação entre variáveis
#Uma função no R que nos ajuda a explorar a relação entre muitas variáveis é a  pairs. O resultado é uma matriz com variáveis em linhas e colunas o gráfico que vemos é o gráfico de dispersão para cada par de variáveis. A diagonal da matriz contém os nomes das variáveis. Note que o gráfico é espelhado de modo que a relação entre tamanho e comprimento de sépala aparece tanto na linha 1 e coluna 2 como na linha 2 e coluna 1.
pairs(vars)

#O pacote de R GGally fornece uma saída muito interessante para avaliar as relações entre variáveis pois já mostra o valor de correlação entre variáveis e a curva de densidade probabilística de cada uma das variáveis.
# carregando o pacote GGally
## se você não tiver o pacote usar:
#####    install.packages("GGally")
## se já tiver o pacote, apenas carregue
library(GGally)
ggpairs(vars)





# Exercicios --------------------------------------------------------------


#Exercicio aula 06 - trees
#Crie um script no R contendo os seguintes passos:
  
#leia o arquivo trees.csv que já está no seu diretório data
read.table(file = "./Data/trees.txt", sep = ",")
trees <- read.table(file = "./Data/trees.txt", sep = ",", header = TRUE)
trees

#faça o sumário dos dados
summary(trees)

#calcule o desvio padrão e a variância de cada uma das variáveis
apply(X = trees, MARGIN = 2, FUN = sd)
apply(X = trees, MARGIN = 2, FUN = var)

#construa um histograma para cada uma das variáveis
hist(trees$Girth)
hist(trees$Height)
hist(trees$Volume)

#construa um boxplot das variáveis
boxplot(trees$Girth)
boxplot(trees$Height)
boxplot(trees$Volume)

#identifique o(s) outliers no conjunto de dados. Qual(is) são os valores extremos? De que variável(is)?
outliers1 <- boxplot(trees$Girth, plot = FALSE)
outliers1 # o objeto é uma lista e os valores outliers estão guardados no elemento $out da lista
outliers_girth <- outliers1$out
which(trees$Girth %in% outliers_girth)
trees[which(trees$Girth %in% outliers_girth),]

  
outliers2 <- boxplot(trees$Height, plot = FALSE)
outliers2 # o objeto é uma lista e os valores outliers estão guardados no elemento $out da lista
outliers_height <- outliers2$out
which(trees$Height %in% outliers_height)
trees[which(trees$Height %in% outliers_height),]

outliers3 <- boxplot(trees$Volume, plot = FALSE)
outliers3 # o objeto é uma lista e os valores outliers estão guardados no elemento $out da lista
outliers_volume <- outliers3$out
which(trees$Volume %in% outliers_volume)
trees[which(trees$Volume %in% outliers_volume),]

#calcule a correlação par a par entre cada uma das variáveis
pairs(trees)




