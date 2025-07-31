set pagination off
set confirm off
set print pretty on
set print array on
set print elements 0

break main

run

layout src
info locals

define n
  next
  info locals
end

define s
  step
  info locals
end

define c
  continue
  info locals
end
