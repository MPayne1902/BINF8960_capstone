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
#cp -r data/raw_fastq/* data/backup

# Load Modules
module load FastQC/0.11.9-Java-11
module load MultiQC/1.14-foss-2022a
module load Trimmomatic/0.39-Java-13
module load BWA/0.7.18-GCCcore-13.3.0 #Load BWA
module load SAMtools/1.18-GCC-12.3.0
module load BCFtools/1.18-GCC-12.3.0

# Quality control on raw reads

## Run FastQC on raw reads
#fastqc -o results/fastqc_raw_results data/raw_fastq/*.fastq*

## Run MultiQC to compile the FastQC results
multiqc -o results/fastqc_raw_results results/fastqc_raw_results
