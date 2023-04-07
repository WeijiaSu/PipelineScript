#!/bin/bash

## Modify this job script accordingly and submit with the command:
##    sbatch HPC.sbatch
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=8 
#SBATCH --cpus-per-task=4
#SBATCH --job-name='AA_suite'
#SBATCH --partition="all"
#SBATCH --mem=100000
#SBATCH --mail-user=weijia.su@duke.edu   # email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --output="AA_suite-%j.out"
#SBATCH --error="AA_suite-%j.err"
## LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

AASuite="/data/zhanglab/Weijia_Su/software/AmpliconSuite-pipeline/"
ReadDir="/data/zhanglab/Weijia_Su/illumina_Raw_Data/Shun_011923/01.RawData/Circle_1/"

$AASuite"PrepareAA.py" -s Circle_1 -t 32 --cnvkit_dir /data/zhanglab/Weijia_Su/anaconda3/bin/cnvkit.py --bam /data/zhanglab/Weijia_Su/eccDNA/Shun_011923/hg38.fa_Circle_1.bam --ref hg38 --run_AA --run_AC  
