process BCFTOOLS_CALL {
 tag "$sample"
 publishDir "${params.outdir}/variants/per_sample", mode:'copy'
 input:
 tuple val(sample), path(bam)
 path reference
 output: tuple val(sample), path("${sample}.bcf"), path("${sample}.bcf.csi"), emit: bcfs
 script:
 """
 set -euo pipefail
 samtools faidx ${reference}
 samtools index ${bam}
 bcftools mpileup -Ou -f ${reference} -a FORMAT/DP,FORMAT/AD ${bam} | bcftools call -mv -Ob -o ${sample}.bcf
 bcftools index -f ${sample}.bcf
 """
}
