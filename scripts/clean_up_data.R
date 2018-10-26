#!/usr/bin/env Rscript

#######################
#                     #
# Functional Genomics #
#    clean_up_data    #
#                     #
#######################

breast_cancer_filename = "/Users/kot4or/workspaces/cwl_ws/cwl_training/tests/data/54_breast_cancer_ilincs.gct"
cleaned_breast_cancer_filename = paste0(head(unlist(strsplit(basename(breast_cancer_filename), ".", fixed = TRUE)), 1), "_cleaned.gct")

#Read in the GCT file from iLINCS
breast_cancer_data=read.table(breast_cancer_filename, sep="\t", header=F, fill=T)

#Process GCT file (remove first line and make the second line the header)
meta_data=breast_cancer_data[1,]
colnames(breast_cancer_data)=lapply(breast_cancer_data[2,],as.character)
breast_cancer_data=breast_cancer_data[-(1:2),]

#Remove samples that do not have a + or - label for ER
num_label_columns=5
has_data=which(breast_cancer_data[7,]=="+" | breast_cancer_data[7,]=="-")
does_not_have_data=setdiff(1:ncol(breast_cancer_data), has_data)
breast_cancer_data=cbind(breast_cancer_data[,1:num_label_columns], breast_cancer_data[,has_data])

#Remove genes that have 0 expression across remaining samples
x=apply(breast_cancer_data[15:nrow(breast_cancer_data), 6:ncol(breast_cancer_data)],2,as.numeric)
y=rowSums(x)
breast_cancer_data=breast_cancer_data[-(which(y==0)+14),]

#Send this to the next process
write.table(breast_cancer_data, cleaned_breast_cancer_filename, sep="\t", row.names=FALSE)
