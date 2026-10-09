process JOINT_MERGE {
 publishDir "${params.outdir}/variants/cohort", mode:'copy'
 input: path bcfs
 output: tuple path('cohort.raw.vcf.gz'), path('cohort.raw.vcf.gz.tbi'), emit: vcf
 script:
 """
 set -euo pipefail
 printf '%s\n' *.bcf > bcfs.list
 bcftools merge -l bcfs.list -Oz -o cohort.raw.vcf.gz
 bcftools index -t cohort.raw.vcf.gz
 """
}
