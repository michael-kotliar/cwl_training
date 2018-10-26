#!/usr/bin/env Rscript

#######################
#                     #
# Functional Genomics #
#     run_t_test      #
#                     #
#######################

cleaned_breast_cancer_filename = "/Users/kot4or/workspaces/cwl_ws/cwl_training/tests/data/54_breast_cancer_ilincs_cleaned.gct"
p_values_filename = paste0(head(unlist(strsplit(basename(cleaned_breast_cancer_filename), ".", fixed = TRUE)), 1), "_p_values.tsv")

#Read in the text file
expression_data=read.table(cleaned_breast_cancer_filename, sep="\t", header=T)

#Seperate into two groups (+ or - ER)
ER_pos=which(expression_data[7,]=="+")
ER_neg=which(expression_data[7,]=="-")

#Perform t-test for check for differences
ER_pos_data=apply(expression_data[15:nrow(expression_data),ER_pos],2,as.numeric)
ER_neg_data=apply(expression_data[15:nrow(expression_data),ER_neg],2,as.numeric)
results=as.data.frame(matrix(nrow=nrow(ER_pos_data), ncol=4))
results[,1]=as.character(expression_data[15:nrow(expression_data), 3])
for(i in 1:nrow(ER_pos_data)){
  results[i,2]=t.test(ER_pos_data[i,], ER_neg_data[i,])$p.value
}

#Organize data and correct for multiple tests
results[,3]=p.adjust(results[,2], "bonferroni")
results[,4]=p.adjust(results[,2], "fdr")
colnames(results)=c("ID", "raw", "bon", "fdr")

#Sort by fdr p-value
results=results[order(results$fdr),]

#Send this to the next process
write.table(results, p_values_filename, sep="\t", row.names=FALSE)
