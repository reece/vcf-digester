# VCF Digester

rewrites VCF file with digest-based location ids and allele ids


The goal is simply to experiment with building a docker image that can
be run at DNANexus.  The script rewrites a single input VCF to replace
the id field with a location digest, and to add a new AD (yes, I know)
info field contained allele digests for the ref and alts.


## Development

```
$ python3 -m venv venv
$ source venv/bin/activate
$ pip install -r requirements.txt 
$ ./vcf-digester tests/data.vcf
```


## To build a docker image

```
$ docker build -t reece/vcf-digester .
$ docker push reece/vcf-digester
$ docker run -v $PWD/tests:/tests reece/vcf-digester ./vcf-digester tests/data.vcf
```


## Example

(The following example uses the entrypoint defined in Dockerfile.)

```
$ docker run -v $PWD/tests:/tests reece/vcf-digester tests/data.vcf
2021-03-04 01:00:41 c830dee206c1 root[1] WARNING I will randomly die with probabilty 0.2
##fileformat=VCFv4.2
##FILTER=<ID=PASS,Description="All filters passed">
##fileDate=20090805
##source=myImputationProgramV3.1
##reference=file:///seq/references/1000GenomesPilot-NCBI36.fasta
##contig=<ID=20,length=62435964,assembly=B36,md5=f126cdf8a6e0c7f379d618ff66beb2da,species="Homo sapiens",taxonomy=x>
##phasing=partial
##INFO=<ID=NS,Number=1,Type=Integer,Description="Number of Samples With Data">
##INFO=<ID=DP,Number=1,Type=Integer,Description="Total Depth">
##INFO=<ID=AF,Number=A,Type=Float,Description="Allele Frequency">
##INFO=<ID=AA,Number=1,Type=String,Description="Ancestral Allele">
##INFO=<ID=DB,Number=0,Type=Flag,Description="dbSNP membership, build 129">
##INFO=<ID=H2,Number=0,Type=Flag,Description="HapMap2 membership">
##FILTER=<ID=q10,Description="Quality below 10">
##FILTER=<ID=s50,Description="Less than 50% of samples have data">
##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">
##FORMAT=<ID=GQ,Number=1,Type=Integer,Description="Genotype Quality">
##FORMAT=<ID=DP,Number=1,Type=Integer,Description="Read Depth">
##FORMAT=<ID=HQ,Number=2,Type=Integer,Description="Haplotype Quality">
##INFO=<ID=AD,Number=1,Type=String,Description="allele digests">
#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	NA00001	NA00002	NA00003
20	14370	199ff976	G	A	29	PASS	NS=3;DP=14;AF=0.5;DB;H2;AD=1f956a97,19d33e80	GT:GQ:DP:HQ	0|0:48:1:51,51	1|0:48:8:51,51	1/1:43:5:.,.
20	17330	2f4712eb	T	A	3	q10	NS=3;DP=11;AF=0.017;AD=93fb3424,e2cc0b86	GT:GQ:DP:HQ	0|0:49:3:58,50	0|1:3:5:65,3	0/0:41:3:.
20	1110696	46fb5f10	A	G,T	67	PASS	NS=2;DP=10;AF=0.333,0.667;AA=T;DB;AD=eba203b0,9fc2d107,13a57ad5	GT:GQ:DP:HQ	1|2:21:6:23,27	2|1:2:0:18,2	2/2:35:4:.
20	1230237	ff4dbc85	T	.	47	PASS	NS=3;DP=13;AA=T;AD=d5d80c72	GT:GQ:DP:HQ	0|0:54:7:56,60	0|0:48:4:51,51	0/0:61:2:.
20	1234567	19d03bb1	GTC	G,GTCT	50	PASS	NS=3;DP=9;AA=G;AD=5619a731,565b8d00,0ba8cbae	GT:GQ:DP	0/1:35:4	0/2:17:2	1/1:40:3
```
