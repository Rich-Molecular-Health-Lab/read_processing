#!/bin/bash
#SBATCH --time=00:45:00
#SBATCH --job-name=qc_multiplex
#SBATCH --error=/work/richlab/aliciarich/read_processing/logs/qc_multiplex_%A_%a.err
#SBATCH --output=/work/richlab/aliciarich/read_processing/logs/qc_multiplex_%A_%a.out
#SBATCH --partition=guest
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=100GB

module load anaconda

conda activate filter

cd /work/richlab/aliciarich/read_processing

seqrun=NWR1
trimmed=reads/trimmed/$seqrun
filtered=reads/filtered/$seqrun

mkdir -p $filtered

cd $trimmed

for file in "$trimmed"/*.fastq; do
    
    if [ -f "$file" ]; then
       
        base_filename=$(basename "$file")

        chopper --maxlength 2000 --minlength 1000 --quality 7 --input "$file" > "$filtered/$base_filename"

        echo "Processed $file"
    else
        echo "Error: File $file does not exist or is not a regular file."
    fi
done

cd $filtered

for file in "$filtered"/*.fastq; do
    if [ -f "$file" ]; then
        base_filename=$(basename "$file" .fastq)
        
        mkdir -p "$filtered/$base_filename"
        
        mv "$file" "$filtered/$base_filename/${base_filename}.fastq"
        
        echo "Organized $file"
    else
        echo "Error: File $file does not exist or is not a regular file."
    fi
done