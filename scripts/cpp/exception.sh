#!/bin/bash

# Exit if no arguments are passed
if [ $# -eq 0 ]; then
  echo "Usage: $0 ExceptionName1 [ExceptionName2 ...]"
  exit 1
fi

for base in "$@"; do
  # Check if base already ends with "Exception"
  if [[ "$base" == *Exception ]]; then
    exc="$base"
  else
    exc="${base}Exception"
  fi
  
  dir="$exc"
  mkdir -p "$dir"

  # Header guard
  guard=$(echo "${exc}_HPP" | tr '[:lower:]' '[:upper:]')

  # .hpp content
  cat > "$dir/$exc.hpp" <<EOF
#pragma once

#ifndef $guard
# define $guard

# include <stdexcept>
# include <string>

class $exc : public std::exception
{
  public:
    $exc(const std::string& message);

    const char* what() const noexcept override;

  private:
    std::string m_message;
};

#endif
EOF

  # .cpp content
  cat > "$dir/$exc.cpp" <<EOF
#include "${exc}.hpp"

$exc::$exc(const std::string& message)
  : m_message(message)
{}

const char* $exc::what() const noexcept
{
    return m_message.c_str();
}
EOF

  echo "Created custom exception ${exc} ✅"
done
