#!/bin/bash

escape_special_chars() {
    local input="$1"
    # Escape backslashes, double quotes, and other special characters
    input=$(echo "$input" | sed 's/\\/\\\\/g')  # Escape backslashes
    input=$(echo "$input" | sed 's/"/\\"/g')   # Escape double quotes
    input=$(echo "$input" | sed "s/'/\\'/g")    # Escape single quotes
    input=$(echo "$input" | sed 's/\x0/\\0/g')  # Escape null byte
    input=$(echo "$input" | sed 's/\t/\\t/g')   # Escape tab
    input=$(echo "$input" | sed 's/\n/\\n/g')   # Escape newline
    input=$(echo "$input" | sed 's/\r/\\r/g')   # Escape carriage return
    input=$(echo "$input" | sed 's/\x1b/\\e/g') # Escape escape character
    echo "$input"
}

# Check if the user provided a file with the function
if [ -z "$1" ]; then
  echo "Usage: $0 <path_to_code_file>"
  exit 1
fi

# File containing the function
code_file="$1"
snippet_name="$(basename "$code_file")"
# Output snippet file
snippet_file="${snippet_name}.code-snippets"

echo -e "\"Create $1 function\": {
	\"prefix\": \"\",
	\"body\": [" > "$snippet_file"

# Read the file line by line
while IFS= read -r line; do
	line=$(escape_special_chars "$line")
	echo "\"$line\"," >> "$snippet_file"
done < "$1"

echo -e "\t],
	\"description\": \"Creates a $1 function\"
}," >> "$snippet_file"
