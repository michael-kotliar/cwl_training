#!/usr/bin/env Rscript

#######################
#                     #
# Functional Genomics #
#    make_heatmap     #
#                     #
#######################

#required package
library(dplyr)
library(gplots)
library(as.color)

cleaned_breast_cancer_filename = "/Users/kot4or/workspaces/cwl_ws/cwl_training/tests/data/54_breast_cancer_ilincs_cleaned.gct"
p_values_filename = "/Users/kot4or/workspaces/cwl_ws/cwl_training/tests/data/54_breast_cancer_ilincs_cleaned_p_values.tsv"
heatmap_filename = paste0(head(unlist(strsplit(basename(cleaned_breast_cancer_filename), ".", fixed = TRUE)), 1), "_heatmap.pdf")

#Export all graphics to file
pdf(heatmap_filename)

#Read in the text files
expression_data=read.table(cleaned_breast_cancer_filename, sep="\t", header=T)
statistics_data=read.table(p_values_filename, sep="\t", header=T)

#reformat expression file for heatmap
expression_data_new=rbind(expression_data[7,6:ncol(expression_data)], expression_data[15:nrow(expression_data),6:ncol(expression_data)])
expression_data_new=expression_data_new[,order(expression_data_new[1,])]
expression_data_new=cbind(c("ER_status", as.character(expression_data[15:nrow(expression_data),3])), expression_data_new)
colnames(expression_data_new)[1]="ID"

#reduce to top n significant genes
n=min(500, length(which(statistics_data[,4]<=0.05)))
statistics_data_reduced=statistics_data[1:n,]
expression_data_reduced=left_join(statistics_data_reduced, expression_data_new, by=c("ID"="ID")) #more than n rows due to duplicate names
expression_data_reduced=expression_data_reduced[,-(2:4)]
color=as.color(as.character(expression_data_new[1,2:ncol(expression_data_new)]))
expression_data_reduced=rbind(expression_data_new[1,], expression_data_reduced)

#make the heatmap
N=apply(expression_data_reduced[2:nrow(expression_data_reduced),2:ncol(expression_data_reduced)],2,as.numeric)
breaks=seq(0, #start point of color key
           quantile(N, 0.95),  #end point of color key (95th percentile)
           by=0.01) #length of sub-division
mycol=colorpanel(n=length(breaks)-1,low="blue",mid="black",high="yellow") #heatmap colors
heatmap.2(N, #the matrix
          Colv=NA, #no clustering of columns
          Rowv = TRUE, #clustering of rows
          col=mycol, #colors used in heatmap
          ColSideColors = color, #column color bar
          breaks=breaks, #color key details
          trace="none", #no trace on map
          na.rm=TRUE, #ignore missing values
          margins = c(15,10), #size and layout of heatmap window
          xlab = "Breast Cancer Samples", #x axis title
          ylab =  "Genes", #y axis title
          main = "Heatmap of Breast Cancer" ) #main title
legend("bottomleft", #location of legend
       c("negative","positive"), #subtypes
       pch=19 , #shape of the bullet
       cex = 0.75, #size of legend
       col=c(unique(color))) #color of each subtype

graphics.off()