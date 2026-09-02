#!/bin/bash

# Φάκελος αποθήκευσης των παραγόμενων PDF
PDF_DIR="output_pdfs"
mkdir -p "$PDF_DIR"

# Λίστα γραμματοσειρών κειμένου προς δοκιμή
FONTS=(
  "Liberation Sans"
  "DejaVu Sans"
  "Calibri"
  "Noto Sans"
  "GFS Neohellenic"
  "FreeSans"
)

LOG_FILE="benchmark_results.log"

echo "=== Έναρξη Benchmark LaTeX Fonts ===" | tee "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

for FONT in "${FONTS[@]}"; do
  SAFE_NAME=$(echo "$FONT" | tr ' ' '_')
  TEMP_TEX="temp_${SAFE_NAME}.tex"

  echo "--------------------------------------------------" | tee -a "$LOG_FILE"
  echo "Δοκιμή γραμματοσειράς: $FONT" | tee -a "$LOG_FILE"
  
  # 1. Δημιουργία προσωρινού .tex αρχείου με τη συγκεκριμένη γραμματοσειρά
  cat << EOF > "$TEMP_TEX"
\providecommand{\mainfontname}{$FONT}
\input{bench.tex}
EOF

  # 2. Μέτρηση χρόνου εκτέλεσης
  START_TIME=$(date +%s.%N)
  
  # Εκτέλεση xelatex (απευθείας χωρίς το overhead/μπερδέματα του latexmk)
  xelatex -interaction=nonstopmode -jobname="bench_${SAFE_NAME}" "$TEMP_TEX" > /dev/null 2>&1
  
  END_TIME=$(date +%s.%N)
  ELAPSED=$(echo "$END_TIME - $START_TIME" | bc)
  
  echo "Χρόνος Compilation: ${ELAPSED} δευτερόλεπτα" | tee -a "$LOG_FILE"
  
  # 3. Έλεγχος αν παρήχθη το PDF
  if [ -f "bench_${SAFE_NAME}.pdf" ]; then
    mv "bench_${SAFE_NAME}.pdf" "$PDF_DIR/"
    echo "Status: Επιτυχία -> Αποθηκεύτηκε ως $PDF_DIR/bench_${SAFE_NAME}.pdf" | tee -a "$LOG_FILE"
  else
    echo "Status: ΑΠΟΤΥΧΙΑ -> Δεν δημιουργήθηκε PDF (Σφάλμα στο LaTeX)" | tee -a "$LOG_FILE"
  fi

  # 4. Απομόνωση Warnings & Missing Characters από το .log
  LOG_NAME="bench_${SAFE_NAME}.log"
  if [ -f "$LOG_NAME" ]; then
    WARNINGS=$(grep -iE "(Missing character:|LaTeX Warning:)" "$LOG_NAME")
    
    if [ -z "$WARNINGS" ]; then
      echo "Warnings: Καμία προειδοποίηση/missing character." | tee -a "$LOG_FILE"
    else
      echo "Warnings / Missing Characters:" | tee -a "$LOG_FILE"
      echo "$WARNINGS" | tee -a "$LOG_FILE"
    fi
  fi

  # 5. Καθαρισμός προσωρινών αρχείων
  rm -f "$TEMP_TEX" "bench_${SAFE_NAME}.aux" "bench_${SAFE_NAME}.log" "bench_${SAFE_NAME}.nav" "bench_${SAFE_NAME}.snm" "bench_${SAFE_NAME}.toc" "bench_${SAFE_NAME}.vrb"

done

echo "--------------------------------------------------" | tee -a "$LOG_FILE"
echo "Το benchmark ολοκληρώθηκε."
echo "Όλα τα PDF βρίσκονται στον φάκελο: $PDF_DIR/"