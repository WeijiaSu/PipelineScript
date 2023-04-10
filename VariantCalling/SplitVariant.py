import pandas as pd
import re


def SplitFeature(filename,featureName):
	f=pd.read_table(filename,skiprows=range(106))
	print(f[0:10])
	print(f.shape)

SplitFeature("A1.EGFR.filter.vcf.vepAnn.txt","IMPACT")
