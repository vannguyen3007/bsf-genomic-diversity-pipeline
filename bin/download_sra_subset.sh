#!/usr/bin/env bash
# Usage: ./bin/download_sra_subset.sh SRRxxxx SRRyyyy ...
set -euo pipefail
mkdir -p data
for acc in "$@"; do
  prefetch "$acc"
  fasterq-dump "$acc" --split-files --threads 6 -O data
  gzip -f data/${acc}_1.fastq data/${acc}_2.fastq
done
