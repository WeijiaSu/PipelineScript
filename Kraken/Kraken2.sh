#!/bin/bash


export PATH=/data/zhanglab/Weijia_Su/software/samtools-1.12/bin:$PATH

name=$1
reads=$name".upmapped.fastq"

kraken2 --use-names --threads 4 --db /data/zhanglab/Weijia_Su/Kraken2/kraken2-standard-db --report $name".report.txt" $reads  > $name".kraken"

ktImportTaxonomy $name".report.txt" -o $name".krona.html"

bracken -d /data/zhanglab/Weijia_Su/Kraken2/kraken2-standard-db/ -i $name".report.txt" -o $name".report.txt" -l S -r 200


