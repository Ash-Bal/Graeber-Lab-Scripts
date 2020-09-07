library(data.table)
library(dplyr)

methData <- fread("/Users/ashvath/Desktop/Graeber Lab/organized_450k_data_UVM.csv")
oldData <- fread("/Users/ashvath/Desktop/Graeber Lab/TCGA UVM Data/cleaned_UVM_Methylation_Data_RAW.csv")
oldGenes <- fread("")
methData <- as.data.frame(methData)

#remove rows that have all zeros
noZeroRows <- methData[apply(methData[,-(1:4)], 1, function(x) !all(x==0)), ]

#remove rows that have any NA values
noNAs <- methData[complete.cases(methData[,-(1:4)]), ] 

#remove methylation sites that "belong" to two or more genes
noInter <- noNAs[!grepl(";", noNAs$Gene), ] 

#remove rows that have no gene name
methDataGenes <- methDataGenes[!(methDataGenes$Gene == ""), ]

#remove unnecesary columns
methDataGenes <- noInter[-c(1,3,4)]


fwrite(methDataSites,"UVM_Methylation_Data_Sites_Only.csv")
fwrite(noInter, "UVM_Methylation_Data.csv")










