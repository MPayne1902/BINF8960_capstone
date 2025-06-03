# Summary of Fastq data
mkdir summary_results

# Count reads in raw data
echo "Count Raw Reads"
echo "Sample,Read_Count" > summary_results/raw_read_count.csv # Make summary file for raw reads
for raw in data/raw_fastq/*.fastq
do
        rawsam=$(basename $raw .fastq)
        rawline=$(wc -l < data/raw_fastq/${rawsam}.fastq) # Counts lines in raw data file
        rawread=$(echo "$rawline / 4" | bc) # Divides number of lines by 4 (4 lines per read) to get the read count
        echo "$rawsam result: $rawread"
        echo "$rawsam,$rawread" >> summary_results/raw_read_count.csv # Saves count to summary file
done

# Count reads in trimmed data
echo "Count Trimmed Reads"
echo "Sample,Read_Count" > summary_results/trimmed_read_count.csv # Make summary file for trimmed reads
for trim in data/trimmed_fastq/*.fastq
do
	trimsam=$(basename $trim .fastq)
	trimline=$(wc -l < data/trimmed_fastq/${trimsam}.fastq) # Counts lines in trimmed data file
	trimread=$(echo "$trimline / 4" | bc) # Divides number of lines by 4 (4 lines per read) to get the read count
	echo "$trimsam result: $trimread"
	echo "$trimsam,$trimread" >> summary_results/trimmed_read_count.csv # Saves count to summary file
done

# Count reads that aligned to the genome
module load SAMtools/1.18-GCC-12.3.0

echo "Count Aligned Reads"
echo "Sample,Aligned_Reads" > summary_results/aligned_read_count.csv # Make a summary file for aligned reads
for aligned in results/sam/*.sam
do
	var=$(basename $aligned .sam)
	count=$(samtools view -c -F 0x4 results/sam/$var.sam) #"-c" gives the count and "-F" is to exclude any flags stated, such as "0x4" which is for unmapped segments
	echo "$var aligned reads: $count"
	echo "$var,$count" >> summary_results/aligned_read_count.csv # Saves count to summary file
done

# Number of variant sites from each sample
echo "Count Number of Variant Sites"
echo "Sample,Variant_Sites" > summary_results/variant_site_count.csv # Make a variant count summary file
for spot in results/vcf/*.vcf
do
	three=$(basename $spot .vcf)
	site=$(tail -n +29 results/vcf/${three}.vcf | wc -l) # Counts lines (variants) after the headers (first 28 lines)
	echo "$three variant sites: $site"
	echo "$three,$site" >> summary_results/variant_site_count.csv # Saves count to summary file
done

# Now download the "summary_results" folder to your computer for work in R
