#!/bin/bash

## Modify this job script accordingly and submit with the command:
##    sbatch HPC.sbatch
#SBATCH --nodes=1   # number of nodes
#BATCH --ntasks-per-node=2   # 16 processor core(s) per node
#SBATCH --cpus-per-task=2
#SBATCH --job-name='kracken'
#SBATCH --partition="all"
#SBATCH --mem=100000
#SBATCH --mail-user=weijia.su@duke.edu   # email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --output="%A.out"
#SBATCH --error="%A.err"
## LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE


export PATH=/data/zhanglab/Weijia_Su/software/samtools-1.12/bin:$PATH

cat *upmapped.fastq > all.fastq

kraken2 --use-names --threads 4 --db /data/zhanglab/Weijia_Su/Kraken2/kraken2-standard-db --report "all.report.txt" all.fastq  > "all.kraken"

ktImportTaxonomy "all.report.txt" -o "all.krona.html"

bracken -d /data/zhanglab/Weijia_Su/Kraken2/kraken2-standard-db/ -i "all.report.txt" -o "all.bracken.report.txt" -l S -r 200

rm all.fastq

