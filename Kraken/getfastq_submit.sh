#!/bin/bash

## Modify this job script accordingly and submit with the command:
##    sbatch HPC.sbatch
#SBATCH --nodes=1   # number of nodes
#BATCH --ntasks-per-node=2   # 16 processor core(s) per node
#SBATCH --cpus-per-task=16
#SBATCH --job-name='fastq'
#SBATCH --partition="all"
#SBATCH --mem=100000
#SBATCH --mail-user=weijia.su@duke.edu   # email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --array=1-36
#SBATCH --output="fastq_%A_%a.out"
#SBATCH --error="fastq_%A_%a.err"
## LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

module load samtools
source ~/.bashrc

dir="/data/zhanglab/Weijia_Su/illumina_Raw_Data/Mustafa_022023/"

input_list=$dir"sampleNames.txt"
input_file=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $input_list)

bash getfastq.sh $input_file

