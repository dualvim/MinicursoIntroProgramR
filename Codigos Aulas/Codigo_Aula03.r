##################################
# Minicurso R - Aula 3           #
##################################
# --> Importa��o de dados e operar datasets
# --> Inicio da revis�o da disciplina "M�todos Quantitativos 1"



###############################################
# Parte 1 - Alterar o diretorio de trabalho:  #
###############################################
# 1.1 - Ver o diretorio de trabalho atual do R:
getwd()

# 1.2 - Alterar o diretorio de trabalho atual do R:
setwd("C:/Users/Eduardo/Desktop/Minicurso_R/RepoMinicursoIntroProgramR/MinicursoIntroProgramR/ConjuntosDeDados/")
setwd("C:\\Users\\Eduardo\\Desktop\\Minicurso_R\\RepoMinicursoIntroProgramR\\MinicursoIntroProgramR\\ConjuntosDeDados\\")
#
# --> Como caractere de indicacao de diretorio interno, o R nao aceira o caractere "\" utilizado no Windows
# --> Como caractere de separacao de diretorios, o R aceita "\\" ou "/"



############################################
# 2 - Importar dados de um arquivo .txt    #
############################################
# --> Importar o arquivo "Dados_Aula02_cdc.txt"
# --> 1a linha cont�m os nomes das vari�veis
# --> Valores separados por ","
# Conjunto de dados sobre fatores de riscos de sa�de de 20000 indiv�duos
#
# Carregar o conjunto de dados:
dados <- read.table(file="Aula03_ConjDados_cdc.txt", header=TRUE, sep=",")
# Tipo de objeto de "dados"
class(dados)
# Ver os nomes das vari�veis contidas no data.frame "dados"
names(dados)
# Ver o n�mero de observa��es e de vari�veis em "dados"
dim(dados)
# Ver as 5 primeiras observa��es em "dados"
head(dados, n = 5)
# Ver as 5 �ltimas observa��es em "dados"
tail(dados, n = 5)
# Espa�o em mem�ria ocupado pelo objeto "dados"
object.size(dados) #em bytes
print(object.size(dados), units="Kb") # em Kb
print(object.size(dados), units="Mb") # em Mb





######################################
# 3 - An�lise de dados qualitativos  #
######################################
# Verificar o tipo de vari�vel na coluna 'genhealth' de 'dados':
class(dados$genhlth) # "factor"

# Contar a frequ�ncia de cada tipo de estado de sa�de em 'genhlth':
table(dados$genhlth)
#Alternativamente:
summary(dados$genhlth)

# Frequ�ncia relativa de cada estado de sa�de:
table(dados$genhlth)/length(dados$genhlth)

# Frequ�ncia de fumantes nos dados
table(dados$smoke100)

# Tabela Relacionando o habito de fumar e a sa�de dos indiv�duos
table(dados$genhlth, dados$smoke100)

# Estabelecer uma ordem crescente nos fatores da vari�vel "genhlth" 
dados$genhlth <- factor(dados$genhlth, 
                        order = TRUE, 
                        levels = c("excellent", "very good", "good", "fair", "poor"))

# (bis) Tabela Relacionando o habito de fumar e a sa�de dos indiv�duos
table(dados$genhlth, dados$smoke100)




#################################################
# 4 - Gr�ficos com as vari�veis qualitativas    #
#################################################
# Gr�fico de barras com as freq�ncias de cda estado de sa�de:
barplot(table(dados$genhlth), main ="Estados de sa�de")
# Gr�fico de barras com as frequ�ncias de cada sexo na amostra:
barplot(table(dados$gender), main ="G�nero")

# Gr�ficos de propor��es:
tabSaudeFum <- table(dados$genhlth, dados$smoke100)
# Gr�fico de propor��es referentes a tabela acima
mosaicplot(tabSaudeFum, 
           main = "Saude Vs Fumar",
           xlab = "Sa�de",
           ylab = "Fumante")

# Gr�fico Mosaico apresentando as propor��es de fumantes de cada sexo
tabFumGen <- table(dados$gender, dados$smoke100)
tabFumGen
mosaicplot(tabFumGen, main = "G�nero Vs. Fumantes", xlab = "Sexo", ylab="Fumante")



########################################################
# 5 - estat�sticas Descritivas  de dados quantitativos #
########################################################
# --> Estat�sticas descritivas b�sicas das observa��es de "height" em "dados":
# --> Argumento "na.rm=TRUE": N�o leva em conta as observa��es faltantes (caso hajam) no c�lculo
# M�dia:
mean(dados$height, na.rm=TRUE)
mean(dados[,5], na.rm=TRUE)
# Desvio-Padr�o:
sd(dados$height, na.rm=TRUE)
# Mediana:
median(dados$height, na.rm=TRUE)
# Quartis, m�dia e mediana
summary(dados$height)
quantile(dados$height, na.rm=TRUE)
# Ver os decis das observa��es de "height"
quantile(dados$height, probs=seq(from=0, to = 1, by = 0.1), na.rm=TRUE)



###################################
# 6 - Fun��es sapply() e tapply() #
###################################
# --> Caso queiramos realizar a mesma opera��o para v�rias colunas do nosso conjunto de dados,
#     devemos usar o comando sapply()
#
#     sapply(<conjunto_de_dados>, <fun��o_aplicada>)
#
sapply(dados[, c(5,6,7,8)], mean) #Formato Vetor com os indeces numerados
sapply(dados[, c(5,6,7,8)], sd, simplify=FALSE) #Formato Lista

# --> Caspo queiramos realizar uma determinada opera��o para cada n�vel de uma vari�vel do tipo fator,
#     devemos usar o comando tapply()
#
#     tapply(<coluna_dados>, <coluna_Fator>, <funcao_aplicada>)
#
# --> Retornar o peso m�dio em libras (weight) referente a cada grupo de 'genhealth'
tapply(dados$weight, dados$genhlth, mean)




##########################################
# 7 - Gr�ficos de dados quantitativos    #
##########################################
# histograma:
hist(dados$weight, main = "Histograma Peso", xlab="Peso (em lb)")

# Histograma com 60 "barras" verticais
hist(dados$weight, breaks= 60, main = "Histograma Peso", xlab="Peso (em lb)")
# Adicionar ao histograma a concentra��o das observa��es
rug(dados$weight, col="red")

#
# Histograma referente as densidades para a variavel "wtdesire"
# Ao inves de ter a frequencia no eixo-Y, queremos a densidade
hist(dados$age, freq = FALSE, main = "Histograma Idades", xlab="Idade", col="yellow")
lines(density(dados$age), col = "Green", lwd=5)

#
# Gr�fico Boxplot:
boxplot(dados$height, main="Boxplot Alturas")

# Gr�fico boxplot Peso e fumante
boxplot(dados$weight~dados$smoke100, #Plotar a vari�vel "weight" e separar as observa��es por "smoke"
        xlab = "Fumante", # R�tulo do eixo X
        ylab = "Peso (em lb)", # R�tulo do eixo Y
        col=c("blue", "red")) #Pintar o boxplot dos n�o-fumantes de azul e dos fumantes de veermelho


# Gr�fico de dispers�o entre peso e altura:
plot(dados$weight, dados$height, 
     main = "Peso Vs. Altura",
     xlab = "Peso (em lb)",
     ylab = "Altura (em pol.)")

# Vers�o do gr�fico colorida por g�nero
plot(dados$weight, dados$height,
     col = dados$gender,
     main = "Peso Vs. Altura",
     xlab = "Peso (em lb)",
     ylab = "Altura (em pol.)")


#######################################
# Vers�o colorida com legenda         #
#######################################
# 1 - Adicionar as observa��es referentes ao sexo fenminino:
plot(x = dados$weight[dados$gender == "m"], 
     y = dados$height[dados$gender == "m"],
     main = "Peso Vs. Altura",
     xlab = "Peso (em lb)",
     ylab = "Altura (em pol.)",
     pch = 16,
     col = "blue")

# 2 - Adicionar as observa��es referentes ao sexo Masculino:
points(x = dados$weight[dados$gender == "f"],
       y = dados$height[dados$gender == "f"],
       pch = 8,
       col = "pink")
# 3 - Adicionar a Legenda
legend("bottomright", pch = c(8, 16), col=c("blue", "pink"), legend = c("Masculino", "Feminino"))

