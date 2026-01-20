# `chore` conventional commit type

**Question:**  
> if the only thing I did in the code base is moving some files around without changing any contents, which type of conventional commit should I choose?

**Answer:**  
For simply **moving files around without changing their contents**, the typical **Conventional Commit** type is:

### ✅ `chore:`  
Use this when the change does **not affect the source code logic**, API, or behavior — which includes reorganizing files, moving directories, or other housekeeping tasks.

Example commit message:  
<pre>
chore: move files to new directory structure
</pre>

### Why *not* `refactor:`?  
`refactor:` is intended for code changes that alter internal logic **without changing behavior**. Since you didn’t change any code, only moved files, `refactor` is not accurate.

### Why *not* `feat:` / `fix:`?  
Because the change does not add a feature or fix a bug.

### Optional additions:  
If the move improves project structure or clarity, you could optionally use:  
<pre>
chore: reorganize project structure by moving files
</pre>

If the move breaks imports and you update them, it can still be `refactor:` or `chore:` depending on context.
