Run the following command in your terminal:

```bash
code --list-extensions > extensions.txt
```

This will generate a file extensions.txt  
with a list of all your installed VSCode extensions.

To reinstall them later, use:

```bash
cat extensions.txt | xargs -n 1 code --install-extension
```

And command to copy vscode settings etc. :

```bash
mkdir -p vscode-config-backup;
cp ~/.config/Code/User/*.json vscode-config-backup;
cp -r ~/.config/Code/User/snippets vscode-config-backup;
```
