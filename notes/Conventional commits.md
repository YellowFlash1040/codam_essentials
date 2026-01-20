## 🏷️ Common Commit Types
| Type         | Meaning                                                        |
| ------------ | -------------------------------------------------------------- |
| **feat**     | A new feature                                                  |
| **fix**      | A bug fix                                                      |
| **refactor** | Code change that neither fixes a bug nor adds a feature        |
| **chore**    | Other changes that don’t modify `src` or `test` files          |
| **test**     | Adding or fixing tests                                         |
| **build**    | Changes that affect build system or dependencies               |
| **docs**     | Documentation only changes                                     |
| **revert**   | Reverts a previous commit                                      |
| **style**    | Code style (formatting, semicolons, spacing) – no logic change |
| **perf**     | Code change that improves performance                          |
| **ci**       | Changes to CI configuration or scripts                         |


### Additional non-official types:
|              |                                                                |
| ------------ | -------------------------------------------------------------- |
| **wip**      | work in progress                                               |

There is such a thing as WIP commit (acceptable on a feature branch only)  
(It's technically not a conventional commit type, but many teams allow it in feature branches.)


### Conventional Commits spec:
```bash
<type>[optional scope]: <description> (~50 characters max)
[optional body] (~72 characters per line max)
```
