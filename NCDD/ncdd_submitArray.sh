#!/bin/bash

## Modify this job script accordingly and submit with the command:
##    sbatch HPC.sbatch
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=4   # 16 processor core(s) per node
#SBATCH --job-name='ncdd'
#SBATCH --partition="all"
#SBATCH --mem=100000
#SBATCH --mail-user=weijia.su@duke.edu   # email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --array=1-3
#SBATCH --output=test_%A_%a.out
#SBATCH --error=test_%A_%a.err
## LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE



conda activate base

dir="/data/zhanglab/Weijia_Su/Nanopore_Raw_Data/20230328_PC9_Osimertinib_resis_Rapid_genome_seq/"
hg38="/data/zhanglab/Weijia_Su/Genomes/Human/hg38.fa"

files=$dir*.fastq
arrayfile=`ls $files | awk -v line=$SLURM_ARRAY_TASK_ID '{if (NR == line) print $0}'`
bash ncdd.sh $arrayfile;
