#!/bin/bash



genome="/data/zhanglab/Weijia_Su/Genomes/Human/hg38.fa"
dir=$1
data=$2

refName=$(basename $genome)
echo "`date +"%m-%d-%Y %H:%M:%S"` Mapping to" $refName $data;

bwa mem -t 16 $genome $dir$data"_R1_001.fastq.gz" $dir$data"_R1_001.fastq.gz" | samtools view -bS | samtools sort -@ 28 -T $refName"_"$data > $refName"_"$data".bam" 
echo "`date +"%m-%d-%Y %H:%M:%S"` Indexing";
samtools index $refName"_"$data".bam";
echo "`date +"%m-%d-%Y %H:%M:%S"` Stats";
samtools stats $refName"_"$data".bam" | head -n 30 > $refName"_"$data".bam.stats"
echo "`date +"%m-%d-%Y %H:%M:%S"` Coverage";
bamCoverage -b $refName"_"$data".bam" -o $refName"_"$data".bam.bw" --normalizeUsing CPM;

