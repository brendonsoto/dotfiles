# CMP completion menu doesnt show LSP options
## Steps to repro
   - Make an interface representing an object like `interface Person { name: string; }`
   - Make a variable of the same type
   - Open curly brackets
   - Use `<-space>` to call `cmp.complete`

   Buffer options appear but not LSP

## Fix
   Had to reconfigure `cmp.mapping.complete` to specify to use LSP for its sources:
   @code lua
       ['<c-space>'] = cmp.mapping.complete({
          config = {
            sources = {
              { name = 'nvim_lsp' },
            }, {
              { name = 'buffer' },
            }
          }
        }),
   @end
