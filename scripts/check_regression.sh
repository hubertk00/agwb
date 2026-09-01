#!/usr/bin/env bash
#
# check_regression.sh - test regresyjny generatora AGWB (golden files)
#
# Dla kazdego zarejestrowanego przypadku testowego uruchamia generator
# do katalogu tymczasowego i porownuje wynik z zapisana referencja
# w golden/<nazwa>/.
#
#   ./scripts/check_regression.sh            # sprawdz (uzyj przed commitem)
#   ./scripts/check_regression.sh --update   # nadpisz referencje (SWIADOMIE!)
#   ./scripts/check_regression.sh --keep     # nie kasuj katalogu tymczasowego
#   ./scripts/check_regression.sh -v         # pokaz pelny diff
#
# Kod wyjscia: 0 = brak roznic, 1 = wykryto regresje, 2 = blad generatora.

set -u -o pipefail

# --- lokalizacja repozytorium (skrypt dziala z dowolnego katalogu) -----------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
GENERATOR="${REPO_ROOT}/src/addr_gen_wb.py"
GOLDEN_ROOT="${REPO_ROOT}/golden"

# --- rejestr przypadkow testowych: "nazwa|sciezka/do/pliku.xml" --------------
# Dopisujesz tu kazdy nowy przyklad, ktory ma byc pilnowany przez regresje.
CASES=(
  "test|tests/test/example1.xml"
  "test_ao|tests/test_ao/example1.xml"
  "test_aoai|tests/test_aoai/example1.xml"
)

# --- parsowanie argumentow --------------------------------------------------
MODE="check"; KEEP=0; VERBOSE=0
for arg in "$@"; do
  case "$arg" in
    --update|-u)  MODE="update" ;;
    --keep|-k)    KEEP=1 ;;
    --verbose|-v) VERBOSE=1 ;;
    --help|-h)    sed -n '2,16p' "${BASH_SOURCE[0]}"; exit 0 ;;
    *) echo "Nieznany argument: $arg (uzyj --help)"; exit 2 ;;
  esac
done

# --- kolory (tylko gdy terminal) --------------------------------------------
if [ -t 1 ]; then
  RED=$'\e[31m'; GREEN=$'\e[32m'; YELLOW=$'\e[33m'; BOLD=$'\e[1m'; OFF=$'\e[0m'
else
  RED=""; GREEN=""; YELLOW=""; BOLD=""; OFF=""
fi

command -v python3 >/dev/null || { echo "Brak python3 w PATH"; exit 2; }
[ -f "$GENERATOR" ]           || { echo "Nie znaleziono $GENERATOR"; exit 2; }

TMP_ROOT="$(mktemp -d /tmp/agwb_regr.XXXXXX)"
cleanup() { [ "$KEEP" -eq 1 ] && echo "Katalog roboczy: $TMP_ROOT" || rm -rf "$TMP_ROOT"; }
trap cleanup EXIT

# --- generacja wszystkich targetow dla jednego XML --------------------------
# WAZNE: sciezki wyjsciowe sa RELATYWNE i zawsze takie same, bo trafiaja
# do pliku .core generowanego przez --fusesoc. Absolutne sciezki
# psulyby porownanie miedzy maszynami.
generate_case() {
  local xml_abs="$1" out_dir="$2" log="$3"
  mkdir -p "$out_dir"
  ( cd "$out_dir" && python3 "$GENERATOR" \
        --infile   "$xml_abs" \
        --hdl      ./vhdl     \
        --header   ./c        \
        --pythondca ./python  \
        --ipbus    ./ipbus    \
        --amapxml  ./amap     \
        --fs       ./forth    \
        --html     ./html     \
        --fusesoc ) > "$log" 2>&1
}

# --- petla po przypadkach ---------------------------------------------------
fail=0; run=0
printf '%s\n' "${BOLD}AGWB - test regresyjny generatora${OFF}"
printf '%s\n' "repozytorium: $REPO_ROOT"
[ "$MODE" = "update" ] && printf '%s\n' "${YELLOW}TRYB AKTUALIZACJI - referencje zostana nadpisane${OFF}"
echo

for entry in "${CASES[@]}"; do
  name="${entry%%|*}"
  xml_rel="${entry##*|}"
  xml_abs="${REPO_ROOT}/${xml_rel}"
  run=$((run + 1))

  if [ ! -f "$xml_abs" ]; then
    printf '  %-12s %sPOMINIETY%s (brak %s)\n' "$name" "$YELLOW" "$OFF" "$xml_rel"
    continue
  fi

  out_dir="${TMP_ROOT}/${name}"
  log="${TMP_ROOT}/${name}.log"

  if ! generate_case "$xml_abs" "$out_dir" "$log"; then
    printf '  %-12s %sBLAD GENERATORA%s\n' "$name" "$RED" "$OFF"
    sed 's/^/      /' "$log" | tail -20
    fail=$((fail + 1))
    continue
  fi

  golden_dir="${GOLDEN_ROOT}/${name}"

  if [ "$MODE" = "update" ]; then
    rm -rf "$golden_dir"
    mkdir -p "$(dirname "$golden_dir")"
    cp -r "$out_dir" "$golden_dir"
    printf '  %-12s %sZAKTUALIZOWANY%s\n' "$name" "$YELLOW" "$OFF"
    continue
  fi

  if [ ! -d "$golden_dir" ]; then
    printf '  %-12s %sBRAK REFERENCJI%s -> uruchom --update\n' "$name" "$YELLOW" "$OFF"
    fail=$((fail + 1))
    continue
  fi

  # --exclude __pycache__ : artefakty interpretera, nie wynik generatora
  if diff_out="$(diff -r --exclude=__pycache__ "$golden_dir" "$out_dir" 2>&1)"; then
    printf '  %-12s %sOK%s\n' "$name" "$GREEN" "$OFF"
  else
    # skroc sciezki w diffie do postaci czytelnej
    diff_out="$(printf '%s\n' "$diff_out" \
        | sed -e "s#${golden_dir}#REF#g" -e "s#${out_dir}#NOWY#g" \
              -e "s#^diff -r '--exclude=__pycache__' #diff #")"
    changed="$(printf '%s\n' "$diff_out" | grep -cE '^(diff|Only in)')"
    printf '  %-12s %sROZNICE (%s)%s\n' "$name" "$RED" "$changed" "$OFF"
    if [ "$VERBOSE" -eq 1 ]; then
      printf '%s\n' "$diff_out" | sed 's/^/      /'
    else
      printf '%s\n' "$diff_out" | grep -E '^(diff|Only in)' | sed 's/^/      /' | head -20
      printf '      %s(pelny diff: --verbose)%s\n' "$YELLOW" "$OFF"
    fi
    fail=$((fail + 1))
  fi
done

echo
if [ "$MODE" = "update" ]; then
  printf '%s\n' "${YELLOW}Referencje zaktualizowane. Sprawdz 'git diff golden/' PRZED commitem!${OFF}"
  exit 0
fi
if [ "$fail" -eq 0 ]; then
  printf '%s\n' "${GREEN}${BOLD}Wszystkie przypadki OK (${run}).${OFF}"
  exit 0
fi
printf '%s\n' "${RED}${BOLD}Wykryto regresje w ${fail} z ${run} przypadkow.${OFF}"
exit 1
