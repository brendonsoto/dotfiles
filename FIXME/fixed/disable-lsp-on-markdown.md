# Disable LSP on Markdowns

## Steps to repro
   - Open or create a markdown file
   - Start typing
   - When auto-complete window appears, notice the options are all from LSP

## Fix
   Setup CMP to use only Buffer and Path sources for markdown files.
   See commit after 3ef7549f6ac3972e32af9820b51f092ae9181194
