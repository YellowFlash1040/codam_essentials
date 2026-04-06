#!/bin/bash

# Usage: ./create-component.sh ComponentName

COMPONENT_NAME=$1

if [ -z "$COMPONENT_NAME" ]; then
  echo "Please provide a component name."
  exit 1
fi

# Create directory
mkdir -p "$COMPONENT_NAME"

# Create TSX file
cat <<EOL > "$COMPONENT_NAME/$COMPONENT_NAME.tsx"
import s from "./$COMPONENT_NAME.module.css";

const $COMPONENT_NAME = () => {
  return <></>;
};

export default $COMPONENT_NAME;
EOL

# Create CSS module file
touch "$COMPONENT_NAME/$COMPONENT_NAME.module.css"

echo "Component '$COMPONENT_NAME' created successfully."