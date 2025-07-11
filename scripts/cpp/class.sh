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
// Orthodox canonical from
  public:
    $class();
    $class(const $class& other);
	$class &operator=(const $class& other);
	$class($class&& other);
	$class& operator=($class&& other);
    ~$class();
  private:
	void _copyFrom(const $class& other);

// Class implementation
  private:
    //Properties
	//Methods
  public:
	//Constructors
	//Operators overload
	//Accessors
	//Methods
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
    _copyFrom(other);
}

// Copy assignment operator
$class &${class}::operator=(const $class &other)
{
    if (this != &other)
	{
        _copyFrom(other);
    }
    return (*this);
}

// Move constructor
$class::$class($class&& other)
{
	// Steal new data (from other)
    // Clean up the traces (data in other has to set to null)
}

// Move assignment
$class& $class::operator=($class&& other)
{
	if (this != &other)
	{
		// Free old data (inside this)
		// Steal new data (from other)
		// Clean up the traces (data in other has to set to null)
	}
	return (*this);
}

// Destructor
$class::~$class()
{
    // Free data (allocated with new)
}
EOF

  echo "Created $class ✅"
done
