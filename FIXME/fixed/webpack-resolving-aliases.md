# Resolving webpack aliases when using "go to"
  Problem:
  You have a webpack alias and thus have import statements like:
  `import MyComp from '~/components';`
  You have `MyComp` under your cursor and try to "go-to" the definition
  Sometimes that wouldn't happen.
  Of course, now I cannot reproduce it.

  New problem:
  How to resolve webpack aliases when in insert mode when making an import statement
  This makes me think it's a nvim-cmp thing

## Why the problem happens
   This has to do with mixing TS and JS files together.
   If there's an `alias` and both TS and JS files are referenced from it, the TS files will be found via LSP but not the JS ones.
   I believe this is because of the tsconfig needing the alias specified too.

   I made a tiny React project to experiment with where I had an alias named `@` mapped to the `src` directory.
   In that directory I had two super simple React components, `Text` and `Button`.
   The former was JSX and the latter TSX.
   The former could not be navigated to via Go-To-Def but the `Button`/TSX component was fine.
   I guess then the fix is to move JS files to TS?
