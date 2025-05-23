#!/bin/bash

# Function to create files and add the functions
create_files_with_functions() {
    NAME=$1
	FOLDER="${NAME}"
    HEADER_FILE="${FOLDER}/${NAME}.h"
    SOURCE_FILE="${FOLDER}/${NAME}.c"
    HEADER_GUARD=$(echo "$NAME" | tr '[:lower:]' '[:upper:]')_H

  	mkdir -p "$FOLDER"

    # Create .h file if it doesn't exist
    if [ ! -f "$HEADER_FILE" ]; then
        echo -e "#ifndef $HEADER_GUARD" > "$HEADER_FILE"
        echo -e "# define $HEADER_GUARD" >> "$HEADER_FILE"
        echo -e "" >> "$HEADER_FILE"
        echo -e "# include <stdlib.h>" >> "$HEADER_FILE"
        echo -e "" >> "$HEADER_FILE"
        echo -e "# define ${NAME^^}_INIT_ERR 1" >> "$HEADER_FILE"
        echo -e "" >> "$HEADER_FILE"
        echo -e "typedef struct $NAME" >> "$HEADER_FILE"
        echo -e "{" >> "$HEADER_FILE"
        echo -e "}\tt_$NAME;" >> "$HEADER_FILE"
        echo -e "" >> "$HEADER_FILE"
        echo -e "t_$NAME\t*init_$NAME(void);" >> "$HEADER_FILE"
        echo -e "void\tdestroy_$NAME(t_$NAME **${NAME}_ref);" >> "$HEADER_FILE"
        echo -e "" >> "$HEADER_FILE"
        echo -e "#endif" >> "$HEADER_FILE"

        echo "Created $HEADER_FILE ✅"
    else
        echo "$HEADER_FILE already exists, skipping."
    fi

    # Create .c file if it doesn't exist
    if [ ! -f "$SOURCE_FILE" ]; then
        echo -e "#include \"$HEADER_FILE\"" > "$SOURCE_FILE"
        echo -e "" >> "$SOURCE_FILE"
        echo -e "t_$NAME\t*init_$NAME(void)" >> "$SOURCE_FILE"
        echo -e "{" >> "$SOURCE_FILE"
        echo -e "\tt_$NAME\t*$NAME;" >> "$SOURCE_FILE"
        echo -e "" >> "$SOURCE_FILE"
        echo -e "\t$NAME = (t_$NAME *)malloc(sizeof(t_$NAME));" >> "$SOURCE_FILE"
        echo -e "\tif (!$NAME)" >> "$SOURCE_FILE"
        echo -e "\t\treturn (NULL);" >> "$SOURCE_FILE"
        echo -e "\treturn ($NAME);" >> "$SOURCE_FILE"
        echo -e "}" >> "$SOURCE_FILE"
        echo -e "" >> "$SOURCE_FILE"
        echo -e "void\tdestroy_$NAME(t_$NAME **${NAME}_ref)" >> "$SOURCE_FILE"
        echo -e "{" >> "$SOURCE_FILE"
        echo -e "\tt_$NAME\t*$NAME;" >> "$SOURCE_FILE"
        echo -e "" >> "$SOURCE_FILE"
        echo -e "\tif (!${NAME}_ref || !*${NAME}_ref)" >> "$SOURCE_FILE"
        echo -e "\t\treturn ;" >> "$SOURCE_FILE"
        echo -e "\t$NAME = *${NAME}_ref;" >> "$SOURCE_FILE"
        echo -e "\tfree($NAME);" >> "$SOURCE_FILE"
        echo -e "\t*${NAME}_ref = NULL;" >> "$SOURCE_FILE"
        echo -e "}" >> "$SOURCE_FILE"

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
    create_files_with_functions "$NAME"
done
