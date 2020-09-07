library(ggplot2)
library(ggfortify)
library(data.table)
library(RColorBrewer)


#script takes scores output of PCA and plots it to show clustering of different groups
df <- fread("/Users/ashvath/Dropbox/TCGA UVM Methylation Analysis/PCA/Collapsed on Genes/Loadings and Scores/UVM_Methylation_Data_Genes_Only.csv_prcomp_scores_VARIMAX.txt")
df <- as.data.frame(df)

df$Score <- substr(df$Score, start = 1, stop = 12)
df$Score <- gsub(".", "-", df$Score, fixed = TRUE)
pcData <- df[,c(1:3)]

metData <- TCGA_UVM_phenotypes_kp_copy[,c(1,7)]
metData$`Patient ID` <- toupper(metData$`Patient ID`)
metData$`GNAQ Altered` <- gsub("1", "Yes", metData$`GNAQ Altered`, fixed = TRUE)
metData$`GNAQ Altered` <- gsub("0", "No", metData$`GNAQ Altered`, fixed = TRUE)

metData <- metData[order(metData$`Patient ID`),]
pcData <- pcData[order(pcData$Score),]
metastaticData <- as.data.frame(metastaticData)
metastaticData <- metastaticData[order(metastaticData$patient.bcr_patient_barcode...2),]
pcData <- cbind(pcData, metastaticData$`met status`)


colnames(pcData) <- c("Sample", "P1", "P2", "Met_Status")

ggplot(data = pcData, mapping = aes(x = P1, y = P2)) +
  geom_point(aes(color = Met_Status), size = I(3)) +
  scale_colour_brewer(palette = "Set1") +
  ggtitle("TCGA UVM PCA Varimax Mets_Genes") +
  theme_bw()
