# Limitations and analysis gates
1. Public PRJNA1256126 is large; development should use a balanced subset before full-scale execution.
2. Inspect coverage before relying on hard genotype calls. Low-depth samples may require genotype-likelihood methods.
3. Population FIS requires meaningful population labels and adequate sample sizes.
4. PCA/kinship use LD-pruned variants.
5. ROH thresholds are sensitive to SNP density, depth and parameter choices and require sensitivity analysis.
6. Example/simulated figures are never biological evidence.
