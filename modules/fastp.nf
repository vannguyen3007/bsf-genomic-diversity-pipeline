process FASTP {
 tag "$sample"
 publishDir "${params.outdir}/qc/fastp", mode:'copy'
 input: tuple val(sample), path(r1), path(r2)
 output:
 tuple val(sample), path("${sample}_R1.clean.fastq.gz"), path("${sample}_R2.clean.fastq.gz"), emit: reads
 path "${sample}.fastp.html", emit: html
 path "${sample}.fastp.json", emit: json
 script:
 """
 fastp -w ${task.cpus} -i ${r1} -I ${r2} -o ${sample}_R1.clean.fastq.gz -O ${sample}_R2.clean.fastq.gz --html ${sample}.fastp.html --json ${sample}.fastp.json
 """
}
