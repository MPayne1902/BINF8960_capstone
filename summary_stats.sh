# Summary of Fastq data

# Count reads in raw and trimmed data
#for fastq in data/*_fastq/*.fastq
#do
#	sample=$(basename $fastq .fastq)
#	lines=$(wc -l < data/*_fastq/${sample}.fastq)
#	reads=$(echo "$lines / 4" | bc)
#	echo "$sample result: $reads"
#done

# Count reads that aligned to the genome
#module load SAMtools/1.18-GCC-12.3.0

#for aligned in results/sam/*.sam
#do
#	var=$(basename $aligned .sam)
#	count=$(samtools view -c -F 0x4 results/sam/$var.sam) #"-c" gives the count and "-F" is to exclude any flags stated, such as "0x4" which is for unmapped segments
#	echo "$var aligned reads: $count"
#done
# Number of variant sites from each sample
for spot in results/vcf/*.vcf
do
	three=$(basename $spot .vcf)
	site=$(tail -n +29 results/vcf/${three}.vcf | wc -l)
	echo "$three variant sites: $site"
done

# Save to a tidy-formatted data file
