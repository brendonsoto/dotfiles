# Autocompleting on Enter

## Steps to repro
   - Start typing
   - If the autocompletion list appears, press enter

## Desired outcome
   Pressing enter won't automatically insert what's at the top of the menu.
   `<c-n>` and `<c-p>` still work fine.
   There's still a way to "confirm" what the top option is.

## Hunch
   Something with CMP

## Reality
   Was CMP mappings.
   Before:
   @code lua
   ['<cr>'] = function(fallback)
     if cmp.visible() then
       cmp.confirm({ select = true })
     else
       fallback()
     end
   end
   @end

   I swapped the keymapping from `<cr>` to `<c-y>`.
   I also wonder if a better alternative would be changing the LSP to be active for markdown.
