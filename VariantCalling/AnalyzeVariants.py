import pandas as pd
pd.set_option('display.max_columns', 40)
import os

def Read_vcf_annotation(vcf_file):
	f = pd.read_table(vcf_file, skiprows=range(106))
	f = f.drop_duplicates(["#Uploaded_variation","Consequence"],keep="first")
	print(f[0:10])
	print(f.shape)

#Read_vcf_annotation("A1.EGFR.filter.vcf.vepAnn.txt")

def Read_summary(summary_file):
	sampleName=summary_file.split(".")[0]
	out=open(sampleName+".consequence.summary.txt","w")
	out.write("consequence"+"\t"+sampleName+"\n")
	with open(summary_file, 'r') as f:
		start = False
		for line in f:
			if "[Consequences (most severe)]" in line:
				start = True
			elif "[Consequences (all)]" in line:
				start = False
			elif start:
				out.write(line)
	out.close()
	f.close()

files=os.listdir("./")
files=[i for i in files if "EGFR.filter.vcf.vepAnn.txt_summary.txt" in i]
files=sorted(files)
names=[i.split(".")[0] for i in files]
#for filename in files:
#	name=filename.split(".")[0]
#	Read_summary(filename)
#	t=pd.read_table(name+".consequence.summary.txt",header=0)
#	print(t.shape)
#	print(t)
f0=pd.read_table(names[0]+".consequence.summary.txt",header=0)
for name in names[1:]:
	f_=pd.read_table(name+".consequence.summary.txt",header=0)
	f0=f0.merge(f_,on=["consequence"],how="outer")
	print(f0)
	print(f0.shape)
f0=f0.fillna(value=0)
f0.iloc[:, 1:] = f0.iloc[:, 1:].astype(int)
print(f0)
print(f0.shape)
f0.to_csv("tumor.variant.cons.txt",index=None,sep="\t")

