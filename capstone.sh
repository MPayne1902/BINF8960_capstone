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
#multiqc -o results/fastqc_raw_results results/fastqc_raw_results

# Trim raw reads with Trimmomatic
TRIMMOMATIC="java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar"

for fwd in data/raw_fastq/*_1.fastq*
do
       echo "Trimming $sample"
       sample=$(basename $fwd _1.fastq.gz)
       $TRIMMOMATIC PE data/raw_fastq/${sample}_1.fastq.gz data/raw_fastq/${sample}_2.fastq.gz \
              data/trimmed_fastq/${sample}_1.paired.fastq.gz data/trimmed_fastq/${sample}_1.unpaired.fastq.gz \
              data/raw_fastq/${sample}_2.paired.fastq.gz data/raw_fastq/${sample}_2.unpaired.fastq.gz \
              ILLUMINACLIP:data/raw_fastq/NexteraPE-PE.fa:2:30:10:5:True SLIDINGWINDOW:4:20
done
