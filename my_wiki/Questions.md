## Questions
_2018-Apr-26_

- I was doing some problems from 99 Haskell Problems and I kept running into problems where the cause was a lack of a *class constraint* on a function. Why is a class constraint needed when the language is dynamically typed?
$^$ Because the class constraint helps the compiler check for possible errors at compile
$^$ Found an actual explanation here: https://en.wikibooks.org/wiki/Haskell/Type_basics#Type_inference

- What is the `x:xs` syntax again?
$^$ The syntax represents the head and the tail of a list.

- Why are lists separated into `x:xs` instead of something like `h:t` (head, tail)
$^$ Answer from https://stackoverflow.com/questions/6267735/what-is-the-history-of-the-variable-names-x-and-xs
"
x is a common variable name in mathematics. xs is the plural form of x (get it?). In list pattern matching, x is one element, and xs is (generally) several.
"


- So Data.Map is different than a list of tuples because its implemented with trees. What is the implementation like? I'm curious.

- What's the difference between `Int`, `Integer`, `Num`, etc and when would you use one over the other?
