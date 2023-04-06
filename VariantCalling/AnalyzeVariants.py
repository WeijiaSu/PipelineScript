import pandas as pd
pd.set_option('display.max_columns', 40)

def Read_vcf_annotation(vcf_file):
	f = pd.read_table(vcf_file, skiprows=range(106))
	f = f.drop_duplicates(["#Uploaded_variation","Consequence"],keep="first")
	print(f[0:10])
	print(f.shape)

#Read_vcf_annotation("A1.EGFR.filter.vcf.vepAnn.txt")

def Read_summary(summary_file):
	with open(summary_file, 'r') as f:
		start = False
		for line in f:
			if "[Consequences (most severe)]" in line:
				start = True
			elif "[Consequences (all)]" in line:
				start = False
			elif start:
				print(line.strip())

Read_summary('A1.EGFR.filter.vcf.vepAnn.txt_summary.txt')
