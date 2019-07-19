
# Manipulacao de mapas no R -----------------------------------------------





# Manipulacao de SHAPES ---------------------------------------------------


#Manipulação de dados vetoriais
#Lendo dados vetoriais e selecionar subconjunto

#Existem várias opções de pacotes para importar dados vetoriais. Aqui usaremos o rgdal. Verifique se já tem instalado com library(rgdal), caso não carregue, então instale como de costume.

install.packages("rgdal")
library(rgdal)

#Importando um shape (A Song of Ice and Fire Speculative World Map, disponível em Download) e plotando:
westeros <- readOGR("./data/GoTRelease/political.shp", encoding = "UTF-8")
westeros

plot(westeros, las = 1, axes = T)
abline(h = 0, lty = 2, col = "tomato") #plotando a linha do 'equador'

names(westeros)
westeros$ClaimedBy

#Selecionando ‘The North’ (região reivindicada pela casa Stark):
stark <- westeros[westeros$ClaimedBy == "Stark",]
lannister <- westeros[westeros$ClaimedBy == "Lannister",]

#Plotando o mapa da área selecionada:
plot(stark, axes = T, las = 1)
plot(lannister, axes = T, las = 1)


#Criando um buffer
#Gerando pontos aleatórios:
pontos <- spsample(stark, 10, 'random')

#Plotando os pontos aleatórios:
plot(stark, axes = T)
points(pontos, pch = "+", col = "tomato", cex = 1.5)

#Para criar o buffer vamos utilizar o pacote raster.
#Criando o buffer e plotando:
library(raster)
pontos.buffer <- buffer(pontos, width = 200000, dissolve = TRUE)

## Loading required namespace: rgeos
plot(stark, axes = T)
plot(pontos.buffer, add = T, col = "grey60")
points(pontos, col = 'red', pch = 16)

#Tente com o argumento dissolve = FALSE e veja a diferença.
pontos.buffer <- buffer(pontos, width = 200000, dissolve = FALSE)
plot(stark, axes = T)
plot(pontos.buffer, add = T, col = "grey60")
points(pontos, col = 'red', pch = 16)

#Criar um buffer em vetores do tipo pontos, linhas e polígonos funcionam de forma similar. Deve-se ficar atento apenas ao argumento width. Veja um exemplo de buffer em um polígono.
#Criando o buffer e plotando:
stark.buffer <- buffer(stark, width = 2, dissolve = TRUE)
plot(stark.buffer, col = "grey80", axes = T)
plot(stark, add = T, col = "lightblue")




#Incluindo atributos em um objeto Spatial
#Incluir novos atributos em um objeto Spatial é similar a incluir uma nova coluna em um data frame.

westeros
westeros$regiao <- c(rep(1:3, each = 4))
westeros


#Unindo polígonos
#A função aggregate do pacote raster pode ser utilizada também para juntar polígonos com base em um
#Unindo tudo:
install.packages("rgeos")
library(rgeos)
westeros_contorno = aggregate(westeros)
plot(westeros_contorno, axes = T)

#Mas, também podemos unir os polígonos indexados:
#Unindo por região:
new_westeros = aggregate(westeros, by = "regiao")
plot(westeros, axes = T, col = terrain.colors(12))

#Exportando um shape
#Podemos exportar os shapes que criamos com a função writeOGR do pacote sp. Um detalhe importante: a função writeOGR só exporta objetos do formato SpatialPointsDataFrame, SpatialLinesDataFrame ou SpatialPolygonsDataFrame object.

writeOGR(
  westeros_contorno, #nome do objeto a ser salvo
  dsn = "./data/meushape", #diretorio a serem salvos os resultados
  layer = "westeros_contorno", #nome do arquivo
  driver = "ESRI Shapefile" #formato pretendido para exportação
)
#Com a função ogrDrivers() é possível ver todos os drivers disponíveis.


#criando raster a partir de um shape:

westeros_raster <- raster(westeros_contorno, res = 0.08)
westeros_raster <- rasterize(westeros_contorno, westeros_raster) #deixando com o mesmo extent
plot(westeros_raster)





# Manipulacao de RASTER ---------------------------------------------------

#Manipulação de raster
#Importando raster
#Podemos importar um único raster com a função raster do pacote homônimo e múltiplos rasters com a função stack.
#Um raster:
var1 <- raster("./data/vars/var_1.tif")
var1
plot(var1)

#Múltiplos rasters:
lista <- list.files("./data", pattern = "tif$", full.names = T)
vars <- stack(lista)
plot(vars)

#Quando temos um arquivo com várias bandas, então podemos importar com a função brick
#Um raster multi-banda:
vars <- stack("./data/vars.tif")
plot(vars)

#se quiser apenas um desses 4 mapas, faz como se tivesse indexando uma lista
plot(vars[[1]])
plot(vars[[3]])

#Salvando raster no arquivo
writeRaster(var1, "output.tif")

#Note que por padrão o arquivo já é salvo no formato com base na extensão que você colocou no nome do arquivo. Caso não funcionar especifique o formato com o argumento format = "GTiff" para arquivos Geotiff.
#veja os formatos suportados pelo pacote raster com writeFormats().
#Importante: Caso já exista um arquivo com o nome especificado, pode usar o argumento overwrite = TRUE.
writeFormats()

#Álgebra de raster
#É possível utilizar + operadores simples como: +, -, *, / + operadores lógicos como: >, >=, <, ==, ! + outras funções como:  abs, round, ceiling, floor, trunc, sqrt, log, log10, exp, cos, sin, max, min, range, prod, sum, any, all
media <- mean(vars)
plot(media)

#Modificando raster
#Vamos utilizar o mesmo shape do início do tutorial para recortar um raster. Mas primeiro vamos selecionar parte deste shape.
westeros <- readOGR("./data/GoTRelease/political.shp", encoding = "UTF-8")
stark <- westeros[westeros$ClaimedBy == "Stark",]
stark

plot(westeros, axes = T, las = 1)
plot(stark, add = T, col = "tomato")

#Agora vamos recortar com crop. Esta função recorta um raster a partir de um extent, ou seja, recorta apenas um quadrilátero.
plot(var1)
plot(westeros, add = T)

var1_croped <- crop(var1, stark)
var1_croped
plot(var1_croped)
plot(stark, add = T)

#Com a função mask podemos recortar por uma mascara.
var1_masked = mask(var1, stark)
var1_masked
plot(var1_masked)

#Mas, muitas vezes usar o mask direto pode ser uma operação muito lenta. Então, podemos combinar as funções crop e mask para otimizar o processamento.
var1.masked2 = mask(crop(var1,stark), stark)
var1.masked2
plot(var1.masked2)
plot(stark, add = T)

#Teste usar o argumento inverse = TRUE em mask e veja o que acontece.
var1.masked2 = mask(crop(var1,stark), stark, inverse = TRUE) #ele so excluiu oq tava marcado, pegou ao contrario
var1.masked2
plot(var1.masked2)
plot(stark, add = T)


#Alterando a resolução do raster
#Com a Função aggregate é possível ‘piorar’ a resolução de um raster. Muda a resolução unindo as células vizinhas.
var1.aggregated = aggregate(var1, fact = 5, fun = "mean")
var1.aggregated
plot(var1.aggregated)
