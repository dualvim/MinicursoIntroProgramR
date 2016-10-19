##################################
# Minicurso R - Aula 5           #
##################################
# Tema --> Exemplo Conjunto de dados e gráficos
#      --> Gráficos do pacote base
#      --> Gráficos de ações (Biblioteca FinCal)
#      --> Gráficos da biblioteca 'ggplot2'



#####################################################
# 1 - Extrair dados de ações no Yahoo e no Google   #
#####################################################
# Carregar a biblioteca com os recursos necessários para a nossa atividadde
library(FinCal)

# 1.1 - Pegar série histórica de uma ação
# --> O pacote FinCal possui recursos que permitem importar os dados históricos de uma ação
# --> Os dados podem ser baixados do Yahoo ou do Google.
# --> Os dados baixados via "Yahoo Finance" incluem os dados sobre os preços ajustados das ações
#     --> No entanto, para baixar os dados de uma ação daqui do Brasil, devemos adicionar ".SA"
#     --> Apesar do procedimento acima funcionar bem, é possível não conseguir isso para todas
#           ações. Por exemplo, não consegui os dados da ALUP11, nem com ALUP11.SA 
# --> Nos dados baixados via "Google Finance", apesar de não fornecerem os preços ajustados das
#     ações, não é necessário incluir o sufixo ".SA"

# 1.1.1 - Baixar uma série histórica com dados de ações no site "Yahoo Finance"
# Ação: ELET6, Período: Janeiro a setembro de 2016 (1/1/2016 a 30/9/2016)
serELET6 <- get.ohlc.yahoo(symbol="ELET6.SA", start="2015-12-30", end="2016-09-30")

# 1.1.2 - Baixar uma série histórica com dados de ações no site "Google Finance"
# Ação: ALUP11, Período: Janeiro a setembro de 2016 (1/1/2016 a 30/9/2016)
serALUP11 <- get.ohlc.google(symbol="ALUP11", start="2015-12-30", end="2016-09-30")

#1.1.3 - Baixar as cotações do IBOVESPA para o mesmo período
# --> Os dados baixados no Yahoo incluem o volume de negociações, nos dados
#     baixados no Google não.
serBVSP <- get.ohlc.yahoo(symbol="^BVSP", start="2015-12-30", end="2016-09-30")
#serBVSP <- get.ohlc.google(symbol="IBOV", start="2016-01-01", end="2016-09-30")
#
# --> Os comandos acima retornam conjuntos de dados com os dados das ações buscadas.
class(serELET6) #[1] "data.frame"
class(serALUP11)#[1] "data.frame"


# 1.2 - Pegar várias séries históricas
#     --> O pacote FinCal também inclui recursos para baixar de uma vez os dados de várias
#           ações dos sites do Yahoo e Google

# 1.2.1 - Baixar uma série histórica com dados de duas ações no site "Yahoo Finance"
# Ações: BRML3 e MULT3, Período: Janeiro a setembro de 2016 (1/1/2016 a 30/9/2016)
serBrmlMult <- get.ohlcs.yahoo(symbols=c("BRML3.SA", "MULT3.SA"), start="2015-12-30", end="2016-09-30")

# 1.2.2 - Baixar uma série histórica com dados de ações no site "Google Finance"
# Ação: ALUP11, Período: Janeiro a setembro de 2016 (1/1/2016 a 30/9/2016)
serPetrVale<- get.ohlcs.google(symbols=c("PETR4", "VALE5"), start="2015-12-30", end="2016-09-30")
#
# --> Os comando acima retornam objetos do tipo lista, e cada elemento da lista será um 
#     conjunto de dados
class(serPetrVale) #[1] "list"
class(serPetrVale[[1]]) #[1] "data.frame"
# --> Os datasets do objeto list() retornado possuem nome
names(serPetrVale) #[1] "PETR4" "VALE5"
names(serPetrVale)[1] #[1] "PETR4"
names(serPetrVale)[2] #[1] "VALE5"


# 1.4 - Verificar quantas linhas possui os conjuntos de dados de cada ação:
dim(serELET6)[1] #[1] 198
dim(serALUP11)[1] #[1] 188
dim(serBVSP)[1] #[1] 188
dim(serBrmlMult[[1]])[1] #[1] 198
dim(serBrmlMult[[2]])[1] #[1] 198
dim(serPetrVale[[1]])[1] #[1] 189
dim(serPetrVale[[2]])[1] #[1] 189
# --> Percebe-se que os dados baixados no 'Yahoo Finance' contém dados em dias que não
#     houveram negociações em bolsa

# --> Veja que nos dados da ELET6 contém dados de dadtas que não houveram pregão como,
#     por exemplo, dias 31/12/2015 e 01/01/2016.
# --> Nessas datas, está simplesmente uma repetição dos dados de fechamento do dia 30/12/2015
#     e o volume negociado é igual a 0.
sum(serELET6[,6] == 0) #[1] 9
sum(serBrmlMult[[1]][,6] == 0) #[1] 9
sum(serBrmlMult[[2]][,6] == 0) #[1] 9
# --> Logo, deixar essas linhas nos nossos conjuntos de dados poderá trazer problemas nas
#     comparações entre os dados das empresas com o mercado


# 1.5 - Corrigir o problema acima e deixar todos os conjuntos de dados com o mesmo número de linhas
serELET6 <- serELET6[(serELET6$volume != 0), ]
serBrmlMult[[1]] <- serBrmlMult[[1]][(serBrmlMult[[1]]$volume != 0), ]
serBrmlMult[[2]] <- serBrmlMult[[2]][(serBrmlMult[[2]]$volume != 0), ]
#
sum(serELET6[,6] == 0) #[1] 0
sum(serBrmlMult[[1]][,6] == 0) #[1] 0
sum(serBrmlMult[[2]][,6] == 0) #[1] 0



###############################################
# 2 - Gráficos de ações da biblioteca FinCal  #
###############################################
# 2.1 - Gráfico de linhas de uma ação:
# --> Comando lineChart() da biblioteca "FinCal"
# --> Por padrão, essa função plota o preço de fechamento
# 2.1.1 - Gráfico comos preços de fechamento da ALUP11
lineChart(ohlc=serALUP11, main="ALUP11 - P(Fech) - Jan-Set/2016")
# 2.1.2 - Gráfico com os preços de fechamento ajustados da ELET6
lineChart(ohlc=serELET6, y="adjusted", main="ELET6 - P(FechAjust) - 1T-3T")

# 2.2 - Gráfico com os volumes de negociação
# comando volumeChart() da biblioteca FinCal()
# --> Gráficos de barras apresentando os volumes de ações negociadas a cada dia
volumeChart(ohlc=serELET6, main="Vol.Neg ELET6 - Jan-Set/2016")
volumeChart(ohlc=serALUP11, main="Vol.Neg ALUP11 - Jan-Set/2016")

# 2.3 - Gráfico de linhas com duas ações
lineChartMult(ohlc=serPetrVale, main="P(Fech) - PETR4 e VALE5 - Jan-Set/2016")
lineChartMult(ohlc=serBrmlMult, main="P(FechAjust) - BRML3 e MULT3 - Jan-Set/2016")

# 2.4 - Gráficos Candlestick
# --> gráfico do tipo OHLC (Open High Low Close)
# --> Para cada dia de pregão, o gráfico lista os dados de abertura fechamento, máximo e mínimo
#     --> Pontas das linhas verticais: Preço máximo e mínimo atingido no dia
#     --> Cor: Verde=Preço da ação subiu no dia; vermelho=Preço da ação caiu
#     --> Início e fim da caixa: Preço de abertura ou de fechamento.
#           -->A posição desses preços irá depender da cor
# Mais detalhes em: http://blog.bussoladoinvestidor.com.br/grafico-de-candlestick/
candlestickChart(ohlc=serELET6, start="2016-06-01", end="2016-07-31")
candlestickChart(ohlc=serALUP11, start="2016-06-01", end="2016-07-31")




##################################################
# 3 - Calcular os retornos diários das ações     #
##################################################
# --> Retorno contínuo de uma ação R = ln(Pt/Pt-1) = ln(Pt) - ln(Pt-1)

# 3.1 - Comando log()
# --> Comando log(x, base): quando não especificarmos o argumento 'base', o R
#     irá computar o logarítmo natural de x
log(100) #[1] 4.60517
log(100, base=10) #[1] 2

# 3.2 - Comando diff(x, lag)
# --> retorna as diferenças entre os elementos i+lag e i;
#     Exemplo: se lag=2, as diferenças retornadas serão: 3-1, 4-4, ..., n-2 
# --> A série de dados resultantes terá comprimento n-lag

# 3.2.1 - Ver os 10 primeiros precos de fechamento da ação ELET6
head(serELET6$close, n=10)
#[1] 10.44  9.90  9.99 10.14  9.90  9.58  9.22  9.39  9.20  9.13
length(head(serELET6$close, n=10)) #[1] 10

# 3.2.2 - Usar a função diff() com o argumento lag=1
diff(head(serELET6$close, n=10))
#[1] -0.54  0.09  0.15 -0.24 -0.32 -0.36  0.17 -0.19 -0.07
9.90-10.44 #[1] -0.54

# 3.2.3 - Usar a função diff() com o argumento lag=3
diff(head(serELET6$close, n=10), lag=2)
#[1] -0.45  0.24 -0.09 -0.56 -0.68 -0.19 -0.02 -0.26
9.99-10.44 #[1] -0.45

# 3.3 - Aplicar o que foi visto acima para calcular os retornos logaritmicos das ações:
# --> Recaptulando: R = ln(Pt/Pt-1) = ln(Pt) - ln(Pt-1)
# Exemplo: Pt = 10.44 e Pt+1=9.90
log(9.90/10.44) #[1] -0.05310983
log(9.90)-log(10.44) #[1] -0.05310983


# 3.4 - Aplicar conjuntamente as funções diff() e log() e calcularmos os retornos
#     logaritmicos de ELET6, BVSP, BRML3 e MULT3
#     --> Em geral, recomenda-se utilizar os preços ajustados das ações no cálculo
#           dos retornos das ações (tanto no tradicional quanto no logaritmico)
ret_elet6 <- diff(log(serELET6$adjusted), lag=1)
ret_bvsp <- diff(log(serBVSP$adjusted)) #Se lag=1, fica opcional especificar esse arguumento
ret_brml3 <- diff(log(serBrmlMult[[1]]$adjusted))
ret_mult3 <- diff(log(serBrmlMult[[2]]$adjusted))
#
head(ret_elet6) #[1] -0.053109825  0.009049836  0.014903406 -0.023953241 -0.032857165 -0.038302554
head(ret_bvsp)  #[1] -0.028285565  0.006575237 -0.015346177 -0.026144963 -0.002041645 -0.016434917
head(ret_brml3) #[1] -0.020938043 -0.001842266 -0.011120597 -0.003734923  0.008383745  0.006471775
head(ret_mult3) #[1] -0.010847987  0.016097235  0.000000000 -0.026526750  0.006698082  0.026091767




################################################################
# 4 - Criar um conjunto de dados com os retornos das ações     #
################################################################
# 4.1 - Criar um vetor com as datas dos nossos retornos
#     --> Importante, não incluir a data inícial!!
vetDatas <- as.Date(serELET6$date)[2:length(serELET6$date)]
head(vetDatas) #[1] "2016-01-04" "2016-01-05" "2016-01-06" "2016-01-07" "2016-01-08" "2016-01-11"

# 4.2 - Usar a função data.frame() para juntar os vetores em um só conjunto de dados
#dadosRet <- data.frame(vetDatas, ret_bvsp, ret_brml3, ret_elet6, ret_mult3)
dadosRet <- data.frame(ret_bvsp, ret_brml3, ret_elet6, ret_mult3)
class(dadosRet) #[1] "data.frame"
names(dadosRet) #[1] "ret_bvsp"  "ret_brml3" "ret_elet6" "ret_mult3"
# usar o conteudo de vetDatas para nomear as observações:
rownames(dadosRet) <- vetDatas
head(dadosRet)
sapply(dadosRet, class)
# ret_bvsp ret_brml3 ret_elet6 ret_mult3 
# "numeric" "numeric" "numeric" "numeric"

# 4.3 - Apagar os dados vetores que não iremos mais utilizar
rm(vetDatas, ret_bvsp, ret_brml3, ret_elet6, ret_mult3)

# 4.4 - Exportar o conjunto de dados 'dadosRet' para um arquivo de texto:
write.csv(dadosRet, file="DadosRetornos.csv")




#######################################
# 5 - Gráficos do pacote básico do R  #
#######################################
# 5.1 - Revisão de como plotar um gráfico de dispersão:
# Parâmetros gráficos da função plot():
#     --> type: Tipo de dado a ser plotado ("p"=pontos, "l"=linha)
#     --> main: Título do gráfico
#     --> pch: Formato do marcador (ver arquivo "Lista_R_pch.pdf")
#     --> col: cor do marcador/linha (ver arquivo "Lista_R_col.pdf")
#     --> lty: Se for plotar uma linha, código do tipo de linha (ver arquivo "Lista_R_ParamGraf.pdf", pag 2)
#     --> lwd: Se for plotar uma linha, indica a espessura da linha
#     --> xlab: Título do eixo X
#     --> ylab: Título do eixo Y
#     --> xlim: Intervalo de valores do eixo X
#     --> ylim: Intervalo de valores do eixo Y
#     --> las: Orientação dos rotulos no eixo X
#     --> bg: cor do plano de fundo do grafico
#     --> cex.axis: Tamanho da fonte dos valores eixo (ver "Lista_R_Eixo&Texto.pdf")
# --> Gráfico de dispersão Retornos Elet6 Vs Retornos Ibovespa
plot(x=dadosRet$ret_bvsp, y=dadosRet$ret_elet6, # Valores de X e de Y
      type="p", #Tipo de marcador: "p"=pontos, "l"=linha
      pch = 19, # Formato dos marcadores
      col= "deeppink2", # Cor dos pontos no gráfico
      xlab="BVSP", #Título do eixo x
      ylab="ELET6", #título do eixo y
      col.lab = "firebrick3", #Cor dos nomes dos eixos X e Y
      xlim = c(-0.055, 0.07), #Intervalo de valores do eixo X
      ylim = c(-0.07, 0.105), #Intervalo de valores do eixo Y
      col.axis = "orange3", #Cor dos eixos de valores
      main = "Ret.ELET6 Vs Ret. BVSP", #Título do gráfico
      col.main = "magenta4") # Cor do título

# Inserir uma linha vertical no gráfico, no local x=0
abline(v=0, #Local onde iremos inserir a linha vertical
       col="orange", #Cor da linha
       lwd=3) #espessura da linha

# Inserir uma linha horizontal no gráfico, no local x=0
abline(h=0, #Local onde iremos inserir a linha vertical
       col="orange", #Cor da linha
       lwd=3) #espessura da linha

# Inserir no gráfico uma linha de tendência de uma regressão linear:
abline(lm(dadosRet$ret_elet6~dadosRet$ret_bvsp), #Fórmula da reta de regressão
       col="chocolate", #Cor da linha
       lwd=2, #Formato da linha
       lty=5) #Espessura da linha

# Escrever a correlação entre os dois retornos no grafico:
text(x=-0.025, y=0.07, #Posição no gráfico onde estará o texto
     "Correlação(R(ELET6), R(BVSP)):", #Conteudo
     cex=0.75, #Tamanho do texto
     pos=3) #Posição do texto

text(x=-0.025, y=0.058, #Posição no gráfico onde estará o texto
     paste0(round(cor(dadosRet$ret_elet6,dadosRet$ret_bvsp), digits=4)), #Conteudo
     cex=0.75, #Tamanho do texto
     pos=3) #Posição do texto


# 5.2 - Plotar dois gráficos em um só painel:
# 5.2.1 - Alterar o parâmetro padrão de gráfico, de apenas 1 gráfico, para um palnel 1x2
par(mfrow=c(1,2)) #1 linha, 2 colunas

# 5.2.2 - Retorno BRML3 Vs Retorno Mercado
plot(x=dadosRet$ret_bvsp, dadosRet$ret_brml3,
     col="blue",
     pch=8,
     xlab="R(BVSP)",
     ylab="R(BRML3)",
     main="BRML3 Vs BVSP")

# Adicionar linha de tendencia
abline(lm(dadosRet$ret_brml3~dadosRet$ret_bvsp))
# 5.2.3 - Retorno MULT3 Vs Retorno Mercado
plot(x=dadosRet$ret_bvsp, dadosRet$ret_mult3,
     col="green",
     pch=4,
     xlab="R(BVSP)",
     ylab="R(MULT3)",
     main="MULT3 Vs BVSP")

# Adicionar linha de tendencia
abline(lm(dadosRet$ret_mult3~dadosRet$ret_bvsp))



# 5.3 - Plotar um painel com 4 gráficos, com estatísticas descritivas dos retorno do ibovespa
par(mfrow=c(2,2)) #2 linhas, 2 colunas

# Histograma
hist(dadosRet$ret_bvsp, 
     main="Hist. Ret. BVSP",
     xlab="Retornos BVSP",
     col = "slateblue1")

# Boxplot:
boxplot(dadosRet$ret_bvsp,
        main="Boxplot Ret. BVSP",
        xlab="Retornos BVSP",
        col="orange")

# Curva de densidade
plot(density(dadosRet$ret_bvsp), 
     type = "l", 
     main = "Densidade Suavizada", 
     xlab = "Retornos Diários", 
     ylab = "Estimativa de Densidade", 
     col = "dodgerblue3", na.rm =TRUE)

# Gráfico QQ-Plot
qqnorm(dadosRet$ret_bvsp, 
       pch=17,
       col = "darkorchid",
       main="QQ-Plot (normalidade dos retornos)")
#Linha com a normalidade esperada
qqline(dadosRet$ret_bvsp)

# Voltar a apresentar os gráficos em um painel 1x1:
par(mfrow=c(1,1)) #1 linha, 1 coluna












#############################################
# 6 - Reestruturação do conjunto de dados   #
#############################################
# --> Colocar os dados em um formato de painel.
# --> Os valores referentes a data e retorno do índice Bovespa serão repetidos 3 vezes
# --> Os dados das ações (BRML3, ELET6 e MULT3) irao aparecer uma vez
library(reshape2)
# 6.1 - Inserir uma coluna com as datas 
dadosRet$data <- rownames(dadosRet)

# 6.2 - Usar a função melt() para agregar os dados dos retornos das 3 ações:
dadosRet2 <- melt(dadosRet, id=c("data", "ret_bvsp"), measure.vars=c("ret_brml3", "ret_elet6", "ret_mult3"))
names(dadosRet2) #[1] "data"     "ret_bvsp" "variable" "value" 
names(dadosRet2) <- c("data", "ret_bvsp", "acao", "retorno")
names(dadosRet2) #[1] "data"     "ret_bvsp" "acao"     "retorno" 






#########################################
# 7 - Graficos da biblioteca 'ggplot2'  #
#########################################
library(ggplot2)
# Função qplot() da biblioteca 'ggplot2':
#     --> É análoga a função plot() do pacote 'base'
#     --> Essa função exige que os dados estejam dentro de um conjunto de dados
# Componentes de um gráfico da biblioteca 'ggplot2':
#     1 - Dados a serem plotados (argumentos x, y)
#     2 - Conjunto de dados onde estao os dados a serem plotados
#     3 - Aesthetics --> São os atributos que irão identid=ficar as observações de cada grupo
#           --> color: Agrupa os grupos por cor dos pontos
#           --> shape: Formato dos marcadores de cada grupo
#     4 - geom: Tipo de objeto geométrico a ser inserido no grafico
#           --> point: insere no gráfico de dispersão os pontos de cada observação
#           --> smooth: Linha de suavização
#     5 - facets: Separar os grupos em painéis
#           --> '<num_linhas> ~ <num_colunas>': Painel com num_linhas linhas e num_colunas colunas
#           --> '.~<vet_grupos>': Retorna painel horizontal com uma coluna para cada grupo
#           --> '<vet_grupos>~.': Retorna um painel com uma coluna e uma linha para cada grupo 

# 7.1 - Gráficos de pontos da biblioteca 'ggplot2'
# 7.1.1 - Gráficos de pontos geral 
qplot(x=ret_bvsp, y=retorno, data=dadosRet2)

# 7.1.2 - Gráfico de pontos, com uma cor para cada ação
qplot(x=ret_bvsp, y=retorno, #Valores de x e de y 
      data=dadosRet2, #Objeto do tipo "data.frame" com os dados
      color=acao,  #Pintar os pontos de cada acao com uma cor diferente
      main="R(Ação) Vs R(BVSP)") #Titulo do grafico

# 7.1.3 - Gráfico de pontos, com uma cor para cada ação e uma linha de suavização para cada uma
qplot(x=ret_bvsp, y=retorno, #Valores de x e de y 
      data=dadosRet2, #Objeto do tipo "data.frame" com os dados
      color=acao,  #Pintar os pontos de cada acao  com uma cor diferente
      geom=c("point", "smooth"), #Para cada grupo, apresentar os pontos ("point") e a linha de tendência "smooth"
      main="R(Ação) Vs R(BVSP)") #Titulo do grafico


# 7.1.4 - Plotar os pontos de cada grupo em um painel diferente:
# --> facets = .~acao
#     -->Significa que o painel terá 1 linha e em cada coluna do painel será plotado os gráficos de cada grupo
qplot(x=ret_bvsp, y=retorno, #Valores de x e de y 
      data=dadosRet2, #Objeto do tipo "data.frame" com os dados
      color=acao,  #Pintar os pontos de cada acao  com uma cor diferente
      shape= acao, #Cada acao tera um marcador diferente
      facets = .~acao, # Colocar cada grupo em um painel
      #geom=c("point", "smooth"), #Para cada grupo, apresentar os pontos ("point") e a linha de tendência "smooth"
      main="R(Ação) Vs R(BVSP)") #Titulo do grafico

# 7.1.5 - Criar o mesmo gráfico acima, mas agora a linha de suavização será a reta de regressão linear
g <- qplot(x=ret_bvsp, y=retorno, #Valores de x e de y 
      data=dadosRet2, #Objeto do tipo "data.frame" com os dados
      color=acao,  #Pintar os pontos de cada acao  com uma cor diferente
      shape= acao, #Cada acao tera um marcador diferente
      facets = .~acao, # Colocar cada grupo em um painel
      main="R(Ação) Vs R(BVSP)") #Titulo do grafico
#ver o gráfico
g
# Adicionar a cada grupo de retornos uma reta de regressão linear
g <- g+geom_smooth(method="lm")
#ver o resultado
g


# 7.2 - Histogramas
# 7.2.1 - Histograma de 'retorno'
qplot(x=retorno, #Variavel analisada
      data=dadosRet2, #Objeto do tipo "data.frame" com os dados
      fill=acao, #Pintar o histograma de cada grupo de uma cor diferente
      main="Histograma Retornos") #Titulo do grafico

# 7.2.2 - Plotar as curvas de densidade da distribuição para cada grupo de 'retorno'
qplot(x=retorno, #Variavel analisada
      data=dadosRet2, #Objeto do tipo "data.frame" com os dados
      color=acao, #Pintar as curvas de densidade de cada titulo com uma cor diferente
      geom="density", #Curva de densidade
      main="Distr. Densidade Retornos") #Titulo do grafico


# 7.2.3 - Plotar os histogramas de Taxa_VDA, para cada grupo, em um painel
# --> facets = acao~.
#     --> Significa que o painel tera 1 coluna e em cada linha desse
#           painel será plotado o histograma de cada ação
qplot(x=retorno, #Variavel analisada
      data=dadosRet2, #Objeto do tipo "data.frame" com os dados
      fill=acao, #Pintar o histograma de cada grupo de uma cor diferente
      facets = acao~., #Cada uma em um painel
      main="Histograma Retornos") #Titulo do grafico