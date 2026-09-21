###bioinformatic processing of the reads

###I left the yml file for creating the conda environment with the tools

###Merge Forward und Reverse Sequences

ls *fastq.gz | awk '{print "pear -v 50 -q 20 -j 15 -f "$0" -r "$0" -o "$0}' | grep _R2_ | sed 's/_R2_/_R1_/1' | sed -r 's/_S[0-9]{1,3}_L001_R2_001.fastq.gz//2' > pear.sh  

chmod u+x pear.sh  

./pear.sh		

###quality filtering

ls *assembled.fastq | awk '{print "usearch -fastq_filter "$0" -fastaout "$0" -relabel OTU -fastq_maxee 1"}' | sed 's/assembled.fastq/fasta/2' > fastq.sh

chmod u+x fastq.sh	# make script executable (see above)
./fastq.sh		# run script

###remove newlines

for file in *fasta; do awk '/^>/ { print (NR==1 ? "" : RS) $0; next } { printf "%s", $0 } END { printf RS }' $file > $(basename $file .fasta)"_nonl.fasta" ; done 

####trim the primers and get right length

###for all the in-field data (2024 and 2025) and single beetles from the in-vitro experiment:

grep -E ^CTTCGTTGTTTCACTCTATGC.*TGTTATGGGTATGCAGTTATTTGG$ *_nonl.fasta | sed -r 's/:[A-Z]{21}/\t/' | sed -r 's/[A-Z]{24}$//' | awk 'length($2)==154{print ">"$1"\n"$2}' > ref.fas

###for the leaves in the in-vitro experiment:

grep -E ^CTTTTCGATTGCTAAGAGTGTTCA.*TGTTATGGGTATGCAGTTATTTGG$ *_nonl.fasta | sed -r 's/:[A-Z]{24}/\t/' | sed -r 's/[A-Z]{24}$//' | awk 'length($2)==112{print ">"$1"\n"$2}' > ref2.fas

###dereplicating

usearch -fastx_uniques ref.fas -fastaout ref.derep -sizeout

usearch -fastx_uniques ref2.fas -fastaout ref2.derep -sizeout

###get zOTU sequences

usearch -unoise3 ref.derep -zotus ref.zOTU.fas

usearch -unoise3 ref2.derep -zotus ref2.zOTU.fas

###adjusting sample names

sed -i 's/Zotu/OTU/g' ref.zOTU.fas	

sed -i 's/Zotu/OTU/g' ref2.zOTU.fas	

sed -i '/^>/s/-/_/g' ref.fas	

sed -i '/^>/s/-/_/g' ref2.fas	

###OTU table

usearch -otutab ref.fas -zotus ref.zOTU.fas -otutabout ref.Tab.txt	

usearch -otutab ref2.fas -zotus ref2.zOTU.fas -otutabout ref2.Tab.txt	
