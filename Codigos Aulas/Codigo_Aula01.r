##############################
# Minicurso R - Aula 1:      #
##############################
# -->Conte�do Geral para come�ar a usar o R
# 1 - Opera��es matem�ticas no R
# 2 - Opera��es l�gicas no R
# 3 - Atribui��es de vari�veis e opera��es usando variaveis
# 4 - Comandos ls(), class() e str()
# 5 - Vetores (!Important�ssimo!)
# 6 - Gera��o de N�meros aleat�rios no R



#####################################
# 1 - Opera��es Matem�ticas no R    #
#####################################
# --> Podemos Utilizar o R para realizar opera��es matem�ticas da mesma maneira que utilizamos uma calculadora
5+6 # Soma
3-2 # subtra��o
5*8 # Multiplica��o
1/2 # Divis�o
2^6 # Exponencia��o
exp(10) #Exponencial (e^x)
log(100) #logaritmo natural
log10(100) #logaritimo base 10
log(100, base=10) #Logaritmo




############################################
# 2 - Opera��es l�gicas no R               #
############################################
# --> O R tamb�m realiza opera��es l�gicas, que retornam os valores TRUE ou FALSE
## Igual '=='
1 == 2
3 == 3
TRUE == TRUE
TRUE == FALSE

## Diferente '!="
1 != 2
3 != 3
TRUE != TRUE
TRUE != FALSE

## Bang operator (not) '!'
!TRUE # ir� retornar 'FALSE'
!(1 == 2) # ir� retornar 'TRUE'
!FALSE # ir� retornar 'TRUE'

## Operador OU '|'
# Ir� retornar TRUE se uma das premissas for verdadeira
TRUE | TRUE # ir� retornar 'TRUE'
TRUE | FALSE # ir� retornar 'TRUE'
FALSE | FALSE # ir� retornar 'FALSE'

## Operador E '&'
# Ir� retornar TRUE somente se todas as premissas forem verdadeiras
TRUE & TRUE # ir� retornar 'TRUE'
TRUE & FALSE # ir� retornar 'FALSE'
FALSE & FALSE # ir� retornar 'FALSE'

## Operadores '<', '>', '<=' e '>='
2 > 1
3 < 5
6 <= 6
7 >= 8




#####################################################################
# 3 - Atribui��es de vari�veis e opera��es usando variaveis         #
#####################################################################
#
# Para criar uma vari�vel, devemos utilizar o poperador de atribui��o '<-'
# Sintaxe: <nome_da_variavel> <- <valor_da_variavel>
x <- 40
y <- 2.5
verdade <- TRUE
mentira <- FALSE
meu_texto <- "Ola mundo!"
#
# No RStudio, observar em "Enviroment" as vari�veis criadas e seus respectivos valores.
#

### A partir dos nomes das vari�veis, podemos realizar opera��es matem�ticas e de 
#     l�gica somente escrevendo os nomes das variaveis
x + y
y * 2
(x > 40) || (y < 3)
(x > 40) & (y < 3)
verdade | mentira
verdade & mentira
meu_texto == "meu texto"
meu_texto != "meu texto"

### Tambpem podemos modificar os valores das vari�veis com opera��es e criar novas
#     variaveis a partir de vari�veis existentes
x <- x + y
nova_variavel <- x + 2*x




#######################################
# 4 - Comandos ls(), class() e str()  #
#######################################
## ls(): Apresenta todo os objetos (variaveis, funcoes, conjuntos de dados, etc) salvos na area de trabalho atual:
ls()

## class(<objeto>): Retorna o tipo de dado contido no objeto em quest�o:
class(verdade)
class(nova_variavel)
class(meu_texto)

## str(<objeto>): Apresenta a estrutura do objeto em quest�o:
str(verdade)
str(y)
str(meu_texto)

## Ajuda do R a respeito de um determinado comando: ?<comando>
?ls
?str
?log
#Observar que na guia "Help" do RStudio apareceu a ajuda para entender o comando




#####################
# 5 - Vetores      #
#####################
# --> Os vetores s�o basicamente uma lista de valores ordenados;
#
### Criando vetores:
ganhos_poker <- c(140, -50, 20, -120, 240)
ganhos_roleta <- c(-24, -50, 100, -350, 10)
dias_semana <- c("segunda", "ter�a", "quarta", "quinta", "sexta")
vet_logico1 <- c(TRUE, TRUE, FALSE)
vet_logico2 <- c(TRUE, FALSE, FALSE)

### Podemos dar nomes a cada uma das observa��es de um vetor:
names(ganhos_poker) <- dias_semana
names(ganhos_roleta) <- dias_semana

### Obter a soma de todos os valores de um vetor:
sum(ganhos_poker)
sum(ganhos_roleta)

### Somar os lucros de cada dia nos dois vetores:
lucros_semana <- ganhos_poker + ganhos_roleta

### apresentar os dias que tivemos lucros
lucros_semana[lucros_semana>0]

### Dias da semana que ganhamos em ambos os jogos:
(ganhos_poker>0) & (ganhos_roleta>0)
## Alternativamente:
lucroPoker <- ganhos_poker>0
lucroRoleta <- ganhos_roleta>0
lucroPoker & lucroRoleta
#
ganhos_poker[lucroPoker]
ganhos_roleta[lucroRoleta]

## Contabilizar os lucros em R$ e EUR$:
real <- 3.25
euro <- 0.9
# Converter o valor de US$ para R$, simplesmente multiplicar o valor dos lucros pela cota��o
lucrosReais <- lucros_semana * real
lucrosEuros <- lucros_semana * euro
# O mesmo vale para qualquer outra opera��o matem�tica:
exp(lucros_semana)
lucros_semana ^ 2
# -->Somente tomar cuidado com log(), que nao aceita numeros negativos
log(lucros_semana)

### Para nos referirmos a um determinado elemento de um vetor, podemos lograr isso de duas maneiras:
# Maneira 1: Simplesmente nos referindo ao �ndice do elemento no vetor:
lucrosReais[1]
lucrosEuros[4]
lucros_semana[c(2, 3, 4)]

# Maneira 2: Caso os elementos possuam nomes, escrevendo os seus nomes:
lucrosReais["segunda"]
lucrosEuros["quinta"]
lucros_semana[c("ter�a", "quarta", "quinta")]


### C�digo extra apresentado na aula em 24/08/2016
meu_vetor <- c(1, 2, 3, 4) 

meu_vetor <- c(meu_vetor, 5) # Adicionar o valor 5 ai final de 'meu_vetor'
meu_vetor <- c(10, meu_vetor) # Adicionar o valor 10
meu_vetor <- c(meu_vetor[1:3], 100, meu_vetor[3:6]) #Adicionar o valor de 100 no meio do vetor

meu_vetor[3] # Ver apenas o elemento 3 de meu_vetor
meu_vetor[2:4] # Vero os elementos 2, 3 e 4 de meu_vetor

# Adicionar o valor 5000 na posi��o 5 de meu_vetor
meu_vetor <- append(meu_vetor, 5000, after=4)
meu_vetor

# Adicionar os valores 5001 e 5002 ap�s o valor de 5000 em meu_vetor
# Sabemos que o valor de 5000 est� na posi��o 5 de meu_vetor:
meu_vetor <- append(meu_vetor, c(5000, 5001), after=5)
meu_vetor


###########################################
# 6 - Gerar N�meros aleat�rios            #
###########################################
# --> Gerar 5 numeros aleatorios entre 0 e 1:
runif(5)

# --> Gerar 10 numeros aleatorios entre 1 e 10:
runif(10, min=1, max=10)

# --> Fazer com que os numeros aleatorios gerados sejam sempre inteiros:
floor(runif(10, min=1, max=11))
ceiling(runif(10, min=0, max=10))
as.integer(runif(10, min=1, max=11))

# --> For�ar o R a gerar os mesmos n�meros aleat�rios
# O R permite que definamos um "seed value". Assim, toda vez que excutarmos 
#   um dos camandos acima, os n�meros aleat�rios gerados ser�o sempre os mesmos:
set.seed(123) # Definir o "seed value"
# Pegar 10 numeros aleatorios, inteiros, entre 1 e 10:
ceiling(runif(10, min=0, max=10))

# Pegar 10 n�meros de uma distribui��o normal padr�o (m�dia = 0 e DP = 1)
rnorm(10, mean=0, sd=1)