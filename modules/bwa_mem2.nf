process BWA_MEM2 {
 tag "$sample"
 cpus 4
 publishDir "${params.outdir}/alignment", mode:'copy'
 input:
 tuple val(sample), path(r1), path(r2)
 path reference
 output: tuple val(sample), path("${sample}.bam"), emit: bams
 script:
 """
 set -euo pipefail
 bwa-mem2 index ${reference}
 bwa-mem2 mem -t ${task.cpus} -R '@RG\tID:${sample}\tSM:${sample}\tPL:ILLUMINA' ${reference} ${r1} ${r2} | samtools sort -@ ${task.cpus} -o ${sample}.bam -
 samtools quickcheck ${sample}.bam
 """
}
