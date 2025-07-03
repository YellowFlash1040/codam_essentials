#!/bin/bash

# Exit if no arguments are passed
if [ $# -eq 0 ]; then
  echo "Usage: $0 ClassName1 [ClassName2 ...]"
  exit 1
fi

for class in "$@"; do
  dir="$class"
  mkdir -p "$dir"

  # Header guard
  guard=$(echo "${class}_HPP" | tr '[:lower:]' '[:upper:]')

  # .hpp content
  cat > "$dir/$class.hpp" <<EOF
#pragma once

#ifndef $guard
#define $guard

class $class
{
  private:
    // Add member variables here
  public:
    $class();
    $class(const $class &other);
    ~$class();
    $class &operator=(const $class &other);
};

#endif
EOF

  # .cpp content
  cat > "$dir/$class.cpp" <<EOF
#include "$class.hpp"

$class::$class()
{
    // Constructor
}

$class::$class(const $class &other)
{
    // Copy constructor
}

$class::~$class()
{
    // Destructor
}

$class &${class}::operator=(const $class &other)
{
    if (this != &other)
	{
        // Assignment
    }
    return *this;
}
EOF

  echo "Created $class ✅"
done
