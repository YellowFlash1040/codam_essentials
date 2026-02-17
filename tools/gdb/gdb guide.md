# 🐞 GDB Cheatsheet

A quick reference for basic GDB usage.

---

## 🔹 Starting GDB

```sh
gdb ./program       # Start GDB with executable
gdb ./program core  # Start GDB with a core dump
```

---

## 🔹 Running the Program

```gdb
run                 # Start program
run [args]          # Start program with optional args
r                   # (alias) run
start               # Start and break at main
continue            # Continue after a break
c                   # (alias) continue
```

---

## 🔹 Breakpoints

```gdb
break main          # Break at function 'main'
b main              # (alias) break at 'main'
break file.c:42     # Break at line 42
b 42                # (alias) break at line 42 (in current file)
info breakpoints    # List breakpoints
info b              # (alias)
delete              # Delete all breakpoints
delete N            # Delete breakpoint N
clear               # Clear breakpoint at current line
```

---

## 🔹 Stepping

```gdb
next                # Step over (don’t enter functions)
n                   # (alias) next
step                # Step into functions
s                   # (alias) step
finish              # Run until current function returns
```

---

## 🔹 Inspecting Variables

```gdb
print x             # Print value of x
p x                 # (alias) print x
display x           # Auto print x after each step
info display        # Show all displayed expressions
undisplay N         # Stop displaying expression N
delete display      # Remove all displays
```

---

## 🔹 Execution Control

```gdb
kill                # Stop the running program
quit                # Exit GDB
q                   # (alias) quit
```

---

## 🔹 TUI (Text User Interface)

```gdb
layout split        # Code + assembly view
layout src          # Source code view
layout asm          # Assembly view
layout regs         # Registers view
Ctrl+X A            # Toggle TUI mode
Ctrl+L              # Refresh screen
```

---

## 🔹 Useful Settings

```gdb
set pagination off      # Disable --More-- paging
set print pretty on     # Print structs/arrays nicely
set confirm off   		# Turn off confirmation messages and automatically choose 'yes'
```

---

## 🔹 Help System

```gdb
help                    # General help
help break              # Help on a specific command
help all                # Show all commands
```

---

## 🔹 Custom Shortcuts (add to `.gdbinit`)

```gdb
define d
  display $arg0
end

define dd
  info display
end

define clean
  delete display
  info display
end
```

---

## 📁 Files

- `~/.gdbinit` – Global config file
- `./.gdbinit` – Local config (used if present in the current directory)

---

## 🧠 Popular Aliases (Summary)

| Shortcut | Command           |
|----------|-------------------|
| `b`      | `break`           |
| `r`      | `run`             |
| `c`      | `continue`        |
| `n`      | `next`            |
| `s`      | `step`            |
| `p`      | `print`           |
| `q`      | `quit`            |
| `info b` | `info breakpoints`|

---

Happy debugging! 🛠️
