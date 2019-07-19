
# R para biologos, ecologos e taxonomistas --------------------------------

#Fluxo de trablho: ter scripts diferentes para analises diferentes
#ex: um script apenas pra limpeza de dados, um coloca dados e output da dados limpos
#o segundo script pega o input dos dados limpos e faz uma analise

#da tambem pra salvar o objeto como um arquivo rda separado. Depois abrir outro script que ja leia direto o objeto abrindo do computador, com a funcao load

#Use cabeçalho em cada script que seria um metadado do pra que serve esse script, que usa tal tabela e da tal e tal output, eh feito pra tal artigo. Uma boa descricao da receita de bolo
#Depois do cabecalho, o ideal eh carregar todos os pacotes que vao ser usados e library
#Nao pode deixar o install.packages no script, nao pode modificar o computador de outra pessoa, pode ser que atualize os pacotes e a pessoa nao queria

#fixar variaveis que vao ser usadas ao longo do script. Ex: desde o inicio faz a leitura dos input-files, ja nomeia objetos pras planilhas e tal

#Nao da pra terminar o script sem fazer nada, tem que salvar os outputs e escreve o que voce fez

#o script tem que ter ordem pra rodar inteiro, nao pode ficar voltando 

#ao inves de ter um codigo de  funcao imensa no meio do trabalho, eh melhor deixar um scrip especifico pra funcao e apenas chamar ela com a funcao source, ai seleciona o arquivo que esta o codigo da funcao

#Ja quando tiver o objeto, manter a descricao do que eh pra voce do futuro lembrar

#nao usar nomes existentes, ex: se quiser nomear um objeto chamado cor pra ver as cores, nao eh bom pq o R usa "cor" como correlacao, vai sobre-escrever

#se for precisar copiar+colar algo mais de 5 vezes, eh melhor fazer uma funcao pra isso. Pode parecer mais trabalhoso mas nao eh pq pode usar pra depois. Ai voce vai ter uma pasta so pras funcoes e pegar so quando precisar (ex: funcoes apply, lapply, for)

















