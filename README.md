# csfb_edna_pesticide
Supplementary data for: Environmental DNA is an efficient tool for monitoring pesticide resistance mutations in pest insects

Scripts for making the figures and analyses from "Environmental DNA is an efficient tool for monitoring pesticide resistance mutations in pest insects".

We used BASH scripts and shell-based tools for processing the reads. FASTQ files were merged using PEAR (version 0.9.6), with minimum base pair overlap of 50 and minimum quality of 20. USEARCH (version 12.0 beta) was used with a minimum error rate of 1 for converting the FASTQ outputs to FASTA. The primer sequences were trimmed from the FASTA files and sequences of the right amplicon size (154 and 112, which is the sizes of the amplicons without primers for the REF918_fw-sKDR R set and sKDR F-sKDR R set, respectively) were filtered through BASH scripts. After this, we used USEARCH for first dereplicating reads and then clustering them into zero-radius Operational Taxonomic Units (zOTUs); each OTU therefore had at least a nucleotide change compared to other ones. Only zOTUs with at least 8 sequences were retained.

The analyses were run in R (version 4.2.2) inside RStudio (version 2023.12.1), using the package “tidyverse” (version 2.0.0) for data processing and analyses. For making plots, we used “tidyverse”, “ggpmisc” (version 0.6.3) and “patchwork” (version 1.3.2).

See also:

https://zenodo.org/records/22868952
