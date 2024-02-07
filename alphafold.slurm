#!/bin/bash
#SBATCH --partition=accel
#SBATCH --account=nn9858k
#SBATCH --job-name=alphafold
#SBATCH --time=10:00:00
#SBATCH --mem-per-cpu=4G
#SBATCH --nodes=1
#SBATCH --gpus-per-node=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --output=%x.%j.out


# Runtime for a ~600aa protein sequence with the slurm settings above was ~ 1.5 hours
# CPU Efficiency: 15.82%
# Memory Efficiency: 36.46% of 48.00 GB
# Resources can be downscaled for proteins of similar or shorter length.

## ABORT IF ANY ERROR ##
set -e

### LOAD  MODULES ###
module purge
module load AlphaFold/2.3.1-foss-2022a-CUDA-11.7.0


# SET VARIABLES

# Alphafold database directory needs to be set with export
export ALPHAFOLD_DATA_DIR=/cluster/shared/databases/AlphaFold/01-06-2023

# Set variable for fasta file for prediction
FASTA={fasta_input} 

# Set output directory to store results
OUT_DIR={output_directory}


# RUN PREDICTION

run_alphafold.py \
--data_dir $ALPHAFOLD_DATA_DIR \
--output_dir $OUT_DIR \
--model_preset monomer \
--fasta_paths $FASTA  \
--max_template_date $(date +%Y-%m-%d)
