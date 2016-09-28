##################################
# Minicurso R - Aula 3           #
##################################
# --> Importação de dados e operar datasets
# --> Inicio da revisão da disciplina "Métodos Quantitativos 1"



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
# --> 1a linha contém os nomes das variáveis
# --> Valores separados por ","
# Conjunto de dados sobre fatores de riscos de saúde de 20000 indivíduos
#
# Carregar o conjunto de dados:
dados <- read.table(file="Aula03_ConjDados_cdc.txt", header=TRUE, sep=",")
# Tipo de objeto de "dados"
class(dados)
# Ver os nomes das variáveis contidas no data.frame "dados"
names(dados)
# Ver o número de observações e de variáveis em "dados"
dim(dados)
# Ver as 5 primeiras observações em "dados"
head(dados, n = 5)
# Ver as 5 últimas observações em "dados"
tail(dados, n = 5)
# Espaço em memória ocupado pelo objeto "dados"
object.size(dados) #em bytes
print(object.size(dados), units="Kb") # em Kb
print(object.size(dados), units="Mb") # em Mb





######################################
# 3 - Análise de dados qualitativos  #
######################################
# Verificar o tipo de variável na coluna 'genhealth' de 'dados':
class(dados$genhlth) # "factor"

# Contar a frequência de cada tipo de estado de saúde em 'genhlth':
table(dados$genhlth)
#Alternativamente:
summary(dados$genhlth)

# Frequência relativa de cada estado de saúde:
table(dados$genhlth)/length(dados$genhlth)

# Frequência de fumantes nos dados
table(dados$smoke100)

# Tabela Relacionando o habito de fumar e a saúde dos indivíduos
table(dados$genhlth, dados$smoke100)

# Estabelecer uma ordem crescente nos fatores da variável "genhlth" 
dados$genhlth <- factor(dados$genhlth, 
                        order = TRUE, 
                        levels = c("excellent", "very good", "good", "fair", "poor"))

# (bis) Tabela Relacionando o habito de fumar e a saúde dos indivíduos
table(dados$genhlth, dados$smoke100)




#################################################
# 4 - Gráficos com as variáveis qualitativas    #
#################################################
# Gráfico de barras com as freqências de cda estado de saúde:
barplot(table(dados$genhlth), main ="Estados de saúde")
# Gráfico de barras com as frequências de cada sexo na amostra:
barplot(table(dados$gender), main ="Gênero")

# Gráficos de proporções:
tabSaudeFum <- table(dados$genhlth, dados$smoke100)
# Gráfico de proporções referentes a tabela acima
mosaicplot(tabSaudeFum, 
           main = "Saude Vs Fumar",
           xlab = "Saúde",
           ylab = "Fumante")

# Gráfico Mosaico apresentando as proporções de fumantes de cada sexo
tabFumGen <- table(dados$gender, dados$smoke100)
tabFumGen
mosaicplot(tabFumGen, main = "Gênero Vs. Fumantes", xlab = "Sexo", ylab="Fumante")



########################################################
# 5 - estatísticas Descritivas  de dados quantitativos #
########################################################
# --> Estatísticas descritivas básicas das observações de "height" em "dados":
# --> Argumento "na.rm=TRUE": Não leva em conta as observações faltantes (caso hajam) no cálculo
# Média:
mean(dados$height, na.rm=TRUE)
mean(dados[,5], na.rm=TRUE)
# Desvio-Padrão:
sd(dados$height, na.rm=TRUE)
# Mediana:
median(dados$height, na.rm=TRUE)
# Quartis, média e mediana
summary(dados$height)
quantile(dados$height, na.rm=TRUE)
# Ver os decis das observações de "height"
quantile(dados$height, probs=seq(from=0, to = 1, by = 0.1), na.rm=TRUE)



###################################
# 6 - Funções sapply() e tapply() #
###################################
# --> Caso queiramos realizar a mesma operação para várias colunas do nosso conjunto de dados,
#     devemos usar o comando sapply()
#
#     sapply(<conjunto_de_dados>, <função_aplicada>)
#
sapply(dados[, c(5,6,7,8)], mean) #Formato Vetor com os indeces numerados
sapply(dados[, c(5,6,7,8)], sd, simplify=FALSE) #Formato Lista

# --> Caspo queiramos realizar uma determinada operação para cada nível de uma variável do tipo fator,
#     devemos usar o comando tapply()
#
#     tapply(<coluna_dados>, <coluna_Fator>, <funcao_aplicada>)
#
# --> Retornar o peso médio em libras (weight) referente a cada grupo de 'genhealth'
tapply(dados$weight, dados$genhlth, mean)




##########################################
# 7 - Gráficos de dados quantitativos    #
##########################################
# histograma:
hist(dados$weight, main = "Histograma Peso", xlab="Peso (em lb)")

# Histograma com 60 "barras" verticais
hist(dados$weight, breaks= 60, main = "Histograma Peso", xlab="Peso (em lb)")
# Adicionar ao histograma a concentração das observações
rug(dados$weight, col="red")

#
# Histograma referente as densidades para a variavel "wtdesire"
# Ao inves de ter a frequencia no eixo-Y, queremos a densidade
hist(dados$age, freq = FALSE, main = "Histograma Idades", xlab="Idade", col="yellow")
lines(density(dados$age), col = "Green", lwd=5)

#
# Gráfico Boxplot:
boxplot(dados$height, main="Boxplot Alturas")

# Gráfico boxplot Peso e fumante
boxplot(dados$weight~dados$smoke100, #Plotar a variável "weight" e separar as observações por "smoke"
        xlab = "Fumante", # Rótulo do eixo X
        ylab = "Peso (em lb)", # Rótulo do eixo Y
        col=c("blue", "red")) #Pintar o boxplot dos não-fumantes de azul e dos fumantes de veermelho


# Gráfico de dispersão entre peso e altura:
plot(dados$weight, dados$height, 
     main = "Peso Vs. Altura",
     xlab = "Peso (em lb)",
     ylab = "Altura (em pol.)")

# Versão do gráfico colorida por gênero
plot(dados$weight, dados$height,
     col = dados$gender,
     main = "Peso Vs. Altura",
     xlab = "Peso (em lb)",
     ylab = "Altura (em pol.)")


#######################################
# Versão colorida com legenda         #
#######################################
# 1 - Adicionar as observações referentes ao sexo fenminino:
plot(x = dados$weight[dados$gender == "m"], 
     y = dados$height[dados$gender == "m"],
     main = "Peso Vs. Altura",
     xlab = "Peso (em lb)",
     ylab = "Altura (em pol.)",
     pch = 16,
     col = "blue")

# 2 - Adicionar as observações referentes ao sexo Masculino:
points(x = dados$weight[dados$gender == "f"],
       y = dados$height[dados$gender == "f"],
       pch = 8,
       col = "pink")
# 3 - Adicionar a Legenda
legend("bottomright", pch = c(8, 16), col=c("blue", "pink"), legend = c("Masculino", "Feminino"))

