#!/bin/bash
#SBATCH --time=03:00:00
#SBATCH --job-name=wfbacgen
#SBATCH --error=/work/richlab/aliciarich/read_processing/logs/wfbacgen_%A_%a.err
#SBATCH --output=/work/richlab/aliciarich/read_processing/logs/wfbacgen_%A_%a.out
#SBATCH --partition=guest
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=350GB

module purge
module load nextflow

cd /work/richlab/aliciarich/read_processing

seqrun=salci1

mkdir -p processed/$seqrun

nextflow run epi2me-labs/wf-bacterial-genomes \
	-profile singularity \
	--fastq "reads/filtered/$seqrun.fastq" \
	--isolates \
	--sample "$seqrun" \
  --out_dir "processed/$seqrun" \
  --threads 32