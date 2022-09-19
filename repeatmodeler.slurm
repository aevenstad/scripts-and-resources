#!/bin/bash
#SBATCH --account=nn9858k
#SBATCH --job-name=RepeatModeler2.0.3
#SBATCH --time=4-00:00:00
#SBATCH --mem-per-cpu=4G
#SBATCH --cpus-per-task=20
#SBATCH --output=%x.%j.out

## ABORT IF ANY ERROR ##
set -e
module purge


### LOAD  CONDA ENV ###
module load Miniconda3/4.9.2
export PS1=\$
source ${EBROOTMINICONDA3}/etc/profile.d/conda.sh
conda deactivate &>/dev/null
conda activate repeatmodeler

# R
export BLAST_USAGE_REPORT=false

RepeatModeler -database $infile -pa 20 -LTRStruct
