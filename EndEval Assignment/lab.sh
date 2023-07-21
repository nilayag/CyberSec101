#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "syntax: $0 <input_file> <output_file>"
    exit 1
fi

input_file="$1"
output_file="$2"

if [ ! -f "$input_file" ]; then
    echo "error: input file '$input_file' does not exist"
    exit 1
fi

awk -F, 'BEGIN{OFS=" "} {print $1, $2, $3, $5, $6, $7, $10, $11}' "$input_file" > "$output_file"

awk -F, '{if ($3 == "Bachelor'\''s") print $1}' "$input_file" >> "$output_file"

awk -F, 'BEGIN{OFS=": "} NR>1{sum[$6]+=$7; count[$6]++} END{print "Geography: Average Admission Rate"; for (area in sum) print area, sum[area]/count[area]}' "$input_file" >> "$output_file"

awk -F, 'NR>1{print $1, $16}' "$input_file" | sort -k2 -nr | head -n 5 | awk '{print $1, $2}' >> "$output_file"