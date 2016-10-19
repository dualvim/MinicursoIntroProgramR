###################
# Extra_MatFin.r  #
###################


########################################################################
# Baixar um conjunto de dados da internet e copiar para o computador   #
########################################################################
# --> URL com o link para baixar o arquivo com os dados:
urlArq <- "https://github.com/dualvim/MinicursoIntroProgramR/raw/master/ConjuntosDeDados/Dados_Diarios_LTN.csv"

# --> Fazer download do arquivo e salvar o arquivo na área de trabalho:
download.file(url=urlArq, destfile="dados_aula_05.txt", mode="wb")
# --> Observe que o arquivo que esta no github se chama "Dados_Diarios_LTN.csv" e
#     a extensao desse arquivo lá é .csv
# --> Ao salvar o arquivo no computador, modificamos o nome e a extensão do arquivo.
# --> O comando download.file() permite renomearmos tanto o arquivo quanto a sua extensao.

# Apagar urlArq
rm(urlArq)



#################################################
# Dataset com os dados diarios das LTNs:        #
#################################################
# --> Carregar o conjunto de dados contido no arquivo baixado:
dadosLTN <- read.table(file="dados_aula_05.txt", 
                       header = TRUE, 
                       sep = ";", 
                       dec = ",")

# --> Dimensoes de dadosLTN
dim(dadosLTN) #[1] 4894    6
# --> Memória utilizada por dadosLTN:
print(object.size(dadosLTN), units="Kb") #212.5 Kb

# --> Ver o tipo de dado de cada coluna em dadosLTN:
sapply(dadosLTN, class)
# Data    Titulo  Taxa_CPA  Taxa_VDA    PU_CPA    PU_VDA 
# "factor"  "factor" "numeric" "numeric" "numeric" "numeric" 

# --> Converter o tipo de dado da colunas "Data" para 'Date':
dadosLTN$Data <- as.Date(dadosLTN$Data)

# --> Conferir se o tipo de dado de cada coluna de dadosLTN é o que queremos:
sapply(dadosLTN, class)
# Data    Titulo  Taxa_CPA  Taxa_VDA    PU_CPA    PU_VDA 
# "Date"  "factor" "numeric" "numeric" "numeric" "numeric"

# --> Sumário estatístico das variaveis do conjunto de dados:
summary(dadosLTN)
# Data                 Titulo            Taxa_CPA         Taxa_VDA         PU_CPA         PU_VDA  
# Min.   :2011-01-03   LTN 010115:1004   Min.   :0.0688   Min.   :0.0692   Min.   :346.7  Min.   :345.5  
# 1st Qu.:2012-12-27   LTN 010116: 981   1st Qu.:0.1022   1st Qu.:0.1027   1st Qu.:707.4  1st Qu.:706.3
# Median :2014-03-31   LTN 010117: 897   Median :0.1198   Median :0.1204   Median :785.2  Median :784.2
# Mean   :2014-03-02   LTN 010114: 749   Mean   :0.1170   Mean   :0.1175   Mean   :775.8  Mean   :775.0
# 3rd Qu.:2015-07-03   LTN 010118: 637   3rd Qu.:0.1299   3rd Qu.:0.1305   3rd Qu.:873.9  3rd Qu.:873.4
# Max.   :2016-08-08   LTN 010121: 356   Max.   :0.1672   Max.   :0.1678   Max.   :999.2  Max.   :999.2





######################################################
# Dataset com apenas os dados do titulo 'LTN 010116' #
######################################################
dadosLTN010116 <- dadosLTN[(dadosLTN$Titulo=="LTN 010116"), ]



###############################################
# Estatísticas descritivas de dadosLTN010116  #
###############################################
# --> Sumario estatistico das principais colunas de dadosLTN010116:
summary(dadosLTN010116[,c("Data", "Taxa_CPA", "Taxa_VDA", "PU_CPA", "PU_VDA")])
# Data               Taxa_CPA         Taxa_VDA          PU_CPA          PU_VDA     
# Min.   :2012-02-01   Min.   :0.0799   Min.   :0.0805   Min.   :666.5   Min.   :665.1  
# 1st Qu.:2013-01-29   1st Qu.:0.0949   1st Qu.:0.0955   1st Qu.:779.6   1st Qu.:778.3  
# Median :2014-01-20   Median :0.1150   Median :0.1154   Median :801.4   Median :800.7  
# Mean   :2014-01-17   Mean   :0.1138   Mean   :0.1143   Mean   :829.0   Mean   :828.2  
# 3rd Qu.:2015-01-08   3rd Qu.:0.1278   3rd Qu.:0.1282   3rd Qu.:889.6   3rd Qu.:889.3  
# Max.   :2015-12-31   Max.   :0.1489   Max.   :0.1492   Max.   :998.9   Max.   :998.9 

# Carregar a biblioteca "RcmdrMisc"
library(RcmdrMisc)
# library(Rcmdr) #Abrir o 'R Commander', interface grafica do R.

# --> numSummary(): Função da biblioteca "RcmdrMisc" que retorna uma tabela com as principais 
#     estatisticas descritivas.
# --> Podemos executar esse comando graficamente no Rcomander
numSummary(dadosLTN010116[,c("PU_CPA", "PU_VDA", "Taxa_CPA", "Taxa_VDA")], 
           statistics=c("mean", "sd", "se(mean)", "IQR", "cv", "skewness", "kurtosis"),
           quantiles=c(0,.25,.5,.75,1), type="2")
# mean          sd     se(mean)      IQR         cv    skewness   kurtosis   n
# PU_CPA   828.9568705 80.69703559 2.5764580609 109.9200 0.09734769  0.26193629 -0.6780277 981
# PU_VDA   828.1914373 81.15915764 2.5912124824 110.9400 0.09799565  0.26145718 -0.6844090 981
# Taxa_CPA   0.1137863  0.01916226 0.0006118038   0.0329 0.16840559 -0.02013456 -1.1318607 981
# Taxa_VDA   0.1142847  0.01906569 0.0006087206   0.0327 0.16682624 -0.02422033 -1.1311518 981
# --> Média, desvio-padrão, erro-padrão da média, distância interquartilica, coeficiente de variação, assimetria, curtose e n

# --> Correlação (de Pearson) entre as taxas e os preços dos títulos:
cor(dadosLTN010116$PU_CPA, dadosLTN010116$Taxa_CPA) #[1] 0.8170277
cor(dadosLTN010116$PU_VDA, dadosLTN010116$Taxa_VDA) #[1] 0.8166006

# --> Correlação (de Spearman) entre as taxas e os preços dos títulos:
cor(dadosLTN010116$PU_CPA, dadosLTN010116$Taxa_CPA, method="spearman") #[1] 0.8490418
cor(dadosLTN010116$PU_VDA, dadosLTN010116$Taxa_VDA, method="spearman") #[1] 0.8493905

# --> Correlação (de Kendall) entre as taxas e os preços dos títulos:
cor(dadosLTN010116$PU_CPA, dadosLTN010116$Taxa_CPA, method="kendall") #[1] 0.6346525
cor(dadosLTN010116$PU_VDA, dadosLTN010116$Taxa_VDA, method="kendall") #[1] 0.6342789




######################################################
# Calcular o número de dias úteis e dias corridos    #
######################################################
# --> Baixar o arquivo com os dados dos dias uteis
# URL com um arquivo RDS com os dias úteis entre 01-01-2001 e 31-12-2078
urlArq <- "https://github.com/dualvim/MinicursoIntroProgramR/raw/master/ConjuntosDeDados/diasUteis.RDS"
# Baixar o arquivo RDS do link em urlArq e salvar na area de trabalho:
download.file(url=urlArq, destfile="diasUteis.RDS", mode="wb")
#Remover urlArq
rm(urlArq)


# --> Carregar o vetor com os dias uteis:
# readRDS(): Comando do R que lê os dados contidos em um arquivo .RDS
diasUteis <- readRDS("diasUteis.RDS")


# --> Funcao que conta os dias uteis entre duas datas, usando o 
#     como input a data inicial e a data final
retornaNumDU <- function(data1, data2){
      dia1 <- as.Date(data1)
      dia2 <- as.Date(data2)
      numDias <- length(diasUteis[(diasUteis>dia1) & (diasUteis<dia2)]) 
      return(numDias)
}

# --> Calcular o número de dias úteis entre cada data de dadosLTN010116$Data e 01/01/2016:
dataFinal <- as.Date("2016-01-01")
Dias_Uteis <- sapply(dadosLTN010116$Data, retornaNumDU, data2=dataFinal)
head(Dias_Uteis) #[1] 984 983 982 981 980 979
tail(Dias_Uteis) #[1] 5 4 3 2 1 0
# --> Calcular quantos anos se refere cada elemento do vetor Dias_Uteis (1 ano = 252 dias úteis)
Anos <- Dias_Uteis/252
head(Anos) #[1] 3.904762 3.900794 3.896825 3.892857 3.888889 3.884921
tail(Anos) #[1] 0.019841270 0.015873016 0.011904762 0.007936508 0.003968254 0.000000000


# --> Vetor com número de dias úteis entre cada data em dados LTN010116$Data e dataFinal
diasCorridos <- (dataFinal-1) - dadosLTN010116$Data
diasCorridos <- as.numeric(diasCorridos)
diasCorridos <- sort(diasCorridos, decreasing=FALSE)
head(diasCorridos)
tail(diasCorridos)

# --> Adicionar a dadosLTN010116 colunas com os valoress de Dias_Uteis, Anos e diasCorridos
dadosLTN010116 <- cbind(dadosLTN010116, Dias_Uteis, Anos, diasCorridos)
# Apagar Dias_Uteis, Anos e diasCorridos
rm(Dias_Uteis, Anos, diasCorridos)




###############################
# Matemática Financeira no R  #
###############################
# Carregar a biblioteca 'FinCal', a qual contém funções de matemática financeira
library(FinCal)
# Nomes dos argumentos usados nas funções dessa biblioteca:
# r --> Taxa de desconto a ser capitalizada em cada período
# n --> Número de períodos
# pv --> Valor presente
# fv --> Valor futuro
# pmt --> Valor dos pagamentos
# type = 0 --> O pagamento ocorre no final do período
# type = 1 --> O pagamento ocorre no início do período
# hpr --> Taxa de retorno bruta de um investimento
# ev --> Valor do investimento na data inicial
# bv --> Valor do investimento na data final
# t --> dias até o vencimento

# --> Dados da "LTN 010116" no dia 01/02/2012:
dadosLTN010116[1, ]
# Data       Titulo       Taxa_CPA  Taxa_VDA  PU_CPA  PU_VDA  Dias_Uteis   Anos
# 2012-02-01 LTN 010116   0.1095    0.1101    666.48  665.07  984          3.904762 

# --> Iremos comprar, em 01/02/2012 uma "LTN 010116" por R$666.48 e taxa de retorno de 10.95%
# --> Calcular os valores encontrados na 1a linha de dadosLTN010116 usando as funções de FinCal:

####################
# Valor Presente:  #
####################
# pv.simple(): Calcula o valor presente sem levar em conta pagamentos periódicos
precoTit1 <- pv.simple(r=dadosLTN010116$Taxa_CPA[1], n=dadosLTN010116$Anos[1], fv = -1000) #
precoTit1 #[1] 666.4823
# pv(): Calcula o valor presente levando em conta também pagamentos periódicos
precoTit1 <- pv(r=dadosLTN010116$Taxa_CPA[1], n=dadosLTN010116$Anos[1], fv = -1000, pmt = 0, type = 0)
precoTit1 #[1] 666.4823
# -->Truncar o precoTit em 2 casas decimais (obs: truncar é diferente de arredondar)
precoTit1 <- as.integer(precoTit1*100)/100
precoTit1 #666.48

####################
# Valor Futuro:    #
####################
# fv.simple(): Calcula o valor futuro sem levar em conta pagamentos periódicos
vlrFaceTit <- fv.simple(r=dadosLTN010116$Taxa_CPA[1], n=dadosLTN010116$Anos[1], pv = -precoTit1)
vlrFaceTit #[1] 999.9966
# fv(): Calcula o valor futiro levando em conta também pagamentos periódicos
vlrFaceTit <- fv(r=dadosLTN010116$Taxa_CPA[1], n=dadosLTN010116$Anos[1], pv = -precoTit1, pmt = 0, type = 0)
vlrFaceTit #[1] 999.9966
# --> Arredondar o valor de vlrFaceTit em duas casas decimais:
vlrFaceTit <- round(vlrFaceTit, digits=2)
vlrFaceTit #[1] 1000

#################################
# Taxa de Rentabilidade Bruta:  #
#################################
# hpr2ear() --> Calcula a taxa de retorno bruta do investimento
rentBruta <- hpr(ev=vlrFaceTit, bv=precoTit1)
rentBruta #[1] 0.5004201
(vlrFaceTit/precoTit1)-1 #[1] 0.5004201

#################################
# Taxa de desconto (maneira 1)  #
#################################
# hpr2ear(): Converte a taxa de retorno bruto do período em taxa efetiva anual: 
txDesc <- hpr2ear(hpr=rentBruta, t=dadosLTN010116$diasCorridos[1])
txDesc <- round(txDesc, digits=4)
txDesc # [1] 0.1091
# --> Valor calculado para essa taxa está errado, uma vez que foi calculado
#     usando dias corridos, e o cálculo do Tesouro Direto é com dias úteis
# --> Utilizar hpr2ear() em situações que calcule os juros usando dias corridos, naão nessa situação

#################################
# Taxa de desconto (maneira 2)  #
#################################
# discount.rate(): Calcula a taxa de desconto
txDesc <- discount.rate(n=dadosLTN010116$Anos[1], pv=-precoTit1, fv=vlrFaceTit, pmt=0, type = 0)
txDesc #[1] 0.1094994
# --> Arredondar a taxa de desconto para 4 casas decimais:
txDesc <- round(txDesc, digits=4)
txDesc #[1] 0.1095
# Essa é a maneira correta de se calcular a taxa de desconto



#############################
# Preço do título na curva  #
#############################
# --> Vetor com os valores do título na curva entre a data de compra e a de venda
PU_Curva <- pv.simple(r=txDesc, n=dadosLTN010116$Anos, fv = -vlrFaceTit)
# --> Truncar os valores de PU_Curva em 2 casas deciimais:
PU_Curva <- as.integer(PU_Curva*100)/100
# Valores de PU_Curva
head(PU_Curva)
tail(PU_Curva)




#######################################################################################
# Rentabilidade de uma venda antecipada do título em cada data em dadosLTN010116$Data #
#######################################################################################
#
# --> Função que retorna a alíquota de IR a ser cobrada na data da venda do titulo
retAliqIR <- function(diasCorr){
      if(diasCorr < 180){
            aliquota <- 0.2250
      } else if(diasCorr < 360){
            aliquota <- 0.20
      } else if(diasCorr < 720){
            aliquota <- 0.175
      } else{
            aliquota <- 0.15
      }
      return(aliquota)
}
# # Testar a função retAliqIR():
# head(sapply(dadosLTN010116$diasCorridos, FUN=retAliqIR), n=10)
# #[1] 0.225 0.225 0.225 0.225 0.225 0.225 0.225 0.225 0.225 0.225
# tail(sapply(dadosLTN010116$diasCorridos, FUN=retAliqIR), n=10)
# #[1] 0.15 0.15 0.15 0.15 0.15 0.15 0.15 0.15 0.15 0.15


# --> Função que calcula o valor liquido resgatado (após o IR)
retVlrLiqResg <- function(pCpa, pVda, nDiasCorr){
      # 1 - Pegar a aliquota de IR incidente na venda do título na data atual:
      aliqIR <- retAliqIR(nDiasCorr)
      # 2 - Calcular o valor do imposto de renda:
      if((pVda-pCpa) > 0){
            irPagar <- (pVda-pCpa)*aliqIR
      } else{
            irPagar <- 0
      }
      # 3 - calcular o valor liquido do resgate
      vlrResg <- pVda - irPagar
      # 4 - Retornar vlrResg:
      return(vlrResg)
}
# # Testar a função retVlrLiqResg()
# retVlrLiqResg(pCpa=precoTit1, pVda=dadosLTN010116$PU_VDA[6], nDiasCorr=dadosLTN010116$diasCorridos[6])
# #[1] 667.5417

# --> Função que calcula a taxa de retorno liquida do resgate:
retTaxaRetornoLiq <- function(pCpa, pVda, dataCpa, dataVda){
      # 1 - Calcular o numero de dias uteis entre a data de compra e de venda
      du <- retornaNumDU(data1=as.Date(dataCpa), data2=as.Date(dataVda))
      # 2 - Calcula a rentabilidade bruta no periodo entre a data de compra e de venda
      rBruta <- pVda/pCpa
      # 3 - Calcular a taxa de retor ano ano (1 ano = 252 dias uteis)
      taxa_aa <- (rBruta^(252/du)) - 1
      # 4 - Arredondar o valor de 'taxa_aa' em 4 casas decimais:
      #taxa_aa <- round(taxa_aa, digits=4)
      # 5 - Retornar o valor de 'taxa_aa'
      return(taxa_aa)
}
# # Testar a função retTaxaRetornoLiq():
# retTaxaRetornoLiq(pCpa=733.86, pVda=1000, dataCpa="2012-01-03", dataVda="2015-01-01")
# #[1] 0.1088044



# --> Vetor com os indices dos elementos 2 ate a ultima linha de dadosLTN010116$:
vetIdx <- 2:length(dadosLTN010116$PU_VDA)

# --> Gerar vetor com os valores a serem resgatados em cada dia útil em dadosLTN010116$Data:
vetValsResgLiq <- mapply(FUN=retVlrLiqResg, 
                         pVda=dadosLTN010116$PU_VDA[vetIdx],
                         nDiasCorr=dadosLTN010116$diasCorridos[vetIdx],
                         pCpa=precoTit1)
# Ver os valores de "vetValsResgLiq" 
head(vetValsResgLiq)
tail(vetValsResgLiq)
length(vetValsResgLiq)



# --> Gerar vetor com os valores na curva liquidos entr a data de compra e de venda:
vetValsCurvaLiq <- mapply(FUN=retVlrLiqResg, 
                          pVda=PU_Curva[vetIdx],
                          nDiasCorr=dadosLTN010116$diasCorridos[vetIdx],
                          pCpa=precoTit1)
# Ver os valores de "vetValsCurvaLiq" 
head(vetValsCurvaLiq)
tail(vetValsCurvaLiq)
length(vetValsCurvaLiq)





############################################
# Plotar graficos do pacote 'base' do R:   #
############################################
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


##############################
# barplot()                  #
##############################
# Gráfico de barras com a frequencia de cada título em dadosLTN:
freqTitulos <- table(as.character(dadosLTN$Titulo))

# Pegar os pontos médios de cada barra do grafico de barras:
ptosMedios <- barplot(freqTitulos)
ptosMedios

#
# Grafico de barras com as frequencias dos titulos:
barplot(freqTitulos, 
        col="chartreuse1", # Cor das barras do gráfico
        las=1.75, # Orientação dos rótulos nos eixos do gr-afico
        cex.axis=0.75, # Tamanho da fonte nos valores dos eixos
        col.axis = "chocolate1", # Cor dos eixos e valores dos eixos
        ylab="Frequencia", # Rótulo do eixo Y
        ylim = c(0, 1100), #Intervalo de valores do eixo Y
        col.lab = "cyan1", # Cor dos rótulos dos eixos X e Y
        main="Num. Obs. Titulos", #Título do grafico
        col.main = "cyan1") # Cor do título

# --> Adicionar textos aos grafico:
text(x=ptosMedios[1], y=910, "2014", pos=3, col="red")
text(x=ptosMedios[2], y=910, "2015", pos=3, col="firebrick4")
text(x=ptosMedios[3], y=910, "2016", pos=3, col="red")
text(x=ptosMedios[4], y=910, "2017", pos=3, col="firebrick4")
text(x=ptosMedios[5], y=910, "2018", pos=3, col="red")
text(x=ptosMedios[6], y=910, "2019", pos=3, col="firebrick4")
text(x=ptosMedios[7], y=910, "2021", pos=3, col="red")
text(x=ptosMedios[8], y=910, "2023", pos=3, col="firebrick4")





###############################
# plot(), points(), lines()   #
###############################
names(dadosLTN010116)


#########################################
# Grafico Preço Mercado Vs Preço Curva  #
#########################################
# --> Alterar os valor do parâmetro "cex", de modo que o tamanho das letras fique menor
par("cex"=0.75)

# --> Inicializar o grafico mas não adicionar nenhum dado ao grafico
plot(x=dadosLTN010116$Data, y=PU_Curva, 
     type="n",
     xlab="Dia", 
     ylab="Preço Unitário",
     main="PU LTN010116")

# --> Plotar uma linha vertical na metade do período analisado:
centro <- ceiling(length(dadosLTN010116$Data)/2)
# Função abline(): Insere uma linha horizontal ou vertical no gráfico
#     --> h: valor de y onde será plotada uma linha horizontal
#     --> v: Valor de x onde será plotada uma linha vertical
abline(v=dadosLTN010116$Data[centro], lty=2, lwd=2)

# --> Inserir uma legenda no gráfico:
legend("bottomright", #Posição da legenda ("bottom", "bottomleft", "left", "topleft", "top", "topright", "right", "bottomright" , "center")
       lty=c(2,1), #Tipo de linhas a serem inseridas nas legendas
       lwd=c(2,2), #Espessura das linhas a serem inseridas na legenda
       col=c("blue", "red"), #Cores das linhas da legenda
       legend=c("Preço-Curva", "Preço-Mercado"), #Rótulo das legendas
       horiz=TRUE) # Apresentar os valores da legenda na horzontal

# --> Plotar os valores do título na curva de juros contratada (10.88% a.a.):
lines(x=dadosLTN010116$Data, y=PU_Curva, type="l", 
      col="blue", lty=3, lwd=1)

# --> Plotar uma linha com os preços de venda da LTN010116 ao longo do período analisado:
lines(x=dadosLTN010116$Data, y=dadosLTN010116$PU_VDA, 
      col="red", lty=1, lwd=1)




###############################
# Gráfico PU_VDA Vs Taxa_VDA  #
###############################
# --> Inicializar o grafico mas não adicionar nenhum dado ao grafico
plot(x=dadosLTN010116$Taxa_VDA, y=dadosLTN010116$PU_VDA,
     type="n",
     main = "Taxa_VDA Vs PU_Venda",
     col.main = "darkgoldenrod",
     xlab="Taxa Venda (% a.a.)",
     ylab="Preço Unitário",
     col.lab = "darkolivegreen1")

# --> Inserir os pontos no gráfico:
points(x=dadosLTN010116$Taxa_VDA, y=dadosLTN010116$PU_VDA,
       pch=13, col="red")

# --> Inserir uma reta vertical no valor da mediana :
abline(lm(dadosLTN010116$PU_VDA~dadosLTN010116$Taxa_VDA), lwd=2)

# --> Escrever no gráfico o valor da correlação entre as duas variáveis:
text(x=0.085, y=950, paste0("correl = ", round(cor( dadosLTN010116$PU_VDA,dadosLTN010116$Taxa_VDA), digits=3)), pos=3)




#################################
# Regressão PU_VDA Vs Taxa_VDA  #
#################################
# --> Multiplicar as taxas de venda por 100:
TaxasVda100 <- dadosLTN010116$Taxa_VDA*100

# --> Estimar o seguinte modelo de regressão:
#           PU_VDA = a + b*Taxa_VDA
modRegressao <- lm(dadosLTN010116$PU_VDA~TaxasVda100)

# --> Ver os valores e as estatísticas t dos coeficientes do modelo de regressão
summary(modRegressao)
# Call:
#       lm(formula = dadosLTN010116$PU_VDA ~ TaxasVda100)
# 
# Residuals:
# Min      1Q      Median   3Q      Max 
# -148.57  -30.65  10.84    32.45   78.33 
# 
# Coefficients:
#              Estimate   Std. Error  t value   Pr(>|t|)    
# (Intercept)  430.9241   9.0984      47.36     <2e-16 ***
# TaxasVda100  34.7612    0.7853      44.27     <2e-16 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 46.87 on 979 degrees of freedom
# Multiple R-squared:  0.6668,	Adjusted R-squared:  0.6665 
# F-statistic:  1959 on 1 and 979 DF,  p-value: < 2.2e-16
################################################################################
# --> Os resultados acima confirmam o óbvio de que de que o preço e a taxa     #
#     do título possuem uma relação significativa simplesmente porque o        #
#     valor do preço de venda irá depender da taxa de venda!                   #
################################################################################




##########################
# Resíduos da regressão  #
##########################
# --> A média dos resíduos é igual a 0:
mean(modRegressao$residuals) #[1] 7.994511e-15
# --> variância dos respiduos:
var(modRegressao$residuals) #[1] 2194.484


#############################################
# Gráfico com os resíduos da regressão      #
#############################################
par("cex"= 1)

# --> Inicializar o gráfico
plot(x=TaxasVda100, y=modRegressao$residuals,
     type="n",
     ylim = c(-150, 85),
     xlab="Taxas Venda (%a.a.)",
     ylab="Resíduos",
     col.lab = "darkorange2",
     col.axis = "darkorange1",
     main = "TaxasVda100 Vs Resíduos",
     col.main = "darkorange2")

# --> Plotar os pontos
points(x=TaxasVda100, y=modRegressao$residuals, 
       pch=4, col="firebrick3")

# --> Plotar linha horizontal em y=0
abline(h=0, lty=5, lwd=2, col="gold4")

# --> Voltar ao tamanho normal da fonte:
#par("cex"= 1)

# --> Inserir texto no gráfico:
textoGraf <- "--> O resultado apresentado aqui sugere a existência de"
text(x=15, y=-90, textoGraf, cex=1, pos=2, col="purple3")
textoGraf <- "heterocedaticidade, isto é, a variância dos resíduos não é constante!"
text(x=15, y=-100, textoGraf, cex=1, pos=2, col="purple3")
textoGraf <- "--> Além disso, esses resultados sugerem que os resíduos não são aleatórios!"
text(x=15, y=-110, textoGraf, cex=1, pos=2, col="purple3")