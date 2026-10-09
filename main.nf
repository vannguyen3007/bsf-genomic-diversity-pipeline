nextflow.enable.dsl = 2
include { FASTQC } from './modules/fastqc'
include { FASTP } from './modules/fastp'
include { BWA_MEM2 } from './modules/bwa_mem2'
include { BAM_QC } from './modules/bam_qc'
include { BCFTOOLS_CALL } from './modules/bcftools_call'
include { JOINT_MERGE } from './modules/joint_merge'
include { FILTER_COHORT } from './modules/filter_cohort'
include { PLINK_POPGEN } from './modules/plink_popgen'
include { MULTIQC } from './modules/multiqc'
include { REPORT } from './modules/report'

params.input = params.input ?: 'assets/samplesheet.csv'
params.reference = params.reference ?: 'reference/reference.fna'
params.outdir = params.outdir ?: 'results'
params.maf = params.maf ?: 0.05
params.geno = params.geno ?: 0.10
params.mind = params.mind ?: 0.10
params.min_qual = params.min_qual ?: 30
params.min_dp = params.min_dp ?: 5
params.trim = params.trim == null ? true : params.trim
params.roh = params.roh == null ? false : params.roh

workflow {
  def sheet = file(params.input, checkIfExists: true)
  def ref = file(params.reference, checkIfExists: true)
  def rows = sheet.splitCsv(header:true).toList()
  def seen = [] as Set
  rows.each { r ->
    assert r.sample && r.sample ==~ /[A-Za-z0-9][A-Za-z0-9_.-]*/ : 'Invalid sample ID'
    assert seen.add(r.sample) : "Duplicate sample: ${r.sample}"
    assert r.fastq_1 && r.fastq_2 : "Missing FASTQ path for ${r.sample}"
    assert file(r.fastq_1).exists() && file(r.fastq_2).exists() : "FASTQ not found for ${r.sample}"
  }
  assert rows.size() > 0 : 'Empty samplesheet'
  reads = Channel.from(rows).map { r -> tuple(r.sample, file(r.fastq_1), file(r.fastq_2)) }
  FASTQC(reads)
  if (params.trim) {
    FASTP(reads)
    clean_reads = FASTP.out.reads
  } else {
    clean_reads = reads
  }
  BWA_MEM2(clean_reads, ref)
  BAM_QC(BWA_MEM2.out.bams)
  BCFTOOLS_CALL(BWA_MEM2.out.bams, ref)
  all_bcfs = BCFTOOLS_CALL.out.bcfs.map { sample, bcf, csi -> bcf }.collect()
  JOINT_MERGE(all_bcfs)
  FILTER_COHORT(JOINT_MERGE.out.vcf)
  PLINK_POPGEN(FILTER_COHORT.out.vcf)
  qc = FASTQC.out.reports.mix(BAM_QC.out.stats)
  if (params.trim) qc = qc.mix(FASTP.out.html)
  MULTIQC(qc.collect())
  REPORT(PLINK_POPGEN.out.files.collect())
}
