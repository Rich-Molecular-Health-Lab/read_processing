#!/bin/bash
#SBATCH --time=00:45:00
#SBATCH --job-name=demux_trim
#SBATCH --error=swan$logs/demux_trim_%A_%a.err
#SBATCH --output=swan$logs/demux_trim_%A_%a.out
#SBATCH --partition=guest
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=100GB

seqrun=NWR1
samplesheet=samples/sample_sheets/bats/nwr1_sample_sheet.csv

cd /work/richlab/aliciarich/read_processing

mkdir -p "reads/trimmed/$seqrun"

module load dorado

dorado demux "reads/basecalled/$seqrun.bam" \
    --output-dir "reads/trimmed/$seqrun" \
    --kit-name "'SQK-16S114-24'" \
    --sample-sheet "$samplesheet" \
    --emit-fastq --emit-summary
    