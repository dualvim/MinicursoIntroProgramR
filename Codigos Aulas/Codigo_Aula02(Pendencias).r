#####################################
# Minicurso R - Pendencias aula 2   #
#####################################
# Conteudo:
# 1 - Revisão de vetores e geração de números aleatórios
# 2 - 



#############################################################
# Parte 1 - Rev. Vetores e Operaoes básicas com vetores:    #
#############################################################
# 1.1 - Revisão de vetores
# Revisao de c(), seq() e rep()
vet1 <- c(1, 2.5, 10, 40, 160)
vet2 <- seq(from = 20, to=180, by=40)
vet3 <- rep(0, times=5)
# Ver os valores dos vetores
vet1 # [1]   1.0   2.5  10.0  40.0 160.0
vet2 # [1]  20  60 100 140 180
vet3 # [1] 0 0 0 0 0

# 1.2 - Revisao aobre os indices dos vetores
# Ver o valores via indice
vet1[1] # [1] 1
vet2[3:4] # [1] 100 140
vet2[c(1,3,5)] # [1]  20 100 180
vet3[3:length(vet3)] # [1] 0 0 0

# 1.3 - Revisão rápida de  Operações básicas com vetores
# 1.3.1 - Operacao entre um escalar e um veto
vet3 + 1 # [1] 1 1 1 1 1
vet1 <- vet1 + 1
vet1 # [1]   2.0   3.5  11.0  41.0 161.0
vet1 <- vet1 - 1
vet1 # 
# 1.3.2 - Operação entre dois vetores
vet3 <- vet1 * vet2
vet3 # [1]    20   150  1000  5600 28800

# 1.4 - Insercao de valores ausentes e suas consequencias
# 1.4.1 - Criar um vetor com 1 observacao ausente e outro com todas obs ausentes
vet4 <- c(1, 5, NA, 10, 20)
vet5 <- rep(NA, times=5)
vet4 # [1]  1  5 NA 10 20
vet5 # [1] NA NA NA NA NA
# 1.4.2 - Efeitos das observacoes ausentes na operacao com vetores
vet4 + vet3 # [1]    21   155    NA  5610 28820
vet1 + vet5 # [1] NA NA NA NA NA
NA * vet1 # [1] NA NA NA NA NA

# 1.4.3 - Comando is.na()
# --> Ver quais valores dos vetores vet3, vet4 e vet5 sao iguais a NA:
is.na(vet3) # [1] FALSE FALSE FALSE FALSE FALSE
is.na(vet4) # [1] FALSE FALSE  TRUE FALSE FALSE
is.na(vet5) # [1] TRUE TRUE TRUE TRUE TRUE

#1.4.5 - Subseting de vetores
obsNA_vet4 <- is.na(vet4) # Vetor com valores do tipo logical indicando quem eh igual a NA em vet4
# --> Retornar as observacoes de vet4 que sejam iguais a NA:
vet4[obsNA_vet4] # [1] NA
vet4[!obsNA_vet4] # [1]  1  5 10 20
# --> Como 'vetNA_vet4 eh um vetor de valores do tipo "logical", podemos utiliza-lo
#     para realizar subsetting em outros vetores:
vet2[obsNA_vet4] # [1] 100
vet2[!obsNA_vet4] # [1]  1  5 10 20
#
#
## --> Apagar os vetores nao mais utilizados:
rm(vet1, vet2, vet3, vet4, vet5, obsNA_vet4)




###################################################################################
# Parte 2 - Numeros Aleatorios, amostragem e estatisticas descritivas em vetores  #
###################################################################################
# 2.1 - Geracao de numeros aleatorios e amostragem
# 2.1.1 - Vetores com 10.000 numeros aleatorios, um seguindo uma dist. Normal padrao e outro uma uniforme 
vet_dist_norm <- rnorm(n=10000, mean=0, sd=1) # Num. Aleat. tirados de uma dist. Normal padrao
vet_dist_unif <- runif(n=10000, min = 0, max = 1) # Num. Aleat. entre 0 e 1
length(vet_dist_norm) # [1] 10000
length(vet_dist_unif) # [1] 10000

# 2.2 - Visualização parcial dos valores dos vetores
# 2.2.1 - Ver as 10 primeiras observacoes de um vetor e as 10 ultimas observacoes de outro:
head(vet_dist_norm, n=10)
tail(vet_dist_unif, n=10)
# --> Observar que os resultados de todos foram diferentes e se chamarmos os comandos acima novamente,
# os valores retornados serao diferentes:
# 2.2.3 - Chamando os comandos acima novamente
vet_dist_norm <- rnorm(n=10000, mean=0, sd=1)
vet_dist_unif <- runif(n=10000, min = 0, max = 1)
head(vet_dist_norm, n=10)
tail(vet_dist_unif, n=10)
# --> Os numeros aleatorios gerados foram diferentes
#
# 2.2.3 - Comando set.seed(): Faz o gerador de numeros aleatorios gerar sempre os mesmos numeros
set.seed(123)
vet_dist_norm <- rnorm(n=10000, mean=0, sd=1)
vet_dist_unif <- runif(n=10000, min = 0, max = 1)
head(vet_dist_norm, n=10)
tail(vet_dist_unif, n=10)
# --> Chamar novamente os comandos das 5 ultimas linhas  novamente e ver que os resultados permaneceram os mesmos

# 2.2.4 - Amostragem dos valores contidos nos vetores:
set.seed(123)
# Realizar uma amostragem de 11 valores, sem repeticao, no vetor "vet_dist_norm" 
amostra_sem_rep <- sample(x=vet_dist_norm, size=11, replace=FALSE)
amostra_sem_rep
# Realizar uma amostragem de 11 valores, COM REPETICAO, em uma sequencia de numeros entre 1 e 15
amostra_com_rep <- sample.int(n=15, size=11, replace=TRUE)
amostra_com_rep
#





##############################################################################
# Parte 3 - Estatisticas descritivas básicas utilizando os dados dos vetores #
##############################################################################
# 3.1 - Copiar os nossos vetores com amostras e inserir uma observacao ausente
#     em cada um desses novos vetores:
amostra_sem_rep2 <- c(amostra_sem_rep, NA)
amostra_com_rep2 <- c(amostra_com_rep, NA)

# 3.2 - Comando sum(): Soma todos os elementos de um vetor
sum(amostra_sem_rep) # [1] -2.192137
sum(amostra_com_rep) # [1] 93
sum(amostra_sem_rep2) # [1] NA
sum(amostra_com_rep2) # [1] NA

# --> Observar que a presenca de uma observacao faltante fez o R retornar NA.
# --> Para contornar esse problema, o comando sum() e todos os comandos que iremos ver abaixo
#     suportam o rgumento "na.rm=TRUE", que retira as obseervacoes faltantes do vetor analisado
#     e, entao, calcula a operacao desejada.
# --> Na ausencia do argumento "na.rm=TRUE", o R ira retornar NA caso haja uma observacao ausente.
# --> Se utilizarmos esse argumento em um vetor sem observacoes faltantes, nada ira impactar no calculo
# 3.3 - Efeitos do argumento "na.rm=TRUE":
sum(amostra_sem_rep2, na.rm=TRUE) # [1] -2.192137
sum(amostra_com_rep2, na.rm=TRUE) # [1] 93

# 3.3 - Comandos min() e max()
min(amostra_sem_rep2, na.rm=TRUE) # [1] -2.395835
min(amostra_com_rep2, na.rm=TRUE) # [1] 1
max(amostra_sem_rep2, na.rm=TRUE) # [1] 15
max(amostra_com_rep2, na.rm=TRUE) # [1] -2.192137

# 3.4 - Comando referente as estatisticas descritivas basicas:
# mean() - Média
# median() - Mediana
# var() - variância
# sd() - Desvio padrão
mean(vet_dist_norm, na.rm=TRUE) # [1] -0.003288021
median(vet_dist_norm, na.rm=TRUE) # [1] -0.005034857
var(vet_dist_norm, na.rm=TRUE) # [1] 0.9856869
sd(vet_dist_norm, na.rm=TRUE) # [1] 0.9928177

# 3.5 - Resumo com os quantis dos dados:
# 3.5.1 - Ver oo minimo, o maximo, os quartis, a media e a mediana
summary(vet_dist_norm)
# 3.5.1 - Ver os quantis dos dados. No caso abaixo, os decis
quantile(vet_dist_norm, probs=seq(from=0, to=1, by=0.1))
quantile(vet_dist_norm, probs=seq(from=0, to=1, by=0.2))

quantile(amostra_sem_rep2, probs=seq(from=0, to=1, by=0.2), na.rm=TRUE)
summary(amostra_sem_rep2)




#######################################################
# Parte 4 - Revisao do conteudo visto ate agora       #
#######################################################
# Criar um vetor com 10000 observacoes iguais a NA:
vetor_NA <- rep(NA, times=10000)
#
# Concatenar os vetores vet_dist_norm e vetor_NA e selecionar 100 valores aleatórios:
meus_dados <- sample(x=c(vet_dist_norm, vetor_NA), size=100, replace=FALSE)
meus_dados
#
length(meus_dados) #[1] 100
class(meus_dados) #[1] "numeric"
object.size(meus_dados) #840 bytes
#
# Ver as 10 primeiras observações e as 10 últimas observações do vetor 'meus_dados'
head(meus_dados, n=10)
tail(meus_dados, n=10)
#
# Criar um vetor, do tipo 'logical' avisando quais observações são iguais a NA:
# comando is.na() Retorna TRUE caso o valor seja igual a NA
obsNA <- is.na(meus_dados)
obsNA
head(obsNA, n=10)
tail(obsNA, n=10)
#
# Contar quantas observações do vetor 'meus_dados' é igual a NA:
sum(obsNA) #[1] 46


# Apresentar os dados do vetor "meus_dados" cujas observacoes sao diferentes de NA
meus_dados[!obsNA]

# Calcular as estatisticas descritivas desse vetor:
mean(meus_dados, na.rm=TRUE)
median(meus_dados, na.rm=TRUE)
var(meus_dados, na.rm=TRUE)
sd(meus_dados, na.rm=TRUE)
# Sumario dos valores dos dados:
summary(meus_dados)
quantile(meus_dados, probs=seq(from=0, to=1, by=0.1), na.rm=TRUE)

# Retornar os valores de meus_dados diferentes de NA e maiores que 0:


# comando identical()
meus_dados2 <- meus_dados
meus_dados3 <- sample(c(vet_dist_norm, vetor_NA), size=100, replace=FALSE)
identical(meus_dados, meus_dados2) #[1] TRUE
identical(meus_dados, meus_dados3) #[1] FALSE






############################################
# Parte 6: Mais subamostragens de vetores     #
############################################

# Filtrar o vetor meus_dados2 para que este contenha apenas valores maiores que 0 e diferentes de NA
vetor_filtro <- (!is.na(meus_dados)) & (meus_dados >= 0)
head(vetor_filtro)
tail(vetor_filtro)
# Modificar o vetor meus_dados2 para conter apenas os valores que atendam os critérios de vetor_filtro
meus_dados2 <- meus_dados[vetor_filtro]
mean(meus_dados2)
sd(meus_dados2)
sum(meus_dados2)
min(meus_dados2)
max(meus_dados2)






######################################################
# Conteudo Extra, apresentado rapidamente na aula    #
######################################################
# --> Conteudo apresentado rapidamente somente a titulo de curiosidade


# Histograma com os dados do vetor com numeros aleatorios de uma distribuicao normal padrao
hist(vet_dist_norm)


# Gráfico de dispersao com os dados dos dois vetores com 10.000 numeros aleatorios
plot(vet_dist_unif, vet_dist_norm, 
     col="blue", pch=10,
     main="Titulo do Grafico",
     xlab="Eixo X",
     ylab="eixo Y")


#Funcao definida pelo usuario
# --> Calcular o preco de uma LTN
funcao_CalcVPLTN <- function(numDias, juros_aa, vf=1000){
      vp <- vf/((1+juros_aa)^(numDias/252))
      return(vp)
}
# --> Chamar a funcao criada acima
funcao_CalcVPLTN(numDias=500, juros_aa=0.1207) #Caso deseje que o valor de fce seja R$1.000, nao ha a necessidade de inserir o 3o argumento
funcao_CalcVPLTN(numDias=500, juros_aa=0.1207, vf=10000) # Caso o valor de face seja diferente de R$1.000, devemos inserir o 3o argumento
