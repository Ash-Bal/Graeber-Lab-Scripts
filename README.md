## Research Scripts in R

Repository containing a couple of the scripts I used for my projects at the Graeber Lab.

### Contents

- #### Cleaning450k.R
	- 450k methylation data was the primary data I was working with at the Graeber Lab
	- This script does some basic cleaning operations
		- removes NA values
		- removes any rows with all zero values
		- removes columns that are unnecessary for future research
- #### Collapse On Gene Name.R
	- Some of the tools being used to analyze the methylation data used gene names and would not work with methylation data
	- This script "collapses" all methylation site values by averaging all values that belong to a gene
		- this let us keep most of the information the methylation site values held, but enabled the use of tools that could only use gene tags
	- dataset goes from ~480,000 values to ~20,000 values 
- #### Easy Plot PCA.R
	- This script takes the scores matrix after running a dataset through PCA and plots it.
	- colors the two different sample types and labels axes
- #### General Dataframe Scripts.R 
	- Contains some generic single line code snippets that help change or remove values from data frames
	- used multiple times for all the different data frames I had to set up
- #### No Cr3.R
	- small script that removed any rows where the methylation site was on chromosome 3

