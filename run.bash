#! /bin/bash


# build the .vg reference using linear reference

vg construct -r ENSG00000142192.fasta > ENSG00000142192.vg

# if we have variants here, we could add -v xxx.vcf to add these variants to the .vg reference
# `vg construct -r ENSG00000142192.fasta -v xxx.vcf.gz > ENSG00000142192.vg`

# embed transcripts into the reference

vg rna -n ENSG00000142192.gtf -e -r -p  ENSG00000142192.vg > ENSG00000142192_rna.vg

# I don't know the difference beween with parameter '-r' and without parameter '-r'.


# build index for vg

vg index -p -x ENSG00000142192_rna_add_ref_paths.xg -L -g ENSG00000142192_rna_add_ref_paths.gcsa ENSG00000142192_rna_add_ref_paths.vg

vg index -p -x ENSG00000142192_rna.xg -L -g ENSG00000142192_rna.gcsa ENSG00000142192_rna.vg

# cat all transcripts fasta

cat ENST*/ENST*fasta> ENSG00000142192_all_transcripts.fasta

wgsim -d 220 -s 30 -N 5000 -1 150 -2 150 ENSG00000142192_all_transcripts.fasta ENSG00000142192_read1.fastq ENSG00000142192_read2.fastq

# mapping

vg mpmap -x ENSG00000142192_rna_add_ref_paths.xg -g ENSG00000142192_rna_add_ref_paths.gcsa -f ENSG00000142192_read1.fastq -f ENSG00000142192_read2.fastq -N ENSG00000142192 > ENSG00000142192_add_ref_paths.gamp

vg mpmap -x ENSG00000142192_rna.xg -g ENSG00000142192_rna.gcsa -f ENSG00000142192_read1.fastq -f ENSG00000142192_read2.fastq -N ENSG00000142192 > ENSG00000142192.gamp



