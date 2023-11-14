#!/bin/bash

# Funzione per eseguire un comando e inviare una notifica
run_test() {
  command=$1
  description=$2

  echo "Esecution of: description"
  $command
  status=$?

  if [ $status -eq 0 ]; then
    notify-send "Completed" "$description"
  else
    notify-send "Failed" "$description"
  fi

  return $status
}

# Esecuzione dei test
# run_test "sysbench cpu --threads=6 --time=30 run" "CPU"
run_test "sysbench memory --time=30 --memory-block-size=2G --threads=1 --memory-oper=write run" "RAM write"
run_test "sysbench memory --time=30 --memory-block-size=2G --threads=1 --memory-oper=read run" "RAM read"
# run_test "sysbench --test=fileio --file-total-size=50G prepare" "diskIO: setup"
# run_test "sysbench --test=fileio --file-total-size=50G --file-test-mode=rndrw run" "diskIO: run"
