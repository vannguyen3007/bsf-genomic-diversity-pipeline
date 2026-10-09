#!/usr/bin/env python3
import html, pathlib, sys
root=pathlib.Path(sys.argv[1]); output=pathlib.Path(sys.argv[2])
patterns={'Allele frequencies':'*.afreq','Heterozygosity':'*.het','PCA eigenvectors':'*.eigenvec','Kinship':'*.kin0','ROH (optional)':'*.hom'}
parts=['<html><head><meta charset="utf-8"><title>BSF genomic monitoring</title><style>body{font:16px Arial;max-width:960px;margin:40px auto;color:#243047}section{padding:18px;border:1px solid #ddd;border-radius:12px;margin:15px 0}pre{overflow:auto;background:#f5f7fa;padding:12px}h1{color:#294f83}</style></head><body><h1>BSF genomic diversity and inbreeding</h1><p>Exploratory report. Interpret results in light of cohort size, sequencing depth, ascertainment, and reference quality.</p>']
for title,pattern in patterns.items():
 matches=list(root.glob(pattern));parts.append('<section><h2>'+html.escape(title)+'</h2>')
 if matches:
  p=matches[0]; lines=p.read_text(errors='replace').splitlines();parts.append('<p>Output: '+html.escape(p.name)+'; '+str(max(0,len(lines)-1))+' data rows.</p><pre>'+html.escape('\n'.join(lines[:7]))+'</pre>')
 else:parts.append('<p>Not available in this run.</p>')
 parts.append('</section>')
parts.append('<p><strong>Interpretation:</strong> PLINK heterozygosity F is not automatically population FIS. ROH requires adequate marker density and appropriate chromosome/threshold settings. PCA and kinship depend on marker filtering and sample composition.</p></body></html>')
output.write_text('\n'.join(parts))
