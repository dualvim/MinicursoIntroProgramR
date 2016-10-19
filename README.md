# **Minicurso de Introdução à Programação em R**

## Repositório com os códigos e arquivos usados nas aulas do minicurso "Introdução ao Software R", ministrado por Eduardo Alvim na FACIC-UFU  
  
 - **Aula 1 (24/08/2016) - Conteúdo Geral**  
	- Operações Matemáticas no R  
	- Operações Lógicas no R  
	- Atribuições de variáveis e operações usando variáveis  
	- Interlúdio - "R Workspace" e comandos ls(), class() e str()
	- Vetores  
	- Geração de números aleatórios  
  
 - **Aula 2 (14/09/2016) - Revisão detalhada do conteúdo apresentado na 1a Aula**  
	- Revisão de tipos de variáveis  
	- Revisão de vetores  
	- Operações com vetores  
  
 - **Aula 2 (pendências) - 21/09/2016 - Continuação do assunto abordado na aula 2**  
	- Revisão rápida de vetores e operações com vetores  
	- Geração de números aleatórios e amostragem aleatória  
	- Estatísticas descritivas básicas utilizando os dados dos vetores  
	- Exemplo de revisão do conteudo apresentado até o momento
	- Apresentação rápida de alguns recursos interessantes do R.
		- Histograma  
		- Gráfico de dispersão  
		- Funções definidas pelo usuário  
  
 - **Aula 3 - 28/09/2016 - Importação de dados e Revisão de Métodos Quantitativos 1**  
	- Comandos de diretório de trabalho - getwd() e setwd()  
	- Importação de um conjunto de dados salvo no computador  
	- Estatísticas descritivas de dados qualitativos  
	- Gráficos de variáveis qualitativas  
	- Estatísticas descritivas de dados quantitativos  
	- Funções sapply() e tapply()  
	- Gráficos de dados quantitativos  
  
 - **Aula 4 - 05/10/2016 - Explorando mais um pouco os recursos do R**  
	- Importar um conjunto de dados a partir de um link  
	- Mais um pouco de operações em conjunto de dados  
	- Mais exemplos usando o comando sapply()  
	- Operações com datas  
	- Funções definidas pelo usuário  
	- Declarações if/else  
	- Operações com valores do tipo "character" (String)  
	- Um pouco de gráficos  
  
 - **Aula 5 - 19/10/2016 - Baixar dados de ações, Reestruturação de conjuntos de dados, gráficos do pacote 'base' do R e gráficos do pacote 'gplot2'**  
	- Baixar dados de ações com a biblioteca 'FinCal'  
	- Gráficos da biblioteca 'FinCal'  
	- Cálculo dos retornos das ações  
	- Criação de um novo conjunto de dados a partir de vetores do R  
	- Aprofundamento nos gráficos do pacote 'base'' do R  
	- Reestruturação de um conjunto de dados usando o comando melt() da biblioteca 'reshape2'  
	- Gráficos usando a biblioteca 'ggplot2'  
  
 - **Códigos Extras**  
	- Extra_IntervalosDeConfianca.r  
		- Calcular a estatística t a partir de uma probabilidade - qt()  
		- Calcular intervalos de confiança  
		- Usar o comando tapply()
		- Usar o comando tapply() para calcular o intervalo de confiança para vários grupos.  
	- **Extra_GraficosLattice.r**  
		- Baixar um arquivo da internet – download.file()  
		- Estatisticas descritivas – summary(), sapply()  
		- Formatar uma data para encontrar o ano  
		- Gráficos da biblioteca ‘lattice’ do R  
			- Comando xy.plot()  
			- Comando dotplot()  
			- Comando histogram()  
			- Comando bwplot()  
	- **Extra_MatFin.r**  
		- Baixar um arquivo da internet – download.file()  
		- Estatisticas descritivas – summary(), sapply()  
		- Extrair um subconjunto de dados de um conjunto de dados  
		- Correlação de Pearson, Spearman e Kendall – cor()  
		- Cálculo de dias úteis  
		- Matemática financeira usando o pacote FinCal  
			- Valor Presente – pv() e pv.simple()  
			- Valor Futuro – fv() e fv.simple()  
			- Rentabilidade bruta – hpr()
			- Calculo de taxa de desconto – discount.rate()  
		- Mais funções definidas pelo usuário  
			- Função retAliqIR() – Utiliza declarações if/else para retornar a alíquota de um investimento  
			- Função retVlrLiqResg() – Função que chama retAliqIR() e calcula o valor a ser resgatado  
			- Função retTaxaRetornoLiq() – Calcula a taxa de retorno líquida de um investimento  
		- Um pouco de regressão  
		- Utilização de gráficos do pacote ‘base’ do R  
		- Gráfico de resíduos da regressão  
	- **Extra_MatFin2.r**  
		- Calcular taxa efetiva ao ano – ear()  
		- Calcular o valor futuro – fv()  
		- Calcular a taxa de desconto – discout.rate()  
		- Calcular o valor dos pagamentos de uma série – pmt()  
		- Calcular o valor presente líquido – npv()  
		- Calcular o valor presente de uma série irregular de pagamentos – pv.uneven()  
		- Calcular a taxa interna de retorno (TIR) – irr() e irr2()  
		- Cronometrar a execução de um processo no R – system.time({})  
