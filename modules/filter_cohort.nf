process FILTER_COHORT {
 publishDir "${params.outdir}/variants/filtered", mode:'copy'
 input: tuple path(vcf), path(index)
 output: tuple path('cohort.filtered.vcf.gz'), path('cohort.filtered.vcf.gz.tbi'), emit: vcf
 script:
 """
 set -euo pipefail
 bcftools view -m2 -M2 -v snps -i 'QUAL>=${params.min_qual}' ${vcf} -Ou | bcftools filter -e 'FMT/DP<${params.min_dp}' -S . -Oz -o cohort.filtered.vcf.gz
 bcftools index -t cohort.filtered.vcf.gz
 bcftools stats cohort.filtered.vcf.gz > cohort.filtered.stats.txt
 """
}
