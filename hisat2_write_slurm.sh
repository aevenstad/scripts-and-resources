#!/bin/bash

# Set up variables

## make array for samples to trim
array=("Sample_1_1.fq.gz" "Sample_2_1.fq.gz" "Sample_n_1.fq.gz") # Create array with samples (only need forward samples for PE reads), double quoted  and no commas!

# set up loop for variables
for SAMPLE_ID_R1 in "${array[@]}"
do
        # Variable for reverse reads (R2)
        SAMPLE_ID_R2=${SAMPLE_ID_R1%%1.fq.gz}"2.fq.gz"
        
	# Name Hisat2 summary file 
	SUMMARY=${SAMPLE_ID_R1%%1.fq.gz}"hisat2_summary.txt"
        
	# Name output SAM file, remove suffix from sample names 
	OUT=${SAMPLE_ID_R1%%_1.fq.gz}".sam"

        # set up directory variable to locate files
        SEQ_DIR=/path/to/trimmed_sequences/
        OUT_DIR=/cluster/work/users/$USER/output_folder/ # for mapping always output files to user work area

        # Remove prefix "trimmed" from files for cleaner names
        SUMMARY=${SUMMARY#trimmed_}
        OUT=${OUT#trimmed_}

        # Indexed referance genome
        REF=/path/to/cuscuta_genome_idx

        # Set up variables for SAMtools
        BAM=${OUT%%.sam}"_uns.bam"
        SORTED=${OUT%%.sam}".bam"
        
        
# create a slurm file for each sample and do the mapping as separate jobs

cat > /path/to/execute/area/hisat2_${OUT%.sam}.slurm <<EOF # use sample name from variable $OUT as string in filename
#!/bin/bash
#SBATCH --account=nn9858k
#SBATCH --job-name=hisat2
#SBATCH --time=10:00:00
#SBATCH --mem-per-cpu=3G
#SBATCH --cpus-per-task=10
#SBATCH --output=%x.%j.out


#Exit script if a command fails
set -e

# clear any inherited modules and load Hisat2
module purge
module load HISAT2/2.1.0-foss-2018b


# Do mapping with Hisat2

hisat2 -x $REF --threads 8 \
 -1 ${SEQ_DIR}$SAMPLE_ID_R1 -2 ${SEQ_DIR}$SAMPLE_ID_R2 \
 -S ${OUT_DIR}$OUT \
 --summary-file ${OUT_DIR}$SUMMARY


# clear any inherited modules and load SAMtools
module purge
module load SAMtools/1.10-iccifort-2019.5.281


# Convert from SAM to BAM
samtools view -b ${OUT_DIR}$OUT > ${OUT_DIR}$BAM


# Sort the BAM-file
samtools sort ${OUT_DIR}$BAM -o ${OUT_DIR}$SORTED


# Index the sorted BAM-file
samtools index ${OUT_DIR}$SORTED


# Copy BAM and index files to project area
# Mapping produces very large SAM files and should not be stored on the project area
# Write output of mapping to '/cluster/work/users/$USER' then copy BAM files to project area
# SAM files can then be deleted as the information is already stored in BAM format

cp ${OUT_DIR}$SORTED /cluster/projects/nn9858k/
cp ${OUT_DIR}${SORTED}.bai /cluster/projects/nn9858k/
cp ${OUT_DIR}$SUMMARY /cluster/projects/nn9858k/
rm ${OUT_DIR}$OUT 


EOF

sbatch /cluster/projects/nn9858k/ccam_redlight_rnaseq/scripts/hisat2/hisat2_${OUT%.sam}.slurm


done
