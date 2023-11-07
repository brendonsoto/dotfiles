# LSP CMP Problems
## Completion menu showing weird results
   2022-Dec-14

   Example:
   @code typescript
   const navLinks = [];
   nav // CMP menu shows with results like 'navy' and 'nave' way before 'navLinks'
   @end

   How are LSP results sorted?
   This is for CMP so I should probably look through its source code to find out.

## Fix
   Learned a bit about `cmp.compare` functions and `cmp.config.sorting`.
   I took what was in CMP's default config and rearranged it to get
   @code lua
    sorting = {
      -- priority_weight = 2,
      comparators = {
        compare.scopes,
        compare.offset,
        compare.recently_used,
        -- compare.exact,
        -- compare.score,
        -- compare.locality,
        -- compare.kind,
        -- compare.sort_text,
        -- compare.length,
        -- compare.order,
      },
    },
   @end

   What was weird was that `compare.scopes` was originally commented out.
   I think I like having that as my primary comparator the most, least when testing with stuff above.
   The definitions behind the words is a little cryptic but I'm going to roll with the above for now.
