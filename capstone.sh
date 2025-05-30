# Capstone Project Script

# Make directories
#mkdir data docs results
#mkdir data/backup data/trimmed_fastq data/genomes
#mkdir results/fastqc_raw_results results/fastqc_trimmed_results results/sam results/bam results/vcf results/bcf

#Prepare Data
## Copy over data
#cp -r /work/binf8960/instructor_data/raw_fastq ./data/

## Make data read-only
#chmod -w data/raw_fastq/*.fastq*

## Make backup data
cp -r data/raw_fastq/* data/backup
