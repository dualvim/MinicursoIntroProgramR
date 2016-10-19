######################################
# Extra_GraficosLattice.r            #
######################################


########################################################################
# Baixar um conjunto de dados da internet e copiar para o computador   #
########################################################################
# --> URL com o link para baixar o arquivo com os dados:
urlArq <- "https://github.com/dualvim/MinicursoIntroProgramR/raw/master/ConjuntosDeDados/Dados_Diarios_LTN.csv"

# --> Fazer download do arquivo e salvar o arquivo no diretorio de trabalho atual:
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
# (Other)   : 270                                                    

# Calcular as variâncias das variáveis quantitativas de dadosLTN:
sapply(dadosLTN[,c("Taxa_CPA", "Taxa_VDA", "PU_CPA", "PU_VDA")], FUN=var)
# Taxa_CPA     Taxa_VDA       PU_CPA       PU_VDA 
# 4.666074e-04 4.668570e-04 1.745143e+04 1.755417e+04

# Calcular os desvios-padrões das variáveis quantitativas de dadosLTN:
sapply(dadosLTN[,c("Taxa_CPA", "Taxa_VDA", "PU_CPA", "PU_VDA")], FUN=sd)
# Taxa_CPA     Taxa_VDA       PU_CPA       PU_VDA 
# 0.02160110   0.02160687 132.10387819 132.49214811




###########################################################
# Subdataset com somente as observações referentes a 2015 #
###########################################################
# --> Criar um vetor com os anos de cada data
vetorAnos <- format(dadosLTN$Data, "%Y")
vetorAnos <- as.numeric(vetorAnos)
head(vetorAnos)
tail(vetorAnos)

# --> Extrair de dadosLTN apenas os dados referentes a 2015
dadosLTN2015 <- dadosLTN[(vetorAnos==2015), ]

# --> Ver os fatores ataulmente disponíveis em dadosLTN2015$Titulo
levels(dadosLTN2015$Titulo)
# [1] "LTN 010114" "LTN 010115" "LTN 010116" "LTN 010117" "LTN 010118" "LTN 010119" "LTN 010121"
# [8] "LTN 010123"

# --> Retirar os fatores referentes aos títulos fora de dadosLTN2015
dadosLTN2015$Titulo <- as.factor(as.character(dadosLTN2015$Titulo))
levels(dadosLTN2015$Titulo)
#[1] "LTN 010116" "LTN 010117" "LTN 010118" "LTN 010121"




################################################################
# Graficos Exploratorios usando a biblioteca "lattice":        #
################################################################
library(lattice)

########################
# Gráfico de dispersão #
########################
# --> Grafico de dispersao simples
#     eixo-X: Taxa_CPA
#     eixo-Y: PU_CPA
xyplot(PU_CPA~Taxa_CPA, data=dadosLTN2015,
       main = "Preço e Taxa LTNs",
       ylim=c(min(dadosLTN2015$PU_CPA), 1000),
       xlim=c(min(dadosLTN2015$Taxa_CPA), max(dadosLTN2015$Taxa_CPA)))

# --> Plotar o mesmo gráfico de dispersão acima para cada titulo:
xyplot(PU_CPA~Taxa_CPA | Titulo, data=dadosLTN2015,
       main = "Preço e Taxa LTNs",
       xlim=c(min(dadosLTN2015$Taxa_CPA), max(dadosLTN2015$Taxa_CPA)),
       ylim=c(min(dadosLTN2015$PU_CPA), 1000))


# Grafico de dispersao, com paineis para cada grupo, com uma reta na mediane e uma reta de regressao
xyplot(PU_CPA~Taxa_CPA | Titulo, data=dadosLTN2015,
       main = "Preço e Taxa LTNs",
       panel= function(x, y, ...){
             panel.xyplot(x, y, ...) # Chama a funcao padrao de painel
             panel.abline(h = median(y), lty = 2) #Plota uma linha horiontal na mediana de PU_CPA do grupo
             panel.lmline(x, y, col = "green") #Plota uma reta de regressao
       })





####################################################
# Graficos de dispersao dos retornos de cada título #
####################################################
dotplot(Titulo~Taxa_CPA, data=dadosLTN2015,
        main="Dispersão das Taxas dos Titulos")

# Plotar um painel para cada titulo
t <- rep(1, times=length(dadosLTN2015$Titulo))
dotplot(x=t~dadosLTN2015$Taxa_CPA|dadosLTN2015$Titulo)


################
# Histograma:  #
################
histogram(x=dadosLTN2015$Taxa_CPA, xlab="Taxa_CPA")
histogram(x=Titulo~Taxa_CPA|Titulo, data=dadosLTN2015)


################
# Boxplot:     #
################
bwplot(x=dadosLTN2015$Taxa_CPA, xlab="Taxa_CPA")
bwplot(x=Titulo~Taxa_CPA|Titulo, data=dadosLTN2015)
