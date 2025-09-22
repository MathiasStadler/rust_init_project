#! /bin/bash
# shellcheck shell=bash
# shellcheck disable=SC2039  # local is non-POSIX

arr=("first" "second" "third" "four" "five")

for item in "${arr[@]}"; do
    echo "$item"
done

# focus/cursor inside windows
# code runner [STRG] + [ALT] + [N]

# german - direnv ist eine Erweiterung für Ihre Shell. 
# Es erweitert bestehende Shells um eine neue Funktion,
# die Umgebungsvariablen abhängig vom aktuellen 
# Verzeichnis laden und entladen kann.
