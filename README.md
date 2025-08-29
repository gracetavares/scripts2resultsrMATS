**README**

Este script tem como objetivo realizar a comparação entre os resultados do rMATS e do arquivo GTF retirandos os transcripts_id em comparação com os *gene_id*.

## Sumário
- [Descrição do projeto](#descricao-do-projeto)
- [Sobre os scripts](#sobre-os-scripts)
    - [upSetPlot-rMATS.R](#upsetplotrmatsr)
        - [Dependências](#-dependências)
    - [extractGeneFDRRmats-V2.sh](#extractgenefdrrmatsv2sh)
    - [mapedrMATS2transcriptID.ipynb](#mapedrmats2transcriptidipynb)
        - [Dependências](#-dependências-2)
- [Status do projeto](#status-do-projeto)
- [Citação](#citacao)

## Descrição do projeto
Este projeto tem como objetivo a manipulação e análise dos resultados do rMATS.

## Sobre os scripts

### upSetPlot-rMATS.R

Este _script_ analisa o resultado do rMATS, calcula as interseções entre os grupos de análise,
no caso, cada evento analisado pelo rMATS e retorna uma gráfico upset.

#### 📦 Dependências
Esse _script_ utiliza a **versão 4.5.1** do R e os seguintes pacotes do R:
-dplyr
-tidyr
-readr
-UpSetR
-tibble
-here

_Para instalar:_
Todos os pacotes estão listados para instalação automática, caso necessário, no início do _script_. Selecione as linhas de instalação e execute-as.

###extractGeneFDRRmats-V2.sh
Este _script_ realiza o filtro dos resultados do rMATS conforme FDR e deltaPSI.

## Status do projeto
![Badge em Desenvolvimento](http://img.shields.io/static/v1?label=STATUS&message=EM%20DESENVOLVIMENTO&color=GREEN&style=for-the-badge)

