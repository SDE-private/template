#!/bin/bash

if ! command -v stress &> /dev/null; then
    echo "Error: stress not installed."
    exit 1
fi

# Funzione per eseguire un comando e inviare una notifica
run_test() {
  description=$1
  command=$2

  echo "Esecution of: $description"
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
run_test "CPU" "stress --cpu 4 --timeout 60"
run_test "RAM" "stress --vm 4 --vm-bytes 4092M --timeout 60"
run_test "IO" "stress --io 4 --timeout 60"
