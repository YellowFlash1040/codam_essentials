# GDB Cheat Sheet

## BASICS

`gdb program` # Start GDB with the given program  
`gdb --args program arg1` # Start GDB with arguments to the program  
`run (or r) [args]` # Run the program (again) with optional args  
`quit` (or q) # Exit GDB  
`help [command]` # Get help for a command

## BREAKPOINTS

`break (or b) func` # Break at function  
`break file.c:line` # Break at specific file and line  
`break +N / -N` # Break N lines after/before current  
`info breakpoints (or i b)` # List all breakpoints  
`delete [n]` # Delete breakpoint n (or all)  
`disable [n]` # Disable breakpoint n  
`enable [n]` # Re-enable breakpoint n

## WATCHPOINTS

`watch var` # Break when var changes  
`rwatch var` # Break when var is read  
`awatch var` # Break when var is read or written  
`info watchpoints` # List watchpoints

## RUNNING

`next (or n)` # Step over to next line  
`step (or s)` # Step into function  
`finish` # Run until current function returns  
`continue (or c)` # Continue after breakpoint  
`until` # Run until a line > current line  
`jump line` # Jump to line

## STACK

`backtrace (or bt)` # Show call stack  
`frame N` # Select frame N  
`up / down` # Move up/down stack frames  
`info frame` # Info about current frame

## VARIABLES

`print (or p) var` # Print variable value  
`display var` # Print var at each stop  
`undisplay N` # Remove display number N  
`set var=val` # Change variable value  
`info locals` # Show local variables  
`info args` # Show function arguments  
`whatis var` # Show type of variable  
`ptype var` # Show full type (structs, etc.)

## MEMORY

x/FMT addr # Examine memory  
FMT = [count][format][size]  
Format: x(hex), d(dec), u(unsigned), t(binary), f(float), c(char), s(string), i(instruction)  
Size: b(byte), h(halfword), w(word), g(giant)

    Examples:
    x/4xb ptr               # 4 hex bytes from ptr
    x/2i $pc                # 2 instructions from program counter

## SIGNALS

`handle SIGINT ignore` # Ignore signal (e.g., Ctrl+C)  
`handle SIGSEGV nostop` # Do not stop on segfault  
`info signals` # List all signals

## FILES

`list (or l)` # Show source code  
`list func or list line` # Show around function or line  
`directory dir` # Add source directory  
`file prog` # Load program  
`symbol-file file` # Load symbols

## OTHER

`set pagination off` # Avoid --Type <RET> for more  
`set history save on` # Save command history  
set history filename ~/.gdb_history
`define name` # Define a custom command  
`source file.gdb` # Load GDB script  
`shell clear` # Run shell command, e.g., clear terminal
