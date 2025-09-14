My cppcheck commands:

```bash
alias cppcheck='/home/akovtune/sgoinfre/cppcheck/cppcheck --enable=all --suppress=missingIncludeSystem --suppress=missingInclude --std=c++14 **/\*.cpp **/_.hpp'
```

```bash
alias lcppcheck='clear; /home/akovtune/sgoinfre/cppcheck/cppcheck --enable=all --suppress=missingIncludeSystem --suppress=missingInclude --suppress=unusedStructMember --suppress=unusedFunction --std=c++14 \*\*/_.cpp \*_/_.hpp'
# warning,performance,portability,information
```
