# Comments in JSX/TSX

## Repro steps
   - Create a React component like:
   @code React
   <div
    className="comment me"
   >
    Testing
   </div>
   @end
   - try commenting the line with `className`.

   The line is commented using `//` instead of `{/* */}`

## CANCELLED
   Turns out having a comment using `//` for an attribute, or in other words something /inside/ a JSX element, is fine.
   The brackets are only needed if including a comment like a child element, but even then `//` works fine.
