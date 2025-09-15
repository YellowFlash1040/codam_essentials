simple directives (one liners)
block directives (the one with {})

each simple directive has to end with a `;`

For the 42 webserv we will have

2 block directives:

- server
- location

and next simple directives:

- root
- listen
-

A simple directive consists of the name and parameters separated by spaces and ends with a semicolon (;).
A block directive has the same structure as a simple directive, but instead of the semicolon
it ends with a set of additional instructions surrounded by braces ({ and }).

Directives placed in the configuration file outside of any contexts are considered to be in the main context

The `events` and `http` directives reside in the `main` context, `server` in `http`, and `location` in `server`.

The rest of a line after the `#` sign is considered a comment.
