#small script to remove any methylation sites that are in chromosome 3
methData <- noInterMethData
noCr3 <- methData %>% filter(!Chromosome == 3)

noCr3 <- noCr3[-2]

noCr3 <- as.data.frame(noCr3)
rownames(noCr3) <- noCr3$Gene_Symbol

fwrite(noCr3, "TCGA UVM Methylation Data by Genes without Cr3-pCA ready.csv")