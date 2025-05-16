#!/bin/bash

# Function to create files
create_files() {
    NAME=$1
    HEADER_FILE="${NAME}.h"
    SOURCE_FILE="${NAME}.c"
    HEADER_GUARD=$(echo "$NAME" | tr '[:lower:]' '[:upper:]')_H

    # Create .h file
    if [ ! -f "$HEADER_FILE" ]; then
        echo -e "#ifndef $HEADER_GUARD\n# define $HEADER_GUARD\n\n\n\n#endif" > "$HEADER_FILE"
        echo "Created $HEADER_FILE ✅"
    else
        echo "$HEADER_FILE already exists, skipping."
    fi

    # Create .c file
    if [ ! -f "$SOURCE_FILE" ]; then
        echo -e "#include \"$HEADER_FILE\"\n" > "$SOURCE_FILE"
        echo "Created $SOURCE_FILE ✅"
    else
        echo "$SOURCE_FILE already exists, skipping."
    fi
}

# Check if at least one argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <name1> <name2> ..."
    exit 1
fi

# Loop through all arguments (class names)
for NAME in "$@"; do
    create_files "$NAME"
done
