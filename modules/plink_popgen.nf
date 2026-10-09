process PLINK_POPGEN {
 publishDir "${params.outdir}/population_genetics", mode:'copy'
 input: tuple path(vcf), path(index)
 output: path('cohort*'), emit: files
 script:
 """
 set -euo pipefail
 plink2 --vcf ${vcf} --double-id --allow-extra-chr --set-all-var-ids '@:#:\$r:\$a' --maf ${params.maf} --geno ${params.geno} --mind ${params.mind} --make-bed --out cohort
 plink2 --bfile cohort --allow-extra-chr --freq --out cohort.freq
 plink2 --bfile cohort --allow-extra-chr --het --out cohort.het
 plink2 --bfile cohort --allow-extra-chr --indep-pairwise 50 5 0.2 --out cohort.ld
 plink2 --bfile cohort --allow-extra-chr --extract cohort.ld.prune.in --pca 10 approx --out cohort.pca
 plink2 --bfile cohort --allow-extra-chr --extract cohort.ld.prune.in --make-king-table --out cohort.kinship
 if [ '${params.roh}' = 'true' ]; then
   plink --bfile cohort --allow-extra-chr --homozyg --out cohort.roh
 fi
 """
}
