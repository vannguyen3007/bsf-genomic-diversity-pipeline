#!/usr/bin/env python3
import csv,sys,os
req={"sample","fastq_1","fastq_2","population","country","source"}
with open(sys.argv[1]) as f:
    rows=list(csv.DictReader(f))
if not rows: raise SystemExit("ERROR: empty sample sheet")
missing=req-set(rows[0])
if missing: raise SystemExit("ERROR missing columns: "+",".join(sorted(missing)))
ids=[r["sample"] for r in rows]
if len(ids)!=len(set(ids)): raise SystemExit("ERROR duplicate sample IDs")
for r in rows:
    if not r["fastq_1"] or not r["fastq_2"]: raise SystemExit(f"ERROR FASTQ path missing for {r['sample']}")
print(f"Validated {len(rows)} samples")
