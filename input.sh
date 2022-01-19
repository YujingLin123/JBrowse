####产生JBrowse的基因参考文件
bgzip sars-cov2.fa
samtools faidx sars-cov2.fa.gz

####产生JBrowse的注释文件
gt gff3 -sortlines -tidy ITAG4.0_gene_models.gff > ITAG4.0_gene_models.sorted.gff
bgzip ITAG4.0_gene_models.sorted.gff
tabix -p gff ITAG4.0_gene_models.sorted.gff.gz
