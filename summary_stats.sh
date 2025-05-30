# Summary of Fastq data

# Count reads in raw data
for fastq in data/*_fastq/*.fastq
do
	sample=$(basename $fastq .fastq)
	lines=$(wc -l < data/*_fastq/${sample}.fastq)
	reads=$(echo "$lines / 4" | bc)
	echo "$sample result: $reads"
done
# Count reads that aligned to the genome
    ##Will need to use the "samtools view" command with the "-F 0x4" argument. Explain what this argument does
# Number of variant sites from each sample
# Save to a tidy-formatted data file
