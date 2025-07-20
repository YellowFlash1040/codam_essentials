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

#include <utility>

class $class
{
// Construction and destruction
  public:
    $class();
    $class(const $class& other);
	$class& operator=(const $class& other);
	$class($class&& other) noexcept;
	$class& operator=($class&& other) noexcept;
    ~$class();

// Class specific features
  public:
  //Accessors
  //Methods

  protected:
  //Properties
  //Methods

  private:
  //Properties
  //Methods
};

#endif
EOF

  # .cpp content
  cat > "$dir/$class.cpp" <<EOF
#include "$class.hpp"

// -----------------------CONSTRUCTION AND DESTRUCTION-------------------------

// Default constructor
$class::$class()
{
    std::cout << "$class" << " has been constructed" << "\n";
}

// Destructor
$class::~$class()
{
    std::cout << "$class" << " has been destructed" << "\n";
}

// Copy constructor
$class::$class(const $class &other)
{
    std::cout << "$class" << " has been constructed (COPY)" << "\n";
}

// Copy assignment operator
$class &${class}::operator=(const $class &other)
{
    if (this != &other)
    {
        std::cout << "$class" << " has been constructed (COPY assignment)" << "\n";
        // Copy data
    }
    return (*this);
}

// Move constructor
$class::$class($class&& other) noexcept
{
    std::cout << "$class" << " has been constructed (MOVE)" << "\n";
}

// Move assignment operator
$class& $class::operator=($class&& other) noexcept
{
	if (this != &other)
	{
        std::cout << "$class" << " has been constructed (MOVE assignment)" << "\n";
		// Free old data (inside this)
        // Steal new data (from other)
	    // Clean up the traces (data in other has to set to null)
		// std::move(other);
	}
	return (*this);
}

// ---------------------------ACCESSORS-----------------------------

// ---------------------------METHODS-----------------------------
EOF

  echo "Created $class ✅"
done
