# Disable LSP on Markdowns

## Steps to repro
- Open or create a markdown file
- Start typing
- When auto-complete window appears, notice the options are all from LSP

## Fix
Setup CMP to use only Buffer and Path sources for markdown files.
