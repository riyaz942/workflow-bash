# workflow-simpler
Some bash alias commands to make your workflow simpler
(Moving from https://gist.github.com/riyaz942/19e9fd889659d512742da0974ff09729)

Some command examples :-

```
-> git add .
-> git commit -m "commit message here"
=> ga-cm commit message here


-> git checkout branch-name
=> gc branch-name


-> git push origin branch-name
=> gp 								// automatically takes branch name from the current checkedout banch


-> git pull origin branch-name
=> gpl								// automatically takes branch name from the current checkedout banch


// Shows conflicts
-> git ls-files -u
=> g-conflicts


-> git diff "file-path-name"
=> gd index                        // the index is an integer which points to the path from the list you get from git log


-> git rm -r --cached .
=> git-remove-cache

```

Checkout .bash_git for more commands