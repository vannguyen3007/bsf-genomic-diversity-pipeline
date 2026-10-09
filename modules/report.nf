process REPORT {
 publishDir "${params.outdir}/report", mode:'copy'
 input: path results
 output: path('BSF_report.html')
 script:
 """
 python ${projectDir}/bin/make_report.py . BSF_report.html
 """
}
