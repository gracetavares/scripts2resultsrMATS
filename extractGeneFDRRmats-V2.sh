#!/bin/bash

# Diretório contendo os arquivos de saída do rMATS
INPUT_DIR="$1"
OUTPUT_DIR="$2"
DIFF_THRESHOLD="$3"

# Verificar se todos os argumentos foram passados
if [ "$#" -ne 3 ]; then
    echo "Uso: $0 <input_dir> <output_dir> <diff_threshold>"
    echo "Exemplo: $0 ./resultados ./filtrados 0.8"
    exit 1
fi

# Verificando o diretório de entrada
if [ -d "INPUT_DIR" ]; then
  echo "Lendo os arquivos em $INPUT_DIR."
  continue
else
    echo "Diretório de entrada não encontrado: $INPUT_DIR"
fi

# Verificando o diretório de saída
if [ -d "OUTPUT_DIR" ]; then
  echo "Os resultados serão salvos em $OUTPUT_DIR."
  continue
else
    mkdir -p "$OUTPUT_DIR"
    echo "Diretório de saída criado: $OUTPUT_DIR"
fi


# Processar todos os arquivos .txt na pasta
for INPUT_FILE in "$INPUT_DIR"/*.txt; do
    OUTPUT_FILE="$OUTPUT_DIR/$(basename "$INPUT_FILE" .txt)_filtered.txt"
    
    # Filtrar pelo FDR < 0.05 e valores altos de IncLevelDifference (próximos de 1 ou -1)
    #awk -F "\t" 'NR==1 || ($19 < 0.05 && ($21 >= 0.8 || $21 <= -0.8))' "$INPUT_FILE" > "$OUTPUT_FILE"
    awk -F "\t" threshold="$DIFF_THRESHOLD" 'NR==1 || ($19 < 0.05 && ($21 >= threshold || $21 <= -threshold))' "$INPUT_FILE" > "$OUTPUT_FILE"
    # Pega índices das colunas FDR e IncLevelDifference no cabeçalho
        #FDR_COL=$(head -1 "$INPUT_FILE" | tr '\t' '\n' | grep -n "^FDR$" | cut -d: -f1)
        #DIFF_COL=$(head -1 "$INPUT_FILE" | tr '\t' '\n' | grep -n "^IncLevelDifference$" | cut -d: -f1)
        echo $DIFF_COL
        # Filtrar os dados com base no FDR e no limiar de diferença
            #awk -v fdr_cut="$FDR_CUTOFF" -v diff_cut="$DIFF_CUTOFF" -v fdr_col="$FDR_COL" -v diff_col="$DIFF_COL" \
            #'BEGIN {OFS="\t"} NR==1 || ($fdr_col <= fdr_cut && ($diff_col >= diff_cut || $diff_col <= -diff_cut))' \
            #"$INPUT_FILE" > "$OUTPUT_FILE"
    echo "Arquivo filtrado: $OUTPUT_FILE"
done

echo "Processamento concluído. Arquivos filtrados estão em $OUTPUT_DIR"
