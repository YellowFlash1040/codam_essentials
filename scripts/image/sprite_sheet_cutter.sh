# #!/bin/bash

# # Usage: ./process_sprite_sheet.sh input_sprite_sheet.png frame_width frame_height upscale_factor
# # Example: ./process_sprite_sheet.sh IDLE.png 96 96 2

# # Input arguments
# SPRITE_SHEET=$1      # Sprite sheet file (e.g., IDLE.png)
# FRAME_WIDTH=$2       # Width of each frame
# FRAME_HEIGHT=$3      # Height of each frame
# UPSCALE_FACTOR=$4    # Upscale factor (e.g., 2 for 2x)

# # Path to ImageMagick binary
# magick="$HOME/.capt/root/usr/bin/convert-im6.q16"

# # Output directory
# OUTPUT_DIR="processed_frames"
# mkdir -p "$OUTPUT_DIR"

# # Step 1: Cut the sprite sheet into individual frames
# echo "Cutting sprite sheet into frames..."
# $magick "$SPRITE_SHEET" -crop ${FRAME_WIDTH}x${FRAME_HEIGHT} +repage "$OUTPUT_DIR/frame_%03d.png"

# # Step 2: Process each frame
# echo "Processing frames..."
# for FRAME in "$OUTPUT_DIR"/frame_*.png; do
#     # Step 2.1: Crop the frame to its non-transparent content and center it
#     echo "Cropping and centering $FRAME..."
#     $magick "$FRAME" -trim -gravity center -background transparent -extent ${FRAME_WIDTH}x${FRAME_HEIGHT} "$FRAME"

#     # Step 2.2: Upscale the frame
#     echo "Upscaling $FRAME..."
#     UPSCALED_WIDTH=$((FRAME_WIDTH * UPSCALE_FACTOR))
#     UPSCALED_HEIGHT=$((FRAME_HEIGHT * UPSCALE_FACTOR))
#     $magick "$FRAME" -filter point -resize ${UPSCALED_WIDTH}x${UPSCALED_HEIGHT} "$OUTPUT_DIR/upscaled_$(basename "$FRAME")"

#     # Step 2.3: Convert the frame to .xpm format
#     echo "Converting $FRAME to .xpm..."
#     BASENAME=$(basename "$FRAME" .png)
#     $magick "$OUTPUT_DIR/upscaled_$BASENAME.png" "$OUTPUT_DIR/${BASENAME}.xpm"
# done

# echo "Processing complete. Frames saved in $OUTPUT_DIR."


#--------------------------------------------------------------------------------------------
#!/bin/bash

# Usage: ./process_sprite_sheet.sh input_sprite_sheet.png frame_width frame_height upscale_factor
# Example: ./process_sprite_sheet.sh IDLE.png 96 96 2

# Input arguments
SPRITE_SHEET=$1      # Sprite sheet file (e.g., IDLE.png)
FRAME_WIDTH=$2       # Width of each frame
FRAME_HEIGHT=$3      # Height of each frame
UPSCALE_FACTOR=$4    # Upscale factor (e.g., 2 for 2x)
NEW_FRAME_WIDTH=$5
NEW_FRAME_HEIGHT=$6

# Path to ImageMagick binary
magick="$HOME/.capt/root/usr/bin/convert-im6.q16"

# Output directory
OUTPUT_DIR="processed_frames"
mkdir -p "$OUTPUT_DIR"

# Step 1: Cut the sprite sheet into individual frames
#echo "Cutting sprite sheet into frames..."
$magick "$SPRITE_SHEET" -crop ${FRAME_WIDTH}x${FRAME_HEIGHT} +repage "$OUTPUT_DIR/frame_%03d.png"

# Step 2: Process each frame
echo "Processing frames..."
for FRAME in "$OUTPUT_DIR"/frame_*.png; do
    # Step 2.1: Crop the frame to its non-transparent content and center it
    #echo "Cropping and centering $FRAME..."
    $magick "$FRAME" -trim -gravity center -background transparent -extent ${NEW_FRAME_WIDTH}x${NEW_FRAME_HEIGHT} "$FRAME"

    # Step 2.2: Upscale the frame
    #echo "Upscaling $FRAME..."
    BASENAME=$(basename "$FRAME" .png)
    UPSCALED_FRAME="$OUTPUT_DIR/upscaled_${BASENAME}.png"
    UPSCALED_WIDTH=$((NEW_FRAME_WIDTH * UPSCALE_FACTOR))
    UPSCALED_HEIGHT=$((NEW_FRAME_HEIGHT * UPSCALE_FACTOR))
    $magick "$FRAME" -filter point -resize ${UPSCALED_WIDTH}x${UPSCALED_HEIGHT} "$UPSCALED_FRAME"

    $magick "$UPSCALED_FRAME" -gravity center "$UPSCALED_FRAME"

    # Step 2.3: Convert the upscaled frame to .xpm format
    #echo "Converting $UPSCALED_FRAME to .xpm..."
    $magick "$UPSCALED_FRAME" "$OUTPUT_DIR/${BASENAME}.xpm"

    rm -f $FRAME $UPSCALED_FRAME
done

echo "Processing complete. Frames saved in $OUTPUT_DIR."
