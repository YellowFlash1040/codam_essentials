# Terminals vs Non-terminals in Recursive Descent Parsing

Link to the original conversation:
https://chatgpt.com/c/68c43497-8110-8333-9d70-47a2e9b8b14a

## What is a Terminal and a Non-terminal

### Terminal

- A **terminal** is a basic symbol that appears in the input.
- These are the actual characters or tokens the parser consumes from the input.
- Examples:
  - Keywords: `if`, `while`
  - Symbols: `(`, `)`
  - Identifiers, numbers, operators
- In parser code, terminals usually correspond to **tokens produced by a lexer**.

### Non-terminal

- A **non-terminal** is a syntactic category that can be expanded into one or more sequences of terminals and/or other non-terminals.
- Non-terminals **do not appear directly in the input** — they are abstractions for patterns of tokens.
- Examples:
  - `expression`, `statement`, `function_definition`
- In parser code, non-terminals usually correspond to **functions in a recursive descent parser**.

---

## How Recursive Descent Parsing Uses Them

Each **non-terminal** is implemented as a **function**:

- Functions try to match sequences of terminals and non-terminals according to the grammar.
- They may call other functions (for non-terminals) or check for terminals directly.

### Example Grammar

```
expression -> term (( '+' | '-' ) term)*
term       -> NUMBER
```

- **Non-terminals**: `expression`, `term`
- **Terminals**: `NUMBER`, `'+'`, `'-'`

### Pseudo-code

```cpp
void parse_expression() {
    parse_term();                 // non-terminal
    while (match('+') || match('-')) { // terminals
        parse_term();
    }
}

void parse_term() {
    match(NUMBER);  // terminal
}
```

---

## Simplified Understanding

- Non-terminal = a **pattern** or **rule** that represents sequences of terminals and/or non-terminals.
- Terminal = an **atomic input unit** that cannot be broken down further.

Analogy: **LEGO**

- **Non-terminals** = instructions to build something (can be broken into steps).
- **Terminals** = the individual bricks (cannot be broken down).

---

## English Sentence Analogy

Grammar:

```
sentence -> noun_phrase verb_phrase
noun_phrase -> article noun
verb_phrase -> verb noun_phrase
article -> "the" | "a"
noun -> "cat" | "dog"
verb -> "chases" | "sees"
```

- Non-terminals: `sentence`, `noun_phrase`, `verb_phrase`, `article`, `noun`, `verb`
- Terminals: `"the"`, `"a"`, `"cat"`, `"dog"`, `"chases"`, `"sees"`

Expansion example:

```
sentence -> noun_phrase verb_phrase
         -> (article noun) (verb noun_phrase)
         -> "the" "cat" "chases" (article noun)
         -> "the" "cat" "chases" "a" "dog"
```

- Non-terminals are rules used to generate the sentence.
- Terminals are actual words that appear in the input.

---

## Terminal vs Token

- **Token** = output of the lexer, represents a category of input (`NUMBER`, `IDENTIFIER`, `PLUS`).
- **Terminal** = symbol in the grammar, what the parser expects.
- Usually, **one terminal corresponds to one token type**.
- In practice, terminal ≈ token, but technically terminals are grammar symbols, tokens are input.

---

## Summary

- **Terminal**: indivisible unit, appears in input. Cannot be broken down.
- **Non-terminal**: rule or pattern, can be broken down into terminals and/or non-terminals.
- Recursive descent parser: non-terminals → functions, terminals → matched directly.
- Analogy: terminal = LEGO brick, non-terminal = instructions to build something.

---

**Rule of thumb:**

- Can be broken down → non-terminal
- Cannot be broken down → terminal
