#substring column names
colnames(methData) <- substr(colnames(methData), start = 1, stop = 12)

#make values in column all uppercase
phenData[,2] <- toupper(phenData[,2])

#substring values in a column
phenData$orig.name <- substr(phenData$orig.name, start = 1, stop = 16)

#substitute a specific character with another character for all values in a column
colnames(freadTest3)[1:ncol(freadTest3)] <- gsub("-", ".", colnames(freadTest3)[1:ncol(freadTest3)], fixed = TRUE)


#copy all gene names from gene column and makes them the lable of the rows of the data frame
rownames(methData) <- methData$Gene_Symbol


#get rid of the gene names as values
methData <- methData[-1]


#get rid of one of the repeated columns
Kim_rsem_genes_upper_norm_counts <- Kim_rsem_genes_upper_norm_counts[,-6]

#make a matrix into a data frame
UVM_cell_line_phenotypes <- as.data.frame(UVM_cell_line_phenotypes)

#change column's label
colnames(phenData)[1] <- "Names"

#order data frame by the indicated column
phenData <- phenData[order(phenData$`met status`),]
colnames(phenData)[1] <- "Sample"

#change order of columns in "methData" dataframe to match order of values in "Sample" column of "phenData" dataframe
methData <- methData[,c(1,match(phenData$Sample, colnames(methData)))]

#change column names of one dataframe to match values in another dataframes column
colnames(TCGA_expression_UVM_illuminahiseq_rnaseqv2_normalized)[1:80] <- UVM_clin_annot_merged[,1]

#function to get rid of all rows that contain any zeroes in a data frame
remove_Zero = apply(expData, 1, function(row) all(row !=0))

#getting rid of all rows with any zeroes using earlier function
expData <- expData[remove_Zero,]
