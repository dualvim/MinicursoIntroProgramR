##################################
# Minicurso R - Aula 4           #
##################################


# URL onde esta o arquivo com os conjuntos de dados a serem trabalhados hoje:
urlArq <- "https://github.com/dualvim/MinicursoIntroProgramR/raw/master/ConjuntosDeDados/CadastroCiasAbertas.csv"

# Carregar o conjunto de dados que iremos trabalhar agora
dados <- read.table(file=urlArq, header=TRUE, sep=";")



# --> Nomes das colunas do dataset aberto:
names(dados)
# [1] "CODIGO_CVM"            "DENOMINACAO_SOCIAL"    "DENOMINACAO_COMERCIAL" "SETOR_ATIVIDADE"      
# [5] "CNPJ"                  "DATA_REGISTRO"         "DATA_CONSTITUICAO"     "DATA_CANCELAMENTO"    
# [9] "MOTIVO_CANCELAMENTO"   "SITUACAO_REGISTRO"  



# --> Passar os caracteres com os nomes das variáveis para minúsculo:
names(dados) <- tolower(names(dados))
names(dados)
# [1] "codigo_cvm"            "denominacao_social"    "denominacao_comercial" "setor_atividade"      
# [5] "cnpj"                  "data_registro"         "data_constituicao"     "data_cancelamento"    
# [9] "motivo_cancelamento"   "situacao_registro"  

#dados$denominacao_social <- tolower(dados$denominacao_social)
#grep(" AÇO ", dados$denominacao_social, value=TRUE)

# --> Voltar para maiúsculo:
#names(dados) <- toupper(names(dados))


# --> Ver o tipo de dados de cada coluna:
sapply(dados, class)
# codigo_cvm             denominacao_social    denominacao_comercial setor_atividade 
# "integer"              "factor"              "factor"              "factor" 
# cnpj                   data_registro         data_constituicao     data_cancelamento 
# "numeric"              "factor"              "factor"              "factor" 
# motivo_cancelamento    situacao_registro 
# "factor"               "factor"




# --> Alterar os tipos de dados das colunas:
dados$denominacao_social <- as.character(dados$denominacao_social)
dados$denominacao_comercial <- as.character(dados$denominacao_comercial)
dados$cnpj <- as.character(dados$cnpj)

# --> Variável do tipo Data:
dados$data_registro <- as.Date(dados$data_registro)
dados$data_constituicao <- as.Date(dados$data_constituicao)
dados$data_cancelamento <- as.Date(dados$data_cancelamento)

# --> Ver novamente o tipo de dados de cada coluna:
sapply(dados, class)
# codigo_cvm    denominacao_social  denominacao_comercial    setor_atividade 
# "integer"     "character"         "character"              "factor" 
# cnpj          data_registro       data_constituicao        data_cancelamento 
# "character"   "Date"              "Date"                   "Date" 
# motivo_cancelamento     situacao_registro 
# "factor"              "factor"


# --> Ver o dia da semana que cada empresa foi registrada:
diaSemReg <- weekdays(dados$data_registro)
head(diaSemReg, n=12)
tail(diaSemReg)

# --> Adicionar a coluna com os dias da semana ao conjunto de dados "dados"
dados <- cbind(dados[,1:6], diaSemReg, dados[,7:dim(dados)[2]])
# Veja agora que o nosso conjunto de dados possui 11 colunas, ao invés de 10 como antes


# --> Colocar as observações do nosso conjunto de dados em ordem crescente de "codigo_cvm"
dados <- dados[order(dados$codigo_cvm, decreasing=FALSE), ]
dados <- dados[order(dados$data_registro, decreasing=FALSE), ]
# Veja que as observações estão em uma ordem diferente da que estava




######################################################################
# --> Manipulação de caracteres utilizando a biblioteca "stringr"    #
######################################################################
library(stringr)

# Função definida pelo usuário que pega os números do CNPJ e retorna uma string formatada:
formataCNPJ <- function(strCNPJ){
      # O CNPJ possui 14 dígitos e tem o seguinte formato: XX.XXX.XXX/YYYY-ZZ
      # --> Assim, o objetivo dessa função é pegar os números do CNPJ e retornar uma
      #     string com esse número formatado.
      # --> Caso a string recebida não contenha 14 caracteres, retornar ela da maneira
      #     que foi recebida
      
      # Condição if(): o número de caracteres em strCNPJ deverá ser igual a 14
      if(nchar(strCNPJ) == 14){
            # --> Caso a string possua 14 dígitos, criar uma string com os digitos formatados
            strFormatada <- paste0(substr(strCNPJ,1,2), ".")
            strFormatada <- paste0(strFormatada, substr(strCNPJ,3,5), ".")
            strFormatada <- paste0(strFormatada, substr(strCNPJ,6,8), "/")
            strFormatada <- paste0(strFormatada, substr(strCNPJ,9,12), "-")
            strFormatada <- paste0(strFormatada, substr(strCNPJ,13,14))
      }
      else{
            # Caso a string não tenha 14 caracteres, retornar o valor recebido pela função
            strFormatada <- strCNPJ
      }
      # Retornar o valor contido na variavel "strFormatada"
      return(strFormatada)
}

# Testar a funcao:
formataCNPJ("92659614000106") #[1] "92.659.614/0001-06"

# Modificar os valores da coluna "cnpj" no nosso conjuto de dados:
dados$cnpj <- sapply(dados$cnpj, formataCNPJ)



funSimples <- function(x){
      x <- x + 1
      return(x)
}
funSimples(3)






##########################################
# Mais Funções definidas pelo usuário     #
##########################################
#############
# Sintaxe:  #
#############
# f <- function(<argumentos>){
#   <Atividades a serem realizadas>
# }
valorFuturo <- function(vlrPres, tx_aa, dias){
      vf <- vlrPres*((1+tx_aa)^(dias/252))
      return(vf)
}
dias <- 110:115
valorFuturo(1000,0.12,dias)
valorFuturo(1000,0.12,170)

# Plotar gráfico com o rendimento de uma aplicação financeira
# VP = 1000; juros = 12% a.a.; período: 0 a 5000 dias úteis
dias <- seq(from = 0, to = 5000, by = 100) 
vlrFuturos <- valorFuturo(1000,0.12,dias)

plot(x=dias, y=vlrFuturos,
     type = "l",
     col = "green",
     main = "VP = 1000, i = 12% a.a.",
     xlab = "Dias",
     ylab = "Vlr Futuro (R$)",
     xlim = c(0, 5000))


# Plotar gráfico com os rendimentos a 6% a.a., 12%a.a. e 18%a.a.
vlrFuturos2 <- valorFuturo(1000,0.06,dias)
vlrFuturos3 <- valorFuturo(1000,0.18,dias)

plot(dias, vlrFuturos,
     type = "l",
     col = "green",
     main = "Montante Acumulado",
     xlab = "Dias",
     ylab = "Vlr Futuro (R$)",
     xlim = c(0, 5000))

lines(dias, vlrFuturos2, col = "red")
points(dias, vlrFuturos3, col = "blue")

# Legenda:
legend("topleft", lty= "solid", col=c("red", "green", "blue"), legend=c("6% a.a.", "12% a.a.", "18% a.a."))






##########################################
# Mais Funções definidas pelo usuário     #
##########################################
vpLTN <- function(numDias, juros_aa, vf=1000){
      vp <- vf/((1+juros_aa)^(numDias/252))
      return(vp)
}

# Vetor com as taxas de juros
taxas <- seq(from=0.01, to=0.16, by=0.01)

# Calcular os preços para cada taxa de juros, para um vencimento daqui a 126 dias úteis:
precos126 <- vpLTN(numDias=126, juros_aa=taxas, vf=1000)
# Calcular os preços para cada taxa de juros, para um vencimento daqui a 256 dias  úteis:
precos256 <- vpLTN(numDias=256, juros_aa=taxas, vf=1000)
# Calcular os preços para cada taxa de juros, para um vencimento daqui a 382 dias  úteis:
precos382 <- vpLTN(numDias=382, juros_aa=taxas, vf=1000)


# Plotar no gráfico os preços para cada prazo:
plot(x=taxas, y=precos126, main="VP Vs. i%", 
     type= "l", col="green", 
     xlab="i (%a.a.)", ylab="Preco (R$)", 
     xlim=c(0.01, 0.16), ylim=c(800,1000))

lines(x=taxas, y=precos256, col="yellow")

lines(x=taxas, y=precos382, col="red")
