#!/bin/bash

set -e -x -o pipefail

pwd
ls
ls /
env | sort
compgen -v | sort | pr -3t

DX_ROOT_DIR=/home/dnanexus
INPUT_DIR="$DX_ROOT_DIR"/in
OUTPUT_DIR="$DX_ROOT_DIR"/out
RESOURCES_DIR="$DX_ROOT_DIR"/resources

echo vcf_in=$vcf_in
echo vcf_in_name=$vcf_in_name
echo vcf_in_path=$vcf_in_path
echo vcf_in_prefix=$vcf_in_prefix
echo failure_probability=$failure_probability


main () {
	docker load -i /vcf-digester.tar.gz

	dx-download-all-inputs		# => $INPUT_DIR/
	ls -R "$INPUT_DIR"
	mkdir -p "$OUTPUT_DIR"

	tabix "$vcf_in_path"

	mkdir -p "$OUTPUT_DIR/vcf_out"
	docker run -v "$DX_ROOT_DIR:$DX_ROOT_DIR" reece/vcf-digester ./vcf-digester "$vcf_in_path" -f "$failure_probability" -o "$OUTPUT_DIR/vcf_out/$vcf_in_prefix.digest.vcf.gz"

	ls -R "$OUTPUT_DIR"

	dx-upload-all-outputs
}
