#!/bin/bash
#SBATCH --time=2:00:00
#SBATCH --job-name=basecall
#SBATCH --error=/work/richlab/aliciarich/read_processing/logs/basecall_%A_%a.err
#SBATCH --output=/work/richlab/aliciarich/read_processing/logs/basecall_%A_%a.out
#SBATCH --partition=gpu,guest_gpu
#SBATCH --constraint='gpu_v100|gpu_t4'
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=200GB
#SBATCH --gres=gpu:1

module purge
module load dorado-gpu

seqrun=NWR1

cd /work/richlab/aliciarich/read_processing

mkdir -p reads/basecalled

dorado basecaller sup \
    "seqRuns/$seqrun/pod5" \
    --recursive \
    --no-trim \
    > "reads/basecalled/$seqrun.bam" && \
dorado summary "reads/basecalled/$seqrun.bam" > "logs/$seqrun_basecall_summary.tsv"