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
#module load FastQC/0.11.9-Java-11
#module load MultiQC/1.14-foss-2022a
#module load Trimmomatic/0.39-Java-13
module load BWA/0.7.18-GCCcore-13.3.0 #Load BWA
#module load SAMtools/1.18-GCC-12.3.0
#module load BCFtools/1.18-GCC-12.3.0

# Quality control on raw reads

## Run FastQC on raw reads
#fastqc -o results/fastqc_raw_results data/raw_fastq/*.fastq*

## Run MultiQC to compile the FastQC results
#multiqc -o results/fastqc_raw_results results/fastqc_raw_results

# Trim raw reads with Trimmomatic
#gunzip data/raw_fastq/*fastq.gz

#TRIMMOMATIC="java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar"

#for fwd in data/raw_fastq/*_1.fastq*
#do
#       sample=$(basename $fwd _1.fastq)
#       echo "Trimming $sample"
#       $TRIMMOMATIC PE data/raw_fastq/${sample}_1.fastq data/raw_fastq/${sample}_2.fastq \
#              data/trimmed_fastq/${sample}_1.paired.fastq data/trimmed_fastq/${sample}_1.unpaired.fastq \
#              data/trimmed_fastq/${sample}_2.paired.fastq data/trimmed_fastq/${sample}_2.unpaired.fastq \
#              ILLUMINACLIP:data/raw_fastq/NexteraPE-PE.fa:2:30:10:5:True SLIDINGWINDOW:4:20
#done

# Quality control on trimmed reads

## Run FastQC on trimmed reads
#fastqc -o results/fastqc_trimmed_results data/trimmed_fastq/*.fastq*

## Run MultiQC to compile the trimmed FastQC results
#multiqc -o results/fastqc_trimmed_results results/fastqc_trimmed_results

# Download E. coli genome for alignment

## Location to download the genome from
genome_url="ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/017/985/GCA_000017985.1_ASM1798v1/GCA_000017985.1_ASM1798v1_genomic.fna.gz"

## Download E. coli genomes
wget -O data/genomes/ecoli_rel606.fna.gz $genome_url
gunzip data/genomes/ecoli_rel606.fna.gz

## Index the genome
bwa index data/genomes/ecoli_rel606.fna

