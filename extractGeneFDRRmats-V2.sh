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
    awk -F "\t" -v threshold=$DIFF_THRESHOLD 'NR==1 || ($20 < 0.05 && ($23 >= threshold || $23 <= -threshold))' "$INPUT_FILE" > "$OUTPUT_FILE"
    
    echo "Arquivo filtrado: $OUTPUT_FILE"
done

echo "Processamento concluído. Arquivos filtrados estão em $OUTPUT_DIR"
