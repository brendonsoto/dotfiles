You know what would be great? To make a web app that mirrors browser behaviour like a tiling WM. Click a link and the page cuts in half with one half being the original content, clicked link highlighted, and the other half the page. Based off of Ted Nelson's hypertext. Maybe include an option to collapse the original page? And save progress?

# My book on Haskell

I wouldn't call this so much a book, but rather an online informal reference to the language. Here's a brief Q&A:

*Why am I making this?*
To give myself a quick reference to the language for when I take a break from it and return to it. Plus, what better way of learning a language than by (trying to) teach it?

*What will it cover?*
What I know as I learn it.

*What background knowledge is necessary?*
None. I will assume I will forget a lot because I do, for better and for worse.

*What version of GHC was this written with?*
8.4.3

*How esoteric will you get?*
I will try to stick to what's most known within the community. Anything else will be noted.

*Why do you say "Think of it as/like..." so much?*
Because analogies are helpful.

*You don't know what you're talking about!*
I know. Isn't it wonderful? // Insert picture of mad hatter and the march hare


## Setup

Yes, yes, the most exhilirating part, the setup. Let's make this brief.

Haskell uses [GHC](https://www.haskell.org/ghc/), which basically is its compiler.
Are there others? Yup. But use GHC since that's the one the community knows best.

It will probably be best to also install [Stack](https://docs.haskellstack.org/en/stable/README/). Think of it as a package manager and build tool, but primarily build tool. Like NPM for the JavaScript community. Main difference is Stack builds upon another tool call [Cabal](https://www.haskell.org/cabal/) which is a tool to download and manage Haskell packages.

Just use Stack.

I'm not going to say how to install the tools because I don't know what operating system you will be using when you're reading this. If OSX, [Homebrew](https://brew.sh/) should suffice. If Linux, whatever package manager you've got there. If Windows, well, I don't know.


## How to run .hs files
TODO _Include more detail on why this works_
1. Have a `something.hs` file where *something* is whatever
2. Run `ghc -dynamic something`. You'll see some output stuff
3. Run `./something`.
Notice the lack of a file type on the last note. That's intentional. GHC takes your file and creates a `something.o` file. What's the `.o` for? It's for "OH SNAP! YOU'VE GOT A HASKELL PROGRAM NOW!" I honestly forgot. I think *object*. Like when compiling C programs. That probably doesn't help at all.


## REPL
[REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop)'s are great. Stack + GHC provides a REPL experience using `stack ghci`. It might be handy to alias `ghci` to `stack ghci`.


## Hello world!
Haskell's not like other languages in the way that hello world is simple to understand. It looks it, but boy it is not. In fact, almost a year of reading through several Haskell books at a leisurely pace and, at the time of writing, I cannot tell you how it works! (Haven't gotten to monads/IO yet) Anywho, here it is with ghci:
`putStrLn "Hello!"`

In a file:
`main = do putStrLn "Hello!"`
Then follow the steps in [[## How to run .hs files]]

You did it! You did the thing every programmer does in beginning to learn a language! I'm not being sassy, you are!


## Common datatypes
TODO -- pickup from here
This will be in alphabetical order because why not?

[]
Bool
Char
*Num

*Starting out, numbers are a little confusing in Haskell. Least I found them confusing. Sometimes I would try to do simple arithmetic, but would always mix up the types `Num`, `Int`, `Integer`, `Integral`, and `Float`. There are more, but my brain was fixated on those five types for some reason and maybe you're encountering the same problem.

Fear not! I'm not going to tell you what to use for what since what I say now may not be valid in the future. Instead, here's how to derive it.
```
stack ghci
> :i (+)
> :i (*)
> :i (/)
> ...
```
*What does `:i` mean?*
It's a way to ask GHC for info about the given datatype or function.

Noticed how the first two report back `class Num a where` and then more stuff underneath? That word next to `class` is our datatype.

Division throws us for a loop with `class Num a => Fractional a where`. Is it `Num` or is it `Fractional`? Why are there two? Why are there multiple numbers to begin with? This is making my mind `Num` (badum tsst!).




## Semigroups and Monoids
These are two rad type classes. Why they're rad is explained in their individual sections. What are they for? For combining values of the same type. You know how you can concat Strings using the `++` function? Or even just addition. Semigroups and monoids provide the same functionality, but for any other type!

### Semigroups
A semigroup is a really cool type class that is used to join multiple values of the same data type. Basically addition, with its law of associativity, but for types. It does this joining using the following syntax: `<>` (i.e. [1,2] <> [3,4]).

### Monoids
A monoid is very similar to a semigroup with the same goal. The main difference is that it requires a property called `mempty` to be set. The idea behind `mempty` is that any value joined with `mempty` should return just that value itself. So it's like the *identity function*. A more concrete example is how anything plus zero is itself. Same deal with multiplying by one.

Why is `mempty` important? Because it provides a transparent base for `fold`s allowing you to join lists together with predictible results. We're going back to the idea of *referential transparency* here!
