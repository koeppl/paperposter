# paperposter

A `pdflatex` scaffold for creating a DIN A0 poster from the first pages of 16 papers, in 4x4 layouted.

## Getting Started

Add 16 pdf files in the folder `papers` and run the shell script `generate_images.sh`,
which generates PDF-image files in the folder `images`. The PDF files in `images` are enumerated, starting with `1.pdf`.
Subsequently run `pdflatex poster.tex` to generate a poster from the image files `images/%d.pdf`.

### Prerequisites

Needs `pdfjam` to embed fonts and `gs` to cut the first page of an article.

## Additional Features

Run `generate_images.sh --random` to generate a random enumeration of the 16 PDF images in the `images` folder.

