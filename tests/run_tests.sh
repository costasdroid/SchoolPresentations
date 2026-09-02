#!/usr/bin/env bash
# tests/run_tests.sh — parallel LaTeX error checker for SchoolPresentations
#
# Compiles every .tex in draftmode (single pass, no PDF) using multiple workers.
# Reports:
#   ! — hard LaTeX errors
#   ~ — missing/wrong characters, encoding, font issues
#
# Usage:
#   ./tests/run_tests.sh                       # lualatex, nproc workers
#   LATEX_ENGINE=xelatex ./tests/run_tests.sh
#   JOBS=4 ./tests/run_tests.sh                # limit parallelism

set -o pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PRES_DIR="$(realpath "$SCRIPT_DIR/../../SchoolPresentations")"
ENGINE="${LATEX_ENGINE:-lualatex}"
MAX_JOBS="${JOBS:-$(nproc)}"
WORK_DIR="$(mktemp -d)"
trap 'rm -rf "$WORK_DIR"' EXIT

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BOLD='\033[1m'; NC='\033[0m'

if ! command -v "$ENGINE" &>/dev/null; then
  printf "ERROR: '%s' not found. Set LATEX_ENGINE to override.\n" "$ENGINE" >&2
  exit 1
fi

# Worker: compile one .tex, write result to WORK_DIR/<idx>
check_file() {
  local texfile="$1" idx="$2"
  local dir base rel logfile out
  dir="$(dirname "$texfile")"
  base="$(basename "${texfile%.tex}")"
  rel="${texfile#"$PRES_DIR/"}"
  logfile="$dir/$base.log"
  out="$WORK_DIR/$(printf '%06d' "$idx")"

  # Single-pass draftmode — no PDF produced
  (cd "$dir" && "$ENGINE" \
    --draftmode \
    --interaction=nonstopmode \
    "$base.tex" > /dev/null 2>&1) || true

  local status=OK msgs=""
  if [[ ! -f "$logfile" ]]; then
    status=FAIL
    msgs="! No log produced — engine failed to start"
  else
    local m
    # Hard LaTeX errors
    m="$(grep "^!" "$logfile" 2>/dev/null | sort -u || true)"
    [[ -n "$m" ]] && { status=FAIL; msgs+="$m"$'\n'; }
    # Missing character — codepoint not in font (will render as blank or wrong glyph)
    m="$(grep "Missing character:" "$logfile" 2>/dev/null | sort -u || true)"
    [[ -n "$m" ]] && { status=FAIL; msgs+="$m"$'\n'; }
    # Encoding / UTF-8 / font substitution issues
    m="$(grep -i \
      "invalid.*utf\|bad character\|cannot be encoded\|font.*not found\|Font.*substituted\|Package fontspec Warning" \
      "$logfile" 2>/dev/null | sort -u || true)"
    [[ -n "$m" ]] && { status=FAIL; msgs+="$m"$'\n'; }
  fi

  { printf '%s\n%s\n' "$status" "$rel"; [[ -n "$msgs" ]] && printf '%s' "$msgs"; } > "$out"
  rm -f "$dir/$base."{aux,log,nav,snm,toc,out,vrb,fls,fdb_latexmk}
}

# Collect all .tex files
mapfile -d '' -t TEXFILES < <(find "$PRES_DIR" -name "*.tex" -not -path "*/.*" -print0 | sort -z)
TOTAL="${#TEXFILES[@]}"

printf "${BOLD}SchoolPresentations — LaTeX Test Runner${NC}\n"
printf "Engine  : %s\n" "$ENGINE"
printf "Files   : %d\n" "$TOTAL"
printf "Workers : %d\n\n" "$MAX_JOBS"
printf "Compiling "

# Parallel execution: sliding window of MAX_JOBS
idx=0
running=0
for texfile in "${TEXFILES[@]}"; do
  check_file "$texfile" "$idx" &
  idx=$((idx + 1))
  running=$((running + 1))
  printf "."
  if [[ $running -ge $MAX_JOBS ]]; then
    wait   # wait for current batch before spawning more
    running=0
  fi
done
wait
printf " done\n\n"

# Collect and display results in submission order
ERRORS=0
FAILED=()

while IFS= read -r fname; do
  result_file="$WORK_DIR/$fname"
  status="$(sed -n '1p' "$result_file")"
  rel="$(sed -n '2p' "$result_file")"
  msgs="$(sed -n '3,$p' "$result_file")"

  printf "  %-68s" "$rel"
  if [[ "$status" == OK ]]; then
    printf "${GREEN}OK${NC}\n"
  else
    printf "${RED}FAIL${NC}\n"
    if [[ -n "$msgs" ]]; then
      while IFS= read -r line; do
        case "$line" in
          "!"*) printf "      ${RED}%s${NC}\n"    "$line" ;;
          *)    printf "      ${YELLOW}%s${NC}\n"  "$line" ;;
        esac
      done <<< "$msgs"
    fi
    ERRORS=$((ERRORS + 1))
    FAILED+=("$rel")
  fi
done < <(ls "$WORK_DIR" | sort)

printf "\n%s\n" "$(printf '━%.0s' {1..72})"
printf "Checked : %d\n" "$TOTAL"

if [[ $ERRORS -eq 0 ]]; then
  printf "Result  : ${GREEN}${BOLD}All passed${NC}\n"
  exit 0
else
  printf "Failed  : ${RED}${BOLD}%d${NC}\n\n" "$ERRORS"
  for f in "${FAILED[@]}"; do printf "  • %s\n" "$f"; done
  exit 1
fi
