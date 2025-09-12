#!/bin/bash

URL='https://api.animechan.io/v1/quotes/random'

clear; curl -s $URL | jq -r '.data | "\(.content)\n\n\(.character.name)\n(Anime: \(.anime.name))"' | cowsay -f stegosaurus
