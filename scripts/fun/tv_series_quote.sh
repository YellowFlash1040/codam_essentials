#!/bin/bash

URL='https://quotes.alakhpc.com/quotes'
FIELD='text'

clear; curl -s $URL | jq -r ".$FIELD" | cowsay -f stegosaurus
