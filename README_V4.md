# BSF Genomic Diversity Pipeline v4 (development upgrade)
This update extends the original v3 Nextflow DSL2 repository following the BSF internship work plan.

## Quick start
1. Install Nextflow, Java, and Conda/Mamba.
2. Update `assets/samplesheet.csv` with sample,fastq_1,fastq_2 columns and real FASTQ paths.
3. Obtain a BSF reference FASTA and record its assembly accession.
4. Run: `nextflow run main.nf -profile conda --input assets/samplesheet.csv --reference reference/reference.fna --outdir results -resume`
5. Set `--roh true` only after validating ROH settings for your data.

## Caution
This is a code upgrade, not a verified end-to-end scientific pipeline. Consult docs/V4_NOTES.md for limitations and remaining tasks.
