.DELETE_ON_ERROR:


VERSION:=latest

resources/vcf-digester.tar.gz:
	docker save reece/vcf-digester:${VERSION} | gzip -c >$@
