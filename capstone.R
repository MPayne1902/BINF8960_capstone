# R script for making graphs for summary data from capstone project

library(dplyr)
library(ggplot2)

# Read in the summary data files
raw = read.csv("summary_results/raw_read_count.csv")
trimmed = read.csv("summary_results/trimmed_read_count.csv")
aligned = read.csv("summary_results/aligned_read_count.csv")
variant = read.csv("summary_results/variant_site_count.csv")

# Make a summary table for paired only 
## Labels/Value definition
labels = c("SRR2584863", "SRR2584863", "SRR2584866", "SRR2584866", "SRR2589044", "SRR2589044")
raw_label = c("Raw","Raw","Raw")
trimmed_label = c("Trimmed","Trimmed","Trimmed")
aligned_label = c("Aligned","Aligned","Aligned")
paired = trimmed[c(1,3,5,7,9,11),]
main_labels = c(raw$Sample, paired$Sample, aligned$Sample)

## Table creation & column type assignment
Table1 = as.data.frame(
  matrix(c(labels, labels, aligned$Sample,
         raw_label, raw_label, 
         trimmed_label, trimmed_label, 
         aligned_label,
         raw$Read_Count, paired$Read_Count, aligned$Aligned_Reads),
       nrow = 15, ncol = 3, byrow = FALSE,
       dimnames = list(main_labels, 
                      c("Sample", "Count_Type", "Count"))))

Table1$Count = as.integer(Table1$Count)

## Reads added together based on type and sample
Table2 = Table1 %>%
  group_by(Count_Type, Sample) %>%
  summarize(Count = sum(Count, na.rm=TRUE))

# Select for forward and paired samples only from raw & trimmed data
raw_forward = raw[c(1,3,5),] #Selects for the forward samples only
paired_forward = trimmed[c(1,5,9),] #Selects for only the paired and forward samples

# Make a table with forward and paired only summary data 
fwd = as.data.frame(
  matrix(c(aligned$Sample, aligned$Sample, aligned$Sample,
           raw_label, c("Trimmed","Trimmed","Trimmed"), c("Aligned","Aligned","Aligned"),
           raw_forward$Read_Count, paired_forward$Read_Count, aligned$Aligned_Reads),
         nrow = 9, ncol = 3, byrow = FALSE,
         dimnames = list(c(1:9), c("Sample", "Count_Type", "Count"))))

# Graph Creation
## Line graph for summary data
summary_graph = ggplot(Table2) +
  aes(x=Count_Type, y=Count, color=Sample, group=Sample) +
  scale_x_discrete(limits = c("Raw", "Trimmed", "Aligned")) +
  geom_line(linewidth = 1.5) + theme_classic() +
  labs(x="", title="Read Count of Samples")

## Line graph for forward and paired only
forward_graph = ggplot(fwd) +
  aes(x=Count_Type, y=Count, color=Sample, group=Sample) +
  scale_x_discrete(limits = c("Raw", "Trimmed", "Aligned")) +
  geom_line(linewidth = 1.5) + theme_classic() +
  labs(x="", title="Read Count for Forward & Paired Samples")

## Bar graph for variant count
variant_graph = ggplot(variant) +
  aes(x=Sample, y=Variant_Sites, color=Sample) +
  theme_classic() +
  geom_col(size = 1, fill = "white") + 
  labs(y="Variant Sites", title="Number of Variant Sites for Each Sample")

## Saving Graphs
ggsave(summary_graph, file="graphs/summary_line_graph.png", 
       width = 6, height = 4, units = "in")
ggsave(forward_graph, file="graphs/forward_line_graph.png", 
       width = 6, height = 4, units = "in")
ggsave(variant_graph, file="graphs/variant_bar_graph.png", 
       width = 6, height = 4, units = "in")