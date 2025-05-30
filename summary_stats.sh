# Summary of Fastq data

# Count reads in raw and trimmed data
for raw in data/raw_fastq/*.fastq
do
	sample=$(basename $raw .fastq)
	wc -l data/raw_fastq/${sample}.fastq
	#echo $raw_read
done
# Count reads that aligned to the genome
    ##Will need to use the "samtools view" command with the "-F 0x4" argument. Explain what this argument does
# Number of variant sites from each sample
# Save to a tidy-formatted data file
