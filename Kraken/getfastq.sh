#!/bin/bash

bam_path="/data/zhanglab/Weijia_Su/WGS/GBM_tumor_022023/"

name=$1
samtools view -h -b -f 4 $bam_path$name".cs.rmdup.RG.bam" |samtools fastq > $name".upmapped.fastq";
