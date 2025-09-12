#!/bin/bash

# Exit if no arguments are passed
if [ $# -eq 0 ]; then
  echo "Usage: $0 ClassName1 [ClassName2 ...]"
  exit 1
fi

for class in "$@"; do
  dir="I$class"
  mkdir -p "$dir"

  # Header guard
  guard=$(echo "${class}_HPP" | tr '[:lower:]' '[:upper:]')

  # .hpp content
  cat > "$dir/I$class.hpp" <<EOF
#pragma once

#ifndef $guard
# define $guard

class I$class
{
  public:
    // Destructor
    virtual ~I$class() = default;

    //Methods
    // virtual void method() = 0;
};

#endif
EOF

  echo "Created $class ✅"
done
