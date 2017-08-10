#!/bin/bash

function usage
{
	printf "colorbackgroundpdf -- color all the pages of a pdf\n\n"
	printf "Usage:\ncolorbackgroundpdf input.pdf color output.pdf\n\n"
	printf "Dependencies:\n"
	printf "CAM-PDF (cpanp install CAM-PDF)\n"
	printf "perl\n"
	printf "setpdfbackground.pl\n\n"
}

if [ "$#" -ne 3 ]; then
	usage
	exit
fi

numberOfPages=$(pdftk $1 dump_data | grep NumberOfPages | awk '{print $2}')

perl setpdfbackground.pl $1 1 $2 $3

if [ "$numberOfPages" -gt 1 ]; then
	for (( i=2; i<=$numberOfPages; i++ ))
	do
		perl setpdfbackground.pl $3 $i $2 $3
	done
fi
