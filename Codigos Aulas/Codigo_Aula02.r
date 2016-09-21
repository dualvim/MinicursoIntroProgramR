#####################################
# Minicurso R - Aula 2 - 14/09/2016 #
#####################################
# Conteudo de fato apresentado na aulda de 14/09/2016
# 1 - Revisão de tipos de Variaveis 
# 2 - Revisão de vetores
# 3 - Operações com vetores
# --> Como não consegui terminar de explicar tudo que eu queria nessa aula,
#	esse arquivo contém apenas os códigos apresentados na aula.



#######################################
# Parte 01 - Tipos de Variaveis       #
#######################################
# '<-' Operador de atribuição do R. 
#     Também podemos utilizar o operador '=' no lugar do operador '<-'
# class(<objeto>): Retorna o tipo de valor armazenado em <objeto>
# object.size(<objeto>): Retorna o espaço ocupado na memório por <objeto>
#
# Valores do tipo 'numeric'
const_pi <- 3.14
class(const_pi) # [1] "numeric"
object.size(const_pi) # 48 bytes
#
# O R também considera como números os valores NaN (Not a Number) e Inf (infinito)
div_zero <-0/0
div_zero #[1] NaN --> Not a Number
100/NaN #[1] NaN
#
div_inf <- 100/0
div_inf #[1] Inf
div_inf * 10000 # [1] Inf
10000/-Inf #[1] 0
#
#
# Valores do tipo 'integer'
# O sufixo 'L' após o número força o R transformar o número em inteiro (integer) 
num_int <- 100L
class(num_int) # [1] "integer"
object.size(num_int) # 48 bytes
#
# Transformar a variavel 'const_pi' em numero inteiro
as.integer(const_pi) #[1] 3
#
#
# Valores do tipo 'logical'
# --> São valores lógicos e assumem os valores TRUE (1) ou FALSE (0)
# --> Para o R reconhecer esses valores como valores lógicos devemos escrever 
#     o nome do valor em maiúsculo, ou apenas a inicial em maiúsculo (T ou F).
verdade <- TRUE
mentira <- as.logical(FALSE)
# Alternativamente:
verdade <- T
mentira <- as.logical(F)
class(verdade) # [1] "logical"
class(mentira) # [1] "logical"
object.size(verdade) # 48 bytes
object.size(mentira) # 48 bytes
#
# Valores Ausentes (NA):
# O R possui o valor do tipo "logical" NA que indica a ausencia de valor
# Todas as operações usando o valor NA irão retornar NA
val_ausente <- NA
val_ausente # [1] NA
val_ausente + 1 # [1] NA

# Valores do tipo 'character'
texto1 <- "ola"
texto2 <- as.character("mundo")
class(texto1) # [1] "character"
class(texto2) # [1] "character"
object.size(texto1) # 96 bytes
object.size(texto2) # 96 bytes
#
# Comandos usados para concatenar valores do tipo 'character' 
# Comando paste0(): Concatena os valores do tipo 'character', inseridos como argumento
paste0(texto1,texto2) #[1] "olamundo"
paste0(texto1,"-->",texto2) #[1] "ola-->mundo"
#
# Comando paste(): Concatena os valores do tipo 'character', mas os separa pelo caractere especificado em sep.
#     --> Por padrão, o argumento sep será " " (espaço)
paste(texto1, texto2) # [1] "ola mundo"
paste(texto1, texto2, sep=" ") # [1] "ola mundo"
paste(texto1, "meu grande", texto2, sep=" --> ") #[1] "ola --> meu grande --> mundo"
#
# Vero os objetos presentes na área de trabalho atual do R:
ls()
# [1] "const_pi" "mentira"  "num_int"  "texto1"   "texto2"   "verdade" "div_inf" "div_zero" "val_ausente"
# --> Observe esses objetos acima na guia "Enviroment", na parte superior a direita
#
# Retirar (apagar) as variáveis, criadas acima, da memória:
rm(const_pi, num_int, verdade, mentira, texto1, texto2, div_inf, div_zero,val_ausente)
# --> Observe que agora a guia "Enviroment", na parte superior a direita, não possui mais nada
#





#######################################
# Parte 02 - Revisão de vetores       #
#######################################
# O comando c() pé o comando usado para combinar os itens em um vetor
#
# Vetor do tipo 'numeric'
vetor_numeric <- c(0.5, 55, -10, 6)
vetor_numeric <- as.numeric(c(0.5, 55, -10, 6))
class(vetor_numeric) #[1] "numeric"
object.size(vetor_numeric) #72 bytes
#
# Vetor do tipo 'integer'
vetor_integer <- c(12, 13, 14, 15)
class(vetor_integer) # [1] "numeric"
object.size(vetor_integer) # 72 bytes
# --> Por padrão, o R considera que os números inseridos são números reais, do tipo "numeric"
# Para forçar que os valores do vetor sejam inteiros podemos adotar um dos procedimentos a seguir:
vetor_integer <- as.integer(c(12, 13, 14, 15))
class(vetor_integer) # [1] "integer"
object.size(vetor_integer) # 56 bytes
# Maneira alternativa: <inicio>:<fim> gera uma sequencia de numeros inteiros entre <inicio> e <fim>
vetor_integer <- 12:15
class(vetor_integer) # [1] "integer"
object.size(vetor_integer) # 56 bytes
# --> Observe que um vetor com valores do tipo "integer" ocupa menos espaço na 
#     memória do que um vetor do tipo "numeric"
#
#
#
# Vetor do tipo logical
vetor_logical <- c(TRUE, T, FALSE, F)
vetor_logical <-as.logical(c(TRUE, T, FALSE, F))
class(vetor_logical) # [1] "logical"
object.size(vetor_logical) # 56 bytes
#
# Vetor do tipo 'character'
vetor_character <- c("Ola", "meu", "nome", "eh")
vetor_character <- as.character(c("Ola", "meu", "nome", "eh"))
class(vetor_character) # [1] "character"
object.size(vetor_character) # 264 bytes
#
#
# comando length(): Retorna o número de elementos dentro do vetor:
length(vetor_numeric) # [1] 4
length(vetor_character) # [1] 4
length(vetor_logical) # [1] 4
#
#
# Criar um vetor com uma sequencia de numeros de 1 a 10, em intervalos de 0.5
vetor_numeric2 <-seq(from=1, to=10, by=0.5)
#
# Criar um vetor com o mesmo número de valores contidos em vetor_numeric2, mas todos iguais a 0:
vetor_numeric3 <- rep(0, times=length(vetor_numeric2))
# 
# Para acessar determinado(s) elemento(s) de um vetor, podemos nos referir ao seu índice
vetor_logical[1] # [1] TRUE
vetor_character[2] # [1] "meu"
vetor_numeric2[10:12] # [1] 5.5 6.0 6.5
vetor_numeric3[13:15] # [1] 0 0 0



#####################################
# Parte 3: Operacoes com vetores:   #
#####################################
#
# Operação de um escalar por um vetor
# --> Podemos realizar operações de um escalar por todos os elementos de um vetor
vetor_integer + 1 # [1] 13 14 15 16
vetor_numeric * 2 # [1]   1 110 -20  12
#
# Operações entre dois vetores
# --> Para isso, os dois vetores deverão ter o mesmo tamanho e tipos de variáveis compatíveis entre si
vetor_integer * vetor_numeric #[1]    6  715 -140   90
vetor_integer * vetor_logical #[1] 12 13  0  0 #Transforma TRUE em 1 e FALSE em 0
vetor_integer * vetor_character # Não pode! --> Retorna um Erro
#
# Não podemos realizar operações com vetores de tamanhos diferentes:
vetor_numeric + vetor_numeric2 # Erro!
vetor_numeric * vetor_numeric2 # Erro!
#


# Operações lógicas com vetores
# --> Podemos utilizar os operadores lógicos para retornar valores do vetor que atendam as condições
vetor_numeric < 1 #[1]  TRUE FALSE  TRUE FALSE
vetor_numeric[vetor_numeric < 1] #[1]   0.5 -10.0
#
# Armazenar o resultado de uma operação lógica em uma variável:
# Criar um vetor lógico que indique quais valores do vetor 'vetor_numeric2' terminam em 0.5:
vals_meio <- (vetor_numeric2 %% as.integer(vetor_numeric2)) == 0.5
vals_meio #[1] FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE TRUE FALSE
# Valores de "vetor_numeric2" que terminam em 0.5:
vetor_numeric2[vals_meio] #[1] 1.5 2.5 3.5 4.5 5.5 6.5 7.5 8.5 9.5
#
# Retirar do vetor 'vetor_numeric2' todos os valores não inteiros
vetor_numeric2 <- vetor_numeric2[!vals_meio]
vetor_numeric2 #[1]  1  2  3  4  5  6  7  8  9 10



# Concatenação de vetores:
#
# Adicionar o meu nome no final do vetor "vetor_character"
vetor_character <- c(vetor_character, "Eduardo")
vetor_character #[1] "Ola"     "meu"     "nome"    "eh"      "Eduardo"
# Modificar "vetor_character" colocando "Boa Noite!" no 1o elemento, segudo pelos outros elementos
vetor_character <- c("Boa Noite!", vetor_character[2:length(vetor_character)])
vetor_character
# Obs: Como modificamos apenas 1 elemento do vetor, poderiamos ter feito somente isso:
#vetor_character[1] <- "Boa Noite!" # O Resultado seria exatamente o mesmo
#
#
#
vetor_character <- c("Ola", "meu", "nome", "eh")
vetor_character2 <- c("Ola", "meu", "nome", "eh")
vetor_character2[length(vetor_character2)+1] <- "Eduardo"
vetor_character2 # [1] "Ola"     "meu"     "nome"    "eh"      "Eduardo"
#
# Comandos paste0() e paste() em vetores:
#
# Para concatenar os valores de um vetor em uma só string, devemos utilizar o argumento collapse
#     dos comandos paste() e paste0(), esse argumento indica a string que ira separar os 
#     elementos do vetor
paste0(vetor_character2, collapse=" ") # [1] "Ola meu nome eh Eduardo"
frase <- paste(vetor_character2, collapse=" ")
frase # [1] "Ola meu nome eh Eduardo"
length(frase) #[1] 1
#
# Também podemos usar os comandos paste() e paste0() para concatenar os valores de dois vetores
# --> Independente do tipo de valor desses vetores, os valores serão convertidos para 'character'
paste(vetor_numeric, vetor_integer, sep="-") #[1] "0.5-12" "55-13"  "-10-14" "6-15"  
paste(vetor_integer, vetor_character, sep=" ") #[1] "12 Ola"  "13 meu"  "14 nome" "15 eh" 
paste0(vetor_integer, vetor_character) #[1] "12Ola"  "13meu"  "14nome" "15eh"
paste0(vetor_logical, vetor_character) #[1] "TRUEOla"   "TRUEmeu"   "FALSEnome" "FALSEeh" 
paste(vetor_logical, vetor_character, sep=" ") #[1] "TRUE Ola"   "TRUE meu"   "FALSE nome" "FALSE eh"

# No caso do uso dos comandos paste() e paste0() em dois vetores, podemos concatenar vetores de tamanho diferentes
# LETTERS: Vetor com todas as letras do alfabeto em maiúsculo:
paste(LETTERS, 1:4, sep = "-")
# [1] "A-1" "B-2" "C-3" "D-4" "E-1" "F-2" "G-3" "H-4" "I-1" "J-2" "K-3" "L-4" "M-1" "N-2" "O-3" "P-4" "Q-1"
# [18] "R-2" "S-3" "T-4" "U-1" "V-2" "W-3" "X-4" "Y-1" "Z-2"