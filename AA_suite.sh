#!/bin/bash

## Modify this job script accordingly and submit with the command:
##    sbatch HPC.sbatch
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=16   # 16 processor core(s) per node
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
$AASuite"PrepareAA.py" -s Circle_1 -t 16 --cnvkit_dir /path/to/cnvkit.py --fastqs $ReadDir"Circle_1_CKDL230000534-1A_HTLHHDSX5_L1_1.fq.gz" $ReadDir"Circle_1_CKDL230000534-1A_HTLHHDSX5_L1_2.fq.gz" --ref hg38


