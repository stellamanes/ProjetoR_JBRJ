

# Introducao a textos reproduziveis com markdown --------------------------


#Texto para escrever artigos sem ser no word, usando o LATEX. ou se for muito complicado, o Overleaf eh mais simples pra comecar  exemplo: https://www.overleaf.com/read/sypxfvvqhtpq

#markdown eh o mais simples e rapido. Eh baseado em html

#Quando ta fazendo texto no markdown, pode inserir um pedaco de texto em codigo de R pra rodar no meio
#Da pra share o output como html, pdf, word, etc etc

#Abrir uma nova pagina de markdown. Fazer knit e salvar. O cabeçalho do markdown se chama YAML, eh como se fosse os metadados do texto

#Pra inserir um codigo de R no meio, tem que abrir a parte com ``` escrevrer o codigo e fechar com ```

#O ideal eh colocar o Knit directory igual ao Project directory, pq assim ele parte do mesmo lugar pra achar figuras ou arquivos em subpastas

#Quando tem um script no meio do texto, da pra rodar ou nao e mostrar ou nao:
#eval = para rodar ou nao o codigo TRUE ou FALSE
#echo = para mostrar ou nao o codigo TRUE ou FALSE


#Para incluir plot:
#pode gerar no proprio espaco de codigos e fazer eles rodarem
#incluir figura ![](/figs/figura01.png) ou ![](../figs/figura01.png) dependendo se a figura ta um nivel abaixo nas pastas ou um nivel de pasta do lado



#Usando o Zotero (tipo o mendeley) da pra citar tudo automatico, conectado com o word. Tem um repositorio online que da pra citar diretamente no estilo da revista desejada "Zotero style repository"

#Quando cita no markdown, usa o arquivo .bib e da o caminho para a citacao. Tem um bib que fica se atualizando automaticamente pelo Zotero. No markdown a sua bibliografia eh o bib com o zotero e o csl eh o estilo da revista desejada

#Na hora de citar no texto, colocar entre colchetes @ e a chave de citacao do artigo que esta no cadastro do zotero/mendeley. O parentesis eh como se fosse o parentesis












