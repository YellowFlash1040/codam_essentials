#!/bin/bash

URL='https://quoteapi.pythonanywhere.com/random'

# clear; curl -s $URL | jq -r '.Quotes[0] | "\(.quote)\n\n\((.author | if . == "Null" then "Anonym" else . end))"' | cowsay -f stegosaurus


clear
curl -s $URL | jq -r '
  .Quotes[0] | 
  if .author == null or .author == "Null" or .author == "" 
  then "\(.quote)" 
  else "\(.quote)\n\n\(.author)" 
  end
' | cowsay -f stegosaurus
