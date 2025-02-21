#!/bin/bash

seqrun="salci1"
kit="SQK-LSK114"

dorado trim "reads/basecalled/$seqrun.bam" --sequencing-kit "$kit" --emitfastq --output-dir "reads/trimmed/$seqrun"