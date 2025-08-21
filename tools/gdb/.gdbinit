# optional part, if your computer doesn't do it by default
python
import sys
sys.path.insert(0, "/usr/share/gcc-<version>/python")
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers(gdb.current_objfile())
end

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
