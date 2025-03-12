#!/bin/bash
source ~/.bashrc

CURRENT_DIR="$PWD"
OUTPUT_DIR="$CURRENT_DIR/output"
mkdir -p "$OUTPUT_DIR"

for FRAME in "$CURRENT_DIR"/*.png; do
    # Extract the base filename (without path or extension)
    base_filename="$(basename "$FRAME" .png)"
    # Extract the filepath without extension
    filename="${FRAME%.png}"
    
    upscale "$FRAME"
    xpm "${filename}_upscaled.png"
    rm "${filename}_upscaled.png"
    mv "${filename}_upscaled.xpm" "$OUTPUT_DIR/${base_filename}.xpm"
done