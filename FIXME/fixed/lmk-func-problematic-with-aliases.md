# lmk script problematic with aliases

## Steps to repro
   - Have an alias (struggling to think of one since the one I use is for work), maybe like `alias e="echo 'hey'"`
   - Run `lmk <alias>`

## Fix
   Turn the alias into a function.
   OR
   Make sure whatever the alias is referencing is in the `$PATH`.
   If not and you don't want to add it, reference the absolute path in the alias.
   Found as support: {https://askubuntu.com/questions/98782/how-to-run-an-alias-in-a-shell-script}
