####################
# Extra_MatFin2.r  #
####################


# Chamar a biblioteca FinCal
library(FinCal)


# Dados do inicio do exemplo da página 27 do livro (pg 19 do pdf)
# --> Taxa Nominal a.a.: 6%, capitalizada trimestralmente 
# --> Número de depósitos (períodos): 19
# --> Valor de cada depósito: -1000
taxaNom_aa <- 0.06
numPer <- 19
vlrDeposito <- -1000

# Calcular a taxa efetiva ao ano - Função ear() da biblioteca FinCal:
taxaEfet_aa <- ear(r=0.06, m=4)
taxaEfet_aa #[1] 0.06136355
#
# Maneira alternativa: 
#((1+(taxaNom_aa/4))^4)-1 #[1] 0.06136355

# Valor futuro após os 19 depósitos anuais
# Função fv() da biblioteca FinCal
vfDepositos <- fv(r=taxaEfet_aa, n=numPer, pv=0, pmt=vlrDeposito)
vfDepositos #[1] 34228.96

# Maneira alternativa de se calcular o valor futuro sem usar a função fv()
# vlr <- 1000
# for(i in 1:(numPer-1)){
#       vlr0 <- vlr*(1+taxaEfet_aa)
#       vlr <- vlr0 + 1000
# }
# vlr #[1] 34228.96

# Testar a função discout.rate() de FinCal.
# --> O resultado deverá ser bem próximo do valor de 'taxaEfet_aa'
discount.rate(n=numPer, pv=0, fv=vfDepositos, pmt=vlrDeposito, type = 0) #[1] 0.0613596
taxaEfet_aa #[1] 0.06136355 --> Não foi igual, mas foi bem próximo


# Com o valor de vfDepositos como valor presente, se quisermos resgatar esse valor em
#     5 parcelas, quanto vamos receber em cada uma?
# Função pmt() da biblioteca FinCal
#     # type=0: Pagamento no fim de cada período (pagamentos postercipados)
#     # type=1: Pagamento no início de cada período (pagamentos antecipados)
pmt(r=taxaEfet_aa, n=5, pv=-vfDepositos, fv=0, type = 1) #[1] 7684.452



# Dados do inicio do exemplo da página 53 do livro (pg 32 do pdf) de Engenharia Econômica:
juros <- 0.12
fluxos_A <- c(-1000, 800, 800)
fluxos_B <- c(-1200, 650, 650, 650)
fluxos_C <- c(-1200, -1000, 700, 700, 700, 700, 700)


# --> Testar a função npv() da biblioteca "FinCal"
npv(r=juros, cf=fluxos_A) #[1] 352.0408
npv(r=juros, cf=fluxos_B) #[1] 361.1903
npv(r=juros, cf=fluxos_C) #[1] 160.128


# --> Testar a função pv.uneven() da biblioteca "FinCal"
pv.uneven(r=juros, cf=fluxos_A[2:length(fluxos_A)]) #[1] -1352.041
pv.uneven(r=juros, cf=fluxos_B[2:length(fluxos_B)]) #[1] -1561.19
pv.uneven(r=juros, cf=fluxos_C[2:length(fluxos_C)]) #[1] -1360.128


# --> Testar a função irr() da biblioteca "FinCal"
irr(fluxos_A) #[1] 0.3797938
irr(fluxos_B) #[1] 0.288401
irr(fluxos_C) #[1] 0.1450857


# --> Verificar o tempo de execução da função irr() em cada caso acima:
system.time({
      irr(fluxos_A)
      irr(fluxos_B)
      irr(fluxos_C)
})
#Output:
# usuário   sistema decorrido 
# 0         0         0 


# --> Testar a função irr2() da biblioteca "FinCal"
# Obs: essa função realiza a mesma coisa que a função irr(), no
#     entanto permite calcular valores negativos para a TIR.
# --> Usar com moderação, uma vez que a execução dessa função é demorada
irr2(fluxos_A) #[1] 0.379699
irr2(fluxos_B) #[1] 0.288339
irr2(fluxos_C) #[1] 0.145065


# --> Verificar o tempo de execução da função irr2() em cada caso acima:
system.time({
      irr2(fluxos_A)
      irr2(fluxos_B)
      irr2(fluxos_C)
})
#Output: 
# usuário   sistema decorrido 
# 32.88      0.25     33.38
#
# --> Perceber a diferença brutal no tempo de execução da função irr2()
#     quando comparado com o da função irr()
