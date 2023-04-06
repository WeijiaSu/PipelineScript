#!/bin/bash

bam_path="/data/zhanglab/Weijia_Su/eccDNA/AA/GBM_tumor_022023/"

name=$1
#extract EGFR
#echo "`date +"%m-%d-%Y %H:%M:%S"` extract EGFR ";
#samtools view -h -b $bam_path$name".cs.rmdup.bam" "chr7:55019017-55211628" > $name".EGFR.bam";
#echo "@RG	ID:RG$name	SM:$name	LB:Lib$name	PL:illumina	PU:unit$name	CN:Center1" > $name".readgroups.txt";
#echo "`date +"%m-%d-%Y %H:%M:%S"` process EGFR "
#picard AddOrReplaceReadGroups I=$name".EGFR.bam" O=$name".EGFR.RG.bam" RGID=RG$name RGLB=Lib$name RGPL=illumina RGSM=$name RGPU=unit$name RGCN=Center1 VALIDATION_STRINGENCY=SILENT TMP_DIR=tmp$name;
#samtools index $name".EGFR.RG.bam";
#
##Run gatk
#echo "`date +"%m-%d-%Y %H:%M:%S"` Run gatk on EGFR "
#gatk HaplotypeCaller -R hg38.fa -I $name".EGFR.RG.bam" -O $name".EGFR.vcf";
#echo "`date +"%m-%d-%Y %H:%M:%S"` filter EGFR "
#gatk VariantFiltration -R hg38.fa -V $name".EGFR.vcf" -O $name".EGFR.filter.vcf" --filter-expression "QUAL < 30.0" --filter-name "LowQual" --filter-expression "DP < 10" --filter-name "LowCoverage";
#
echo "`date +"%m-%d-%Y %H:%M:%S"` Annotate EGFR "
/data/zhanglab/Weijia_Su/software/ensembl-vep/vep -i $name".EGFR.filter.vcf" -o $name".EGFR.filter.vcf.vepAnn.txt" --cache --dir_cache /data/zhanglab/Weijia_Su/software/ensembl-vep/cache/ --assembly GRCh38 --everything --force_overwrite --stats_text --fork 32 --allele_number --check_existing --gencode_basic
echo "`date +"%m-%d-%Y %H:%M:%S"` EGFR finished"

##################### For whole genome

#echo "`date +"%m-%d-%Y %H:%M:%S"` process whole genome "
#picard AddOrReplaceReadGroups I=$bam_path$name".cs.rmdup.bam" O=$name".cs.rmdup.RG.bam" RGID=RG$name RGLB=Lib$name RGPL=illumina RGSM=$name RGPU=unit$name RGCN=Center1 VALIDATION_STRINGENCY=SILENT TMP_DIR=tmp2$name;
#samtools index $name".cs.rmdup.RG.bam";
#echo "`date +"%m-%d-%Y %H:%M:%S"` run whole genome "
#gatk HaplotypeCaller -R hg38.fa -I $name".cs.rmdup.RG.bam" -O $name".vcf.gz";
#echo "`date +"%m-%d-%Y %H:%M:%S"` filter whole genome "
#gatk VariantFiltration -R hg38.fa -V $name".vcf.gz" -O $name".vcf.filter.gz" --filter-expression "QUAL < 30.0" --filter-name "LowQual" --filter-expression "DP < 10" --filter-name "LowCoverage";

/data/zhanglab/Weijia_Su/software/ensembl-vep/vep -i $name".vcf.filter.gz" -o $name".vcf.filter.vep.txt" --cache --dir_cache /data/zhanglab/Weijia_Su/software/ensembl-vep/cache/ --assembly GRCh38 --everything --force_overwrite --stats_text --fork 32 --allele_number --check_existing --gencode_basic
 echo "`date +"%m-%d-%Y %H:%M:%S"` Whole genome finished "
