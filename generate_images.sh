#!/bin/sh
if ! mkdir -p images; then
	echo 'Need to create directory images for the cleaned PDF files!'
	exit 1
fi
if [ ! -d images ]; then
	echo 'Needed directory images does not exist!'
	exit 1
fi



num=1
for inputfile in papers/*.pdf; do
	filename=$(basename "${inputfile}" .pdf)
	finalfile="images/${num}.pdf"
	tmpfile="images/${num}.tmp.pdf"
	if [ -r "${finalfile}" ]; then
		num=$(expr ${num} + 1)
		continue
	fi	

	echo "Converting $inputfile to $finalfile ..."
	gs  -sDEVICE=pdfwrite -dCompatibilityLevel='1.5' -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -dFirstPage=1 -dLastPage=1 -sPAPERSIZE=a4 \
		-sOutputFile="${tmpfile}" "${inputfile}"
	pdfjam --preamble '\pdfinclusioncopyfonts=1' --outfile "${finalfile}" --paper a4paper "${tmpfile}"
	rm "${tmpfile}"
	num=$(expr ${num} + 1)
done


if [ "$1" = "--random" ]; then
	num=1
	for perm in $(shuf -i 1-16 -n 16); do
		[ "$perm" -eq "$num" ] && continue
		mv "images/${num}.pdf" "images/${num}.tmp.pdf"
		mv "images/${perm}.pdf" "images/${num}.pdf"
		mv "images/${num}.tmp.pdf" "images/${perm}.pdf"
		num=$(expr ${num} + 1)
	done
fi
