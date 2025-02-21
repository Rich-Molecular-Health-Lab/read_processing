#!/bin/bash
#SBATCH --time=00:45:00
#SBATCH --job-name=trim
#SBATCH --error=/work/richlab/aliciarich/read_processing/logs/trim_%A_%a.err
#SBATCH --output=/work/richlab/aliciarich/read_processing/logs/trim_%A_%a.out
#SBATCH --partition=guest
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=100GB

module purge
module load dorado

cd /work/richlab/aliciarich/read_processing

seqrun="salci1"

dorado trim "reads/basecalled/$seqrun.bam" --emit-fastq > "reads/trimmed/$seqrun.fastq"