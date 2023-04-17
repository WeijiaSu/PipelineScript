import pandas as pd
import re
import os
pd.set_option('display.max_columns', 40)

def SplitExtra(s,featureName):
	match = re.search(r'%s=(.*?);'%(featureName), s)
	return match.group(1)


def SplitFeature(filename,featureName):
	f=pd.read_table(filename,skiprows=range(106))
	f[featureName]=f["Extra"].apply(lambda x: SplitExtra(x,featureName))
	print(f[0:10])
	print(f.shape)
	return f

#res=SplitFeature("A1.EGFR.filter.vcf.vepAnn.txt","IMPACT")
#res=res.groupby(["IMPACT"],as_index=False).count()
#print(res)


def getCons(filename):
	print(filename)
	f=pd.read_table(filename,skiprows=range(106))
	f=f.loc[f["Consequence"]=="missense_variant"]
	f=f.drop_duplicates(["#Uploaded_variation"],keep="first")
	if f.shape[0]>0:
		name=str(filename.split(".")[0])
		f["sample"]=name
		return f

files=os.listdir("./")
files=[i for i in files if i[-26:]=="EGFR.filter.vcf.vepAnn.txt"]
files=sorted(files)
F0=pd.read_table(files[0],skiprows=range(106))
c=list(F0.columns)+["sample"]
combine=pd.DataFrame(columns=c)
print(combine)
for f_i in files:
	fi=getCons(f_i)
	combine=combine.append(fi)

print(combine)
print(combine.shape)
combine.to_csv("tumor.variant.missense.txt",index=None,sep="\t")
