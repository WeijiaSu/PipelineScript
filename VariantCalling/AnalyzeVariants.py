import pandas as pd
pd.set_option('display.max_columns', 40)

def Read_vcf_annotation(vcf_file):
	f = pd.read_table(vcf_file, skiprows=range(105))
	f = f.drop_duplicates(["#Uploaded_variation","Consequence"],keep="first")
	print(f[0:10])
	print(f.shape)

Read_vcf_annotation("A1.EGFR.filter.vcf.vepAnn.txt")
