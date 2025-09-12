#!/bin/bash

URL='https://animotto-api.onrender.com/api/quotes/random'

clear

curl -s "$URL" | jq -r '"\(.quote)\n\n\(.character)\n(Anime: \(.anime.name))"' | cowsay -f stegosaurus
