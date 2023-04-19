import pandas as pd
pd.set_option("display.max_columns",40)

v=pd.read_table("/data/zhanglab/Weijia_Su/Git/PipelineScript/Kraken/VERTU_eccDNA.Mar.23.2023.txt")
d=dict(zip(v["TumorID"],v["BloodID"]))

def getBrackenfile(Tumer):
	f1=pd.read_table("/data/zhanglab/Weijia_Su/Kraken2/VERTU/tumor/"+Tumer+".report.txt")
	f1=f1.drop_duplicates(["taxonomy_id"],keep="first")
	f2=pd.read_table("/data/zhanglab/Weijia_Su/Kraken2/VERTU/blood/"+d[Tumer]+".report.txt")
	f2=f2.drop_duplicates(["taxonomy_id"],keep="first")
	f=f1.loc[f1["taxonomy_id"].isin(list(f2["taxonomy_id"]))]
	
	return [Tumer,d[Tumer],f1.shape[0],f2.shape[0],f.shape[0]]

all_res=[]
for i in d:
	l=getBrackenfile(i)
	all_res.append(l)

c=["TumorID","BloodID","TumorTaxonomy","BloodTaxonomy","Shared"]
res=pd.DataFrame(all_res,columns=c)
res.to_csv("Tumor_blood_taxonomy.tsv",header=None,sep="\t",index=None)
print(res)
