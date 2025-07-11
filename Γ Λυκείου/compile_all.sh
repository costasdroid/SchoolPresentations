#!/bin/bash
# Compile all .tex files in the current folder that begin with a number, using xelatex (twice for references)

for file in [0-9]*.tex; do
  if [ -f "$file" ]; then
    echo "Compiling $file (1st pass)..."
    xelatex -interaction=nonstopmode "$file"
    echo "Compiling $file (2nd pass)..."
    xelatex -interaction=nonstopmode "$file"
  fi
done

echo "Cleaning up auxiliary files..."
rm -f *.aux *.log *.out *.toc *.nav *.snm *.synctex.gz *.fdb_latexmk *.fls *.xdv
