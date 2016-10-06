# Extra_IntervalosDeConfian�a.r
# Adapta��o do exemplo 1.5 do cop�tulo 1 do livro do Freire
# Foco em calcular o intervalo de confian�a para um determinado grupo ou para v�rios grupos.

url <- "https://github.com/dualvim/MinicursoIntroProgramR/raw/master/ConjuntosDeDados/dadosDancarinas.csv"
dados <- read.table(file=url, header=TRUE, sep=";", dec=".")

names(dados)
# [1] "id"   "peso" "alt"  "ped"  "pee"  "pem" 






# M�dia e DP da vari�vel "pem"
medPem <- mean(dados$pem) #[1] 54.2816
var(dados$pem) #[1] 152.082
dpPem <- sd(dados$pem) #[1] 12.33215

# --> Intervalo de confian�a de 90% para "pem":
# Estat�stica t para alfa = 5% e gl=162:
estT <- qt(p=0.05, df=length(dados$pem)-1, lower.tail=FALSE)

# Erro padrao de "pem"
errPadPem <- dpPem/sqrt(length(dados$pem))

# Limite inferior do intervalo de confian�a de 90%:
icInf <- medPem - estT*errPadPem #[1] 52.68365
icInf

# Limite superior do intervalo de confian�a de 90%:
icSup <- medPem + estT*errPadPem #[1] 55.87954
icSup






# M�dia de "pem" para cada idade:
mediasPem <- tapply(dados$pem, dados$id, mean)

# Desvio padr�o de "pem" para cada idade:
sdPem <- tapply(dados$pem, dados$id, sd)

# Numero de observa��es de cada idade:
numObsId <- tapply(dados$pem, dados$id, length)

# Erro Padr�o de "pem" para cada idade:
epPem <- sdPem/sqrt(numObsId)

# estatisticas t com alfa = 5% e gl de cada grupo de idades:
estTId <- sapply((numObsId-1), qt, p=0.05, lower.tail=FALSE)

#Plotar um gr�fico com os valores d "pem" para cada idade:
plot(x=dados$id, y=dados$pem, xlab="Idade", ylab="Angulo dos pes")

# Adicionar uma reta que passe pelas m�dias de cada idade
lines(x=names(mediasPem), y=mediasPem)

# Limites inferiores para o IC de 90%:
mediasPem - estTId * epPem

# Limites superiores para o IC de 90%:
mediasPem + estTId * epPem
