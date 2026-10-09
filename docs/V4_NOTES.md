# v4 implementation notes
- Source: v3 repository; requirements: uploaded 12-week BSF internship work plan.
- Fixed: index propagation for cohort VCF, read-group tags, sample sheet validation, per-sample BCF index, basic automated HTML report.
- Filtering: quality and per-genotype depth; PLINK MAF, missingness and sample missingness.
- Report is a functional tabular preview, not a finished Quarto scientific interpretation template.
- FIS requires population labels and a clearly defined estimator; not implemented as an unsupported stand-in.
- ROH is optional and requires biologically calibrated thresholds and sufficient SNP density.
- Multi-sample `bcftools merge` of independently called variant-only BCFs can bias missing-reference genotypes. Production use should adopt all-sites joint genotyping or a validated gVCF strategy.
- For production: shared reference index, per-process conda environments/containers, cohort-level QC plots, provenance, unit tests, and real public data validation.
- No end-to-end run performed in this environment.
