Here’s a clean way to structure an **NGINX-like parser** using **lexing + recursive descent parsing**, with responsibilities clearly separated:

## **1. Lexer (Tokenizer)**

**Responsibility:**

- Turn raw text into a stream of **tokens**.
- Recognize keywords, identifiers, strings, numbers, symbols (`{`, `}`, `;`), comments, etc.
- Track line and column for error reporting.

**Class: `Lexer`**

```cpp
+ Lexer

- input: std::string
- pos, line, column
- current_char
- methods:
  Token nextToken()
  void skipWhitespace()
  void skipComment()
  Token readIdentifierOrKeyword()
  Token readString()
```

**Output:** a stream/vector of `Token`s:

```cpp
enum class TokenType
{
	Identifier,
	Keyword,
	Semicolon,
	OpenBrace,
	CloseBrace,
	String,
	Number,
	End
};

struct Token
{
	TokenType type;
	std::string value;
	int line;
	int column;
};
```

## **2. Parser**

**Responsibility:**

- Consume tokens from the lexer.
- Ensure **syntactic correctness** (`;`, `{`, `}` in place).
- Build an **abstract syntax tree (AST)** or intermediate representation.

**Class: `Parser`**

```cpp
+ Parser

- tokens: std::vector<Token>
- pos
- methods:
  parseConfig() -> ConfigAST
  parseBlock() -> BlockAST
  parseDirective() -> DirectiveAST
  Token peek(), Token advance(), bool match(TokenType)
```

**Key idea:** recursive descent:

```
Config      -> { Directive | Block }*
Block       -> Identifier args* { Config }
Directive   -> Identifier args* ;
```

- Blocks (`location { ... }`) are recursive.
- Directives (`root /var/www;`) are leaf nodes.

## **3. AST / Data Structures**

**Responsibility:**

- Hold the **parsed structure**.
- Make it easy to perform semantic checks or generate a runtime config.

```cpp
struct ASTNode
{
	virtual ~ASTNode() = default;
};

struct DirectiveAST : ASTNode
{
	std::string name;
	std::vector<std::string> args;
};

struct BlockAST : ASTNode
{
	std::string name;
	std::vector<std::string> args;
	std::vector<std::unique_ptr<ASTNode>> children;
};

struct ConfigAST : ASTNode
{
	std::vector<std::unique_ptr<ASTNode>> statements;
};
```

## **4. Semantic Validator / Config Checker**

**Responsibility:**

- Check **meaning** of parsed config:

  - Valid directive names (`location`, `root`, `listen`)
  - Correct arguments (`/images` is a path pattern, port numbers valid)
  - Directive allowed in a specific context (e.g., `root` inside `location`)

**Class: `Validator`**

```cpp
+ Validator

- methods:
  void validate(ConfigAST&)
  void validateBlock(BlockAST&, allowedDirectives)
  void validateDirective(DirectiveAST&, allowedArgs)
```

- Can return errors/warnings with line & column info from AST.

## **5. Optional: Error Handling**

- `ParserError`, `LexerError`, `ValidationError`
- Each contains line & column info for **nice error messages**.

## **Workflow**

1.  **Lexer** → tokenize input text → stream of tokens
2.  **Parser** → parse tokens → AST (syntax checked)
3.  **Validator** → traverse AST → semantic checks

---

### **Why this separation is useful**

- Lexer only cares about characters → reusable
- Parser only cares about **syntax** → can implement recursive descent clearly
- Validator only cares about **meaning** → can be updated independently of syntax
- AST is clean intermediate form → can be used to generate runtime config or documentation
