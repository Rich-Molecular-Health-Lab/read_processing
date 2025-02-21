#!/bin/bash

seqrun="salci1"
sampleset="isolates"

cd ../../GitRepos

dorado basecaller sup \
    --models-directory "$HOME/dorado/models" \
    "seqRuns/$seqrun/pod5" \
    --recursive \
    --no-trim \
    > "reads/basecalled/$seqrun.bam" &> "../logs/basecall_local.log" && \
dorado summary "reads/basecalled/$seqrun.bam" > "../logs/summary_$seqrun.tsv"
