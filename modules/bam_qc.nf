process BAM_QC {
 tag "$sample"
 publishDir "${params.outdir}/qc/bam", mode:'copy'
 input: tuple val(sample), path(bam)
 output: path "${sample}.*.txt", emit: stats
 script:
 """
 samtools index ${bam} || true
 samtools flagstat ${bam} > ${sample}.flagstat.txt
 samtools stats ${bam} > ${sample}.stats.txt
 """
}
