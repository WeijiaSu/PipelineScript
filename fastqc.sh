#!/bin/bash

## Modify this job script accordingly and submit with the command:
##    sbatch HPC.sbatch
#SBATCH --nodes=8   # number of nodes
#SBATCH --ntasks-per-node=4   # 16 processor core(s) per node
#SBATCH --cpus-per-task=7
#SBATCH --job-name='fastqc'
#SBATCH --partition="all"
#SBATCH --mem=100000
#SBATCH --mail-user=weijia.su@duke.edu   # email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --array=1-36
#SBATCH --output="fastqc_%A_%a.out"
#SBATCH --error="fastqc_%A_%a.err"
## LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

module load samtools

dir="/data/zhanglab/Weijia_Su/illumina_Raw_Data/Mustafa_021423/"


#Get the sample name file list

#ls $dir"*_R1_001.fastq.gz" | sed 's/_R1_001.fastq.gz//' > $dir"sampleNames.txt"

#This command uses ls to list all the _R1.fastq.gz files in the /path/to/reads directory, and then uses sed to remove the _R1.fastq.gz suffix from the file names and write the resulting names to a file called input_files.txt. Note that this assumes that all your sample files follow the naming convention of having _R1.fastq.gz and _R2.fastq.gz suffixes.

# Define the input file list
input_list=$dir"sampleNames.txt"

# Get the input file name for the current array task ID
input_file=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $input_list)

# Run FastQC on the input files
fastqc --threads 28 $dir${input_file}_R1_001.fastq.gz $dir${input_file}_R2_001.fastq.gz

