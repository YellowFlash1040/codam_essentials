#!/bin/bash
source ~/.bashrc

CURRENT_DIR="$PWD"
OUTPUT_DIR="$CURRENT_DIR/output"
mkdir -p "$OUTPUT_DIR"

for FRAME in "$CURRENT_DIR"/*.png; do
    base_filename="$(basename "$FRAME" .png)"
	echo $base_filename
	magick $FRAME -flop "$OUTPUT_DIR/${base_filename}.png"
done