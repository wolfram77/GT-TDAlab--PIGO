#!/usr/bin/env bash
src="GT-TDAlab--PIGO"
out="$HOME/Logs/$src$1.log"
ulimit -s unlimited
printf "" > "$out"


# Download program, PIGO
if [[ "$DOWNLOAD" != "0" ]]; then
  rm -rf $src
  git clone https://github.com/wolfram77/$src
  cd $src
fi

# Fixed config
: "${MAX_THREADS:=64}"
: "${REPEAT_METHOD:=1}"
# Define macros (dont forget to add here)
DEFINES=(""
"-DMAX_THREADS=$MAX_THREADS"
"-DREPEAT_METHOD=$REPEAT_METHOD"
)

# Run
g++ ${DEFINES[*]} -std=c++17 -O3 -fopenmp test-pigo.cxx
perform-all() {
# stdbuf --output=L ./a.out ~/Data/web-Stanford.mtx   0 0 2>&1 | tee -a "$out"
stdbuf --output=L ./a.out ~/Data/indochina-2004.mtx  0 0 2>&1 | tee -a "$out"
stdbuf --output=L ./a.out ~/Data/uk-2002.mtx         0 0 2>&1 | tee -a "$out"
stdbuf --output=L ./a.out ~/Data/arabic-2005.mtx     0 0 2>&1 | tee -a "$out"
stdbuf --output=L ./a.out ~/Data/uk-2005.mtx         0 0 2>&1 | tee -a "$out"
stdbuf --output=L ./a.out ~/Data/webbase-2001.mtx    0 0 2>&1 | tee -a "$out"
stdbuf --output=L ./a.out ~/Data/it-2004.mtx         0 0 2>&1 | tee -a "$out"
stdbuf --output=L ./a.out ~/Data/sk-2005.mtx         0 0 2>&1 | tee -a "$out"
stdbuf --output=L ./a.out ~/Data/com-LiveJournal.mtx 1 0 2>&1 | tee -a "$out"
stdbuf --output=L ./a.out ~/Data/com-Orkut.mtx       1 0 2>&1 | tee -a "$out"
stdbuf --output=L ./a.out ~/Data/asia_osm.mtx        1 0 2>&1 | tee -a "$out"
stdbuf --output=L ./a.out ~/Data/europe_osm.mtx      1 0 2>&1 | tee -a "$out"
stdbuf --output=L ./a.out ~/Data/kmer_A2a.mtx        1 0 2>&1 | tee -a "$out"
stdbuf --output=L ./a.out ~/Data/kmer_V1r.mtx        1 0 2>&1 | tee -a "$out"
}
perform-all
perform-all
perform-all
perform-all
perform-all
