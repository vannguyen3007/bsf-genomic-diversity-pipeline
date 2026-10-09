process MULTIQC {
 publishDir "${params.outdir}/qc/multiqc", mode:'copy'
 input: path qc
 output: path "multiqc_report.html"
 script: """multiqc . -o ."""
}
