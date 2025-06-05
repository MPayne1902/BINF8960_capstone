# R script for making graphs for summary data from capstone project

library(dplyr)
library(ggplot2)

# Read in the summary data files
raw = read.csv("summary_results/raw_read_count.csv")
trimmed = read.csv("summary_results/trimmed_read_count.csv")
aligned = read.csv("summary_results/aligned_read_count.csv")
variant = read.csv("summary_results/variant_site_count.csv")

# Select for forward and paired samples only from raw & trimmed data
raw_forward = raw[c(1,3,5),] #Selects for the forward samples only
paired_forward = trimmed[c(1,5,9),] #Selects for only the paired and forward samples
raw2 = t(raw_forward)
write.csv(raw2, file = "summary_results/raw_forward_update.csv", 
          col.names = FALSE)
raw_forward_update = read.csv("summary_results/raw_forward_update.csv")

# Create a singular table for the read counts (no variants)
Labels = c("Raw", "Trimmed", "Aligned")
#mdat = matrix(c(, raw_forward$Read_Count, 
#                paired_forward$Read_Count, aligned$Aligned_Reads),
#              nrow = 3, ncol = 4, byrow = FALSE,
#               dimnames = list(c("samples", "Raw", "Trimmed", "Aligned), c(1,2,3)))
mdat
m3 = matrix(c(aligned$Sample, raw_forward$Read_Count, 
              paired_forward$Read_Count, aligned$Aligned_Reads), 
            nrow = 3, ncol = 4, byrow = FALSE,
               dimnames = list(c(1,2,3),
                               c("Samples", "Raw", "Trimmed", "Aligned")))
m4 = t(m3)
write.csv(m4, file="summary_results/m3.csv", col.names=FALSE)
m5 = read.csv("summary_results/m3.csv")
m4

#1=Raw, 2=Trimmed, 3=Aligned
try = as.data.frame(matrix(c(c(1,2,3), raw_forward$Read_Count, paired_forward$Read_Count, 
         aligned$Aligned_Reads),
       nrow = 3, ncol = 4, byrow = TRUE, 
       dimnames = list(c(1,2,3), c("step", "SRR2584863", "SRR2584866", "SRR2589044")))
ggplot(try) +
  
    geom_line()

aes(x=Labels, y=c(try$SRR2584863, try$SRR2584866, try$SRR2589044), color = aligned$Sample) +

m4 = t(m3)
m5 = as.data.frame(m4)
m5
----------------------
try2 = as.data.frame(
  matrix(c(aligned$Sample, c("raw","raw","raw"), raw_forward$Read_Count,
           aligned$Sample, c("trimmed","trimmed","trimmed"), paired_forward$Read_Count,
           aligned$Sample, c("aligned","aligned","aligned"), aligned$Aligned_Reads),
         nrow = 9, ncol = 3, byrow = FALSE,
         dimnames = list(c(1:9), c("Sample", "Count_Type", "Count"))))



-----------------------
mdata2 = t(mdat)
mdata2
mdat2 = as.data.frame(mdat)

test <- matrix(c(1,2,3, 11,12,13), nrow = 2, ncol = 3, byrow = TRUE,
               dimnames = list(c("row1", "row2"),
                               c("C.1", "C.2", "C.3")))
test

# Make a line plot from summary data
ggplot(m3) +
  aes(x=)




mydata = raw[grep(sample, raw$Sample),]

SumR = raw %>%
  mutate(mysample = sub("_*", "", raw$Sample)) %>%
  group_by(mysample) %>%
  summarize(Raw_Sum = sum(Read_Count, na.rm = TRUE))
SumR[c(1,3,5),]

for(mysample in sample){
  cat("Calculating for", mysample, "\n")
  mydata = raw[grep(sample, raw$Sample),]
  mysum = sum(mydata$Read_Count)
  cat("\tSum of forward and reverse is", mysum, "\n")
}

mysum = sum
raw_sum = raw %>%
  group_by(grep(sample, raw$Sample)) %>%
  summarize(Sum = sum(Read_Count))
raw_sum
