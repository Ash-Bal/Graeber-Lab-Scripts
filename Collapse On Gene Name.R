library(dplyr)
library(tidyr)
library(data.table)


#' 1. Import the cleaned methyalation data
#' 2. Collapse Data onto gene by averaging the Beta values for each sample



methData <- fread("/Users/ashvath/Desktop/Graeber Lab/TCGA UVM Data/cleaned_UVM_Methylation_Data_RAW.csv")

methData <- as.data.frame(methData)

#change chromosome column to number instead of string
methData$Chromosome <- as.numeric(methData$Chromosome)
methData <- methData[,-c(1,4)]

#use pipes to remove rows with NA values
methData2 <- methData %>% na.omit()

#use pipes to average over rows with the same gene name
methDataGenes2 <- methDataGenes %>% group_by(Gene) %>% summarise_all(mean) %>% na.omit()
methData <- methDataGenes2
rownames(methData) <- methData$Gene_Symbol


#create dataframe with sites that have multiple genes
#these sites can be filtered for using the semi-colon character
overlapData <- filter(methData, grepl(';', methData$Gene_Symbol))

#create dataframe with none of the overlapped regions
noOverlapData <-  filter(methData, !(grepl(';', methData$Gene_Symbol)))

#this is how we account for overlapped regions
#overlapped regions were counted in the averages for both genes in the overlap
splitGene <- overlapData %>% separate(Gene_Symbol, c("Gene1", "Gene2"), sep = ";")

#now Gene1 and Gene2 all hold values for sites that belong to one gene
#this just split our overlap data into two dataframes
Gene1 <- splitGene[, c(1, 3:ncol(splitGene))]
Gene2 <- splitGene[, 2:ncol(splitGene)]

colnames(Gene1)[1] <- "Gene_Symbol"
colnames(Gene2)[1] <- "Gene_Symbol"

#combines our two seperate dataframes into one big one
#we took the inter-region rows and split them into their own genes
interRegionCollapse <- rbind(Gene1, Gene2)

#inter-regions may have involved the same genes so we average over genes in the inter-region data
interRegionCollapse <- interRegionCollapse %>% group_by(Gene_Symbol) %>% summarise_all(mean)

#combine our manually separated inter-region data, and the data that originally didn't have inter regions
noInterMethData <- rbind(noOverlapData, interRegionCollapse)
noInterMethData <- noInterMethData %>% group_by(Gene_Symbol) %>% summarise_all(mean)

fwrite(noInterMethData, "TCGA UVM Methylation Data Using Genes -PCA ready.csv")



