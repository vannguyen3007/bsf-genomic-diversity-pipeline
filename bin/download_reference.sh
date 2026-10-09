#!/usr/bin/env bash
set -euo pipefail
mkdir -p reference
URL="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/905/115/235/GCF_905115235.1_iHerIll2.2.curated.20191125/GCF_905115235.1_iHerIll2.2.curated.20191125_genomic.fna.gz"
curl -L "$URL" -o reference/reference.fna.gz
gunzip -f reference/reference.fna.gz
samtools faidx reference/reference.fna
