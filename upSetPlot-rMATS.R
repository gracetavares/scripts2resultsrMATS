# Instalar as bibliotecas necessárias (lista de bibliotecas do CRAN)
pacotes = c ("BiocManager", "dplyr", "readr", "here", "tibble", "UpSetR" )
instalar = pacotes[!(pacotes %in% installed.packages()[,"Package"])]
if (any(!(pacotes %in% installed.packages()[,"Package"]))) {
  install.packages(instalar)
}

#Carregar as bibibliotecas
library(dplyr)
library(tidyr)
library(readr)
library(UpSetR)
library(tibble)
library(here)

#Diretório de trabalho
setwd("~/diretorio-trabalho")

# Criar a pasta "resultados" se não existir
setwd ("~/diretorio-trabalho/data")

# Carregar lista de genes (coluna única)
rmatsTableRI = read_tsv('RI.MATS.JC.txt') %>%
  mutate(Event = "RI")
rmatsTableA3SS = read_tsv('A3SS.MATS.JC.txt') %>%
  mutate(Event = "A3SS")
rmatsTableA5SS = read_tsv('A5SS.MATS.JC.txt') %>%
  mutate(Event = "A5SS")
rmatsTableMXE = read_tsv('MXE.MATS.JC.txt') %>%
  mutate(Event = "MXE")
rmatsTableSE = read_tsv('SE.MATS.JC.txt') %>%
  mutate(Event = "SE")


# Juntar as duas tabelas
rmatsTableGORI = rmatsTableRI %>%
  dplyr::select(GeneID,Event, FDR, IncLevelDifference) # acrescenta entrezID

rmatsTableGOA3SS = rmatsTableA3SS %>%
  dplyr::select(GeneID, Event, FDR, IncLevelDifference) 

rmatsTableGOA5SS = rmatsTableA5SS %>%
  dplyr::select(GeneID, Event, FDR, IncLevelDifference)

rmatsTableGOMXE = rmatsTableMXE %>%
  dplyr::select(GeneID, Event, FDR, IncLevelDifference) %>%
  mutate(across(c(FDR, IncLevelDifference), as.numeric))  

rmatsTableGOSE = rmatsTableSE %>%
  dplyr::select(GeneID, Event, FDR, IncLevelDifference) %>%
  mutate(across(c(FDR, IncLevelDifference), as.numeric))


rmatsTableAll = bind_rows(rmatsTableGORI, rmatsTableGOA3SS,
                          rmatsTableGOA5SS, rmatsTableGOMXE, 
                          rmatsTableGOSE)

# filtrar eventos significativos
EventosSignif = rmatsTableAll %>%
  filter(FDR <= 0.05, abs(IncLevelDifference) >= 0.1)

eventList = split(EventosSignif$GeneID, EventosSignif$Event)

upset(fromList(eventList),
      nsets = length(eventList),
      nintersects = 20,
      order.by = "freq",
      text.scale = 1.5,
      point.size = 3,
      matrix.dot.alpha = 2,
      sets.bar.color = "#339194",
      main.bar.color = "#a70267")
