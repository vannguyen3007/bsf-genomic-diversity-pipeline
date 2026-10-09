process FASTQC {
 tag "$sample"
 publishDir "${params.outdir}/qc/fastqc", mode:'copy'
 input: tuple val(sample), path(r1), path(r2)
 output: path "*_fastqc.*", emit: reports
 script: """fastqc -t ${task.cpus} ${r1} ${r2}"""
}
