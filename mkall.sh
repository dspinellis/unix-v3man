#!/bin/sh
#
# Typeset the complete Unix Programmer's Manual
#
# Diomidis Spinellis, November 2017
#


# Nroff to Postscript via enscript(1)
psnroff()
{
  nroff -Tascii "$@" -P-c | enscript --margins=75 -l -p-
}

{
  # Typeset the front matter
  # No attempt is made to recreate the table of contents and index
  (cd man0 && psnroff -me aa intro basinf toc)

  # Typeset the individual manual pages
  for s in man[1-8] ; do
    for f in $s/* ; do
      psnroff man0/aam $f
    done
  done
} |
# Convert all the Postscript output into PDF
gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -sOutputFile=v3man.pdf - pdfmarks
