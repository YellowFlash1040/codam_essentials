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
	void _moveFrom($class&& other);

// Class implementation
  public:
	//Constructors
	//Operators overload
	//Accessors
	//Methods
  private:
    //Properties
	//Methods
  protected:
};

#endif
EOF

  # .cpp content
  cat > "$dir/$class.cpp" <<EOF
#include "$class.hpp"

// -----------------------ORTHODOX CANONICAL FORM-------------------------

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

void $class::_moveFrom($class&& other)
{
	// Steal new data (from other)
	// Clean up the traces (data in other has to set to null)
}

// Move constructor
$class::$class($class&& other)
{
	_moveFrom(std::move(other));
}

// Move assignment operator
$class& $class::operator=($class&& other)
{
	if (this != &other)
	{
		// Free old data (inside this)
		_moveFrom(std::move(other));
	}
	return (*this);
}

// Destructor
$class::~$class()
{
    // Free data (allocated with new)
}

// ---------------------------CONSTRUCTORS-----------------------------

// ---------------------------OPERATORS OVERLOAD------------------------

// ---------------------------ACCESSORS-----------------------------

// ---------------------------METHODS-----------------------------
EOF

  echo "Created $class ✅"
done
