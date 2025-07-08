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
# define $guard

class $class
{
  private:
    // Properties
	// Methods
	void _copyFrom(const $class& other);
  public:
    $class();
    $class(const $class &other);
	$class &operator=(const $class &other);
    ~$class();
};

#endif
EOF

  # .cpp content
  cat > "$dir/$class.cpp" <<EOF
#include "$class.hpp"

// Default constructor
$class::$class()
{
    
}

void $class::_copyFrom(const $class& other)
{
    
}

// Copy constructor
$class::$class(const $class &other)
{
    
}

// Copy assignment operator
$class &${class}::operator=(const $class &other)
{
    if (this != &other)
	{
        
    }
    return *this;
}

// Destructor
$class::~$class()
{
    
}
EOF

  echo "Created $class ✅"
done
