#!/bin/bash
# Builds index.html (the public GitHub Pages copy) from model.html (the working file).
cd "$(dirname "$0")"
{
  printf '%s\n' '<!doctype html>' '<html lang="en-AU">' '<head>' '<meta charset="utf-8">' \
    '<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">' \
    '<meta name="robots" content="noindex, nofollow">' \
    '<style>*,*::before,*::after{box-sizing:border-box}body{margin:0;font:14px system-ui,sans-serif}</style>'
  cat model.html
  printf '\n</html>\n'
} > index.html
