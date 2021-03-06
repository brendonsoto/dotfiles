                                 # Project 8

## Goals
- [X] Add the following syntax types for the parser:
  - [X] goto
  - [X] if-goto
  - [X] function declaration
  - [X] function call
  - [X] function return
- [X] Add the following functionality to the code writer module:
  - [X] jumps
  - [X] conditional jumps
  - [X] function declarations
  - [X] function calls?
  - [X] function return (similar to a jump?)
- [X] Extend the main module to take in a directory of .vm files and output a single .asm file
- [X] Figure out how to include the vm file when writing labels
- [X] Write initialization code
- [X] Complete BasicLoop
- [X] Complete FibonacciSerires
- [X] Complete SimpleFunction
- [X] Complete Fibonacci Element
- [ ] Complete StaticTest

## Gameplan
  I'm going to try acting on last project's reflections. To start, I'm going to look at the first VM program to test out and work backwards from there. I'll write the assembly code for the program by hand and try testing the program using the CPUemulator. I figured once I have a handle on what the machine language should look like I'll know what to aim for instead of writing code where I'm uncertain if it'll do what it should.
  To counter the above argument, it would be a bit much to write the assembly code for some of the more developed problems by hand. But, like anything else, it will depend on the context: how long the program is, the number of variables, etc..
  Let's start.
  Yeah, for example, I just looked at the code for BasicLoop.vm and I already have a vision in my head as to what the code should look like so I don't think writing the assembly by hand is necessary.

### BasicLoop
*Gameplan*
- [X] Parser-side:
  - [X] Label syntax
  - [X] if-goto syntax
- [X] Code-writer-side:
  - [X] write_label
  - [X] write_if_goto

Maybe I was a bit overconfident because I wrote my code, but alas it is incorrect! I'm a bit confused because the only new things are the label and the goto portion, but the problem lies in incorrect values at the addresses!! Grr...

_Update 2018/Mar/26_
Got BasicLoop working! It turned out my loop function needed to move the SP too, which I forgot to do.


### Fibonacci Series
*Gameplan*
- [X] Parser-side:
  - [X] goto syntax
- [X] Code-writer-side:
  - [X] goto syntax


### Simple Function
I was a bit confused looking at the VM source code because it was just a function declaration. I'm stepping through the VM code using the VMEmulator now.

One thing I noticed is that the SP changed as soon as the function declaration was made. It seems it changes according to the number representing the number of arguments in the declaration. So for instance, a function `function test 2` would increase the SP by 2.

The `return` sequence is throwing me off a bit. I thought the other arguments were going to replace the vm memory segments (i.e. local, this, that, etc.), but upon stepping through I saw some movements within the ROM that I do not understand. I saw Local being saved to a temp address (R13). Let me see what the book says.

Ahh, I get it now. The book describes the following steps as the return:
1. Save the address in LCL memory to a temp variable
2. Get the return address by getting the first argument pushed to the ARG stack
3. Set the ARG value to the result of the function
4. Set the SP to the next bit after ARG
5. Set that/this/arg/lcl to what's stored in the ARGs
6. Navigate to the return address

I was confused by Step 3. I didn't understand before that the result was being popped _into_ ARG. I thought it was being popped into the return address.

So now I can start drafting my implementation. Well, almost.

Looking at the book there are three different parts to writing a function: the declaration, the invocation, and the return.

The declaration seems straightforward enough: create the function label and for N times, push 0.

The invocation is throwing me off a bit. What is the return address? I think it's just literally the next line after the function call. Yeah, I think I was over-thinking that one.

The return seems straightforward enough.

This program seems to only need the function declaration and the return statements. The program provides the bootstrap code for the arguments. So let's go for it with that.

*Gameplan*
- [X] Parser:
  - [X] function declaration
  - [X] function return
- [X] Code-Writer:
  - [X] function declaration
  - [X] function return
  - [X] wire the above 2

#### Mini Reflection
I wound up recompiling and testing this program a few times. The problem was I had switched my registers in writing the return function. I was thinking "I need the address from LCL" so I would write `@LCL\nD#A` instead of `@LCL\nA#M\nD#M`. The language in my head wasn't matching up with the needed language.

I think that's an okay problem to have because I still had the right logic/thoughts in mind, I just didn't realize my expressions didn't match the logic. Still, I want to try to avoid multiple recompilations. Just a little something to keep in mind going forward.


### Fibonacci Element
I liked the format of the last sub-project writing so I'm going to repeat that.
The main thing to be changed this time is checking my code before I run it, since I tend to not which results in multiple recompilations...

Just for completeness, here's a summary of the process:
1. Analyze/Look at the VM program code
2. Step through the VM code using the VMEmulator
3. Write down any questions
4. Repeat Step 2 until you get the answers for the questions in Step 3
5. Write about how you're going to craft the code
6. Write down gameplan
7. Execute said gameplan

#### Analysis
Right off the bat I noticed there are two vm files: Sys.vm & Main.vm. Looking at the two it seems Sys.vm should be written first followed by Main.vm since Main.vm is just a function call. Thus I guess *Sys.vm should always be written first* when there are multiple vm files in play. This is important for implementing _creating a single asm file from a directory_.

The only new piece of code is the `call` keyword. Initialization code is also needed.

Reading the text's pseudo-code implementation of the `call` command is straightforward. I was curious why there was a number in the function call. That's more for repositioning the SP to prepare the arguments for the function.

The initialization code is concerning me a bit. How do you allocate space for the variables? Is it program-dependent? Can I just reuse the spaces mentioned in the previous programs?

The only thing I see about *bootstrap code* in the book is that it should initialize the SP to RAM[256] and call `Sys.init`. Nothing was said about the VM memory segments.

Checking the previous chapter the only relevant information I could find was that addresses 256-2047 are reserved for the Stack, so it seems that's the range of usable values.

I'm going to check the forums about this real quick because I feel like proceeding otherwise would be proceeding in the dark.

Got distracted by a post about the current program and just realized the order that the vm files are processed in (when processing a directory) shouldn't matter because Sys.init will be called first regardless.

I've got my confirmation that the bootstrap code is simply setting the SP and calling `Sys.init`. Sweet. That simplifies things.

When launching the vm-translator the very _first_ thing to do is *create the bootstrap code*. _Then_ all of the vm files to be parsed can be parsed and added to the output code.

It's really interesting watching recursion happen step by step in memory. I feel like I have a better idea of what to do now.


*Gameplan*
- [X] Create bootstrap code
- [X] Enable outputting a single .asm file for a directory of .vm files
- [X] Parser -- Implement `function call n` syntax
- [X] Code-Writer -- Implement `function call n` syntax
- [X] Code-Writer -- Wire up ^
- [X] Re-read code
- [X] Fix return labels when calling `write_func_call`
- [X] Figure out why the `call func` syntax is not working
- [X] Move the HELPER-adding code to the main func
- [X] Figure out why `lt` is not being included
- [X] Run VM-translator on the test program
- [X] Read the .asm code
- [X] If it looks all good, test it
- [ ] Find out where the stuck loop is (somewhere where I'm subtracting two)

At first I ran into a problem with the return labels in `write_func_call` and with the `call func` syntax not working correctly. I added those two bits to the gameplan and managed to fix them. The first problem was due to simple syntax errors. The second problem was because I was incorrectly generating the output file. I was using the same method to generate the output file name from the input file name on the directory, not knowing I would need a completely different approach. Luckily I didn't spend too much time fixing that.

Now though, I think my `if-goto` implementation is actually incorrect. The pseudocode for the fib sequence reads *if n<2 go here else go there*. Wait, no, nevermind, I forgot that -1 actually becomes 16 1s in a 16 bit system, thereby being greater than 0, and that 0 represents false.

Wait a minute though, `less than` is missing! This also ties in a TODO I found: adding the HELPER code in a similar fashion to adding the bootstrap code. Time to append the gameplan.

`lt` issue lies in the parser some where. Tried printing out instructions in code-writer, but `lt` was missing. Ahhh, it has to do with my parser not stripping out inline comments.

Embarrasing, right as I was about to test it, I got an error that was from me explicitly writing `call Sys.init 0` in the bootstrap code. Silly me.

Welp. I tried, but at the moment have failed. My return variables are quite off and I think my return value is still the argument/constant from the beginning. I skimmed my stack and I see a pattern of values decreasing by negative two. That tells me I have a stuck loop somewhere, but where...


_Update - 2018/Mar/29_
I'm reading `How to Solve it` while doing these projects now so I'm going to try adopting a set of questions to help me now. Specifically, I'll be using the *Working for Better Understanding* dialogue.

I know my solution fails, but I don't know how.
I believe the source of the problem must lie within the `call` implementation, since that's the only new piece added.
^This is not part of the dialogue. The below is...

_Where do I start? -- Restatement of the problem_
The problem is to create a solution in code to translate the FibonacciElement VM program into a single assembly file.
There are *three* components:
- Creating a single file from a directory with multiple .vm files
- Adding bootstrap code to the output assembly file
- Adding the `function call` functionality

_What can I do? -- Review "principal parts" of the problem_
By "principal parts" we're referring to the parts of the "problem to solve" (the hypothesis and conclusion) and the parts of the "problem to find" (the unkown, the data, and the conditions).

*Problem to Solve parts:*
- Conclusion -- The developed VM translator should successfully translate a VM program such as the FibonacciElement program
- Hypothesis -- By adding the three components in the "Where do I start" section we can derive a program capable of providing the conclusion

*Problem to find parts:*
- Unknown:
  - [X] The code to parse `function call` VM code
  - [ ] The code to write `function call` ASM code
  - [X] How to create a single file from a directory of files
- Data:
  - The pseudocode for the `function call`
  - The VM program files
- Conditions:
  - [ ] The *bootstrap* code
  - [ ] The resulting ASM code should have code that executes the VM `function call` command
  - The ASM code should match the test expected output


Now that those parts have been labeled, we can do the following:
- Consider the parts individually
- Consider the parts in turn
- Consider the parts in various combinations

I just went through a lot of this stuff in out loud to myself while pacing around in my apartment. A lot points back to my function call code so let's check that out.

Ahhh, I problem I have is that my return addresses are not unique in the function call.

Something seems funky with my return. Either the address is incorrect, or the actual return code is.

I thought I solved it, but I didn't. I reached another failed attempt, but looking through the RAM values I see the same return address for each stack. Telling me I have the wrong return address being pushed somewhere. Grr...


YEAHH!!!! I figured out what was wrong! My return functions still were not unique when parsing a directory of .vm files. I patched that up and boom, it works! It's a bit messy, but it works.
^The messy bit I realized is because I'm taking a mixture of procedural + functional approach to this problem. I need to learn architecture better :/


### Mini Reflection
I do think this process went a bit better. I didn't keep count, but I did feel that there were less re-comiplations this time around. It did take longer to step through the code though, but that was okay since I learned some of my previous implementations weren't correct.


## StaticTest
At first glance there didn't seem to be much to implement, so I just tried compiling and testing.
I failed.
My Stack Pointer was at the correct spot, but one of my values was incorrect.
This was also without going through any of the above steps. I figured might as well try skipping them since there's nothing new to implement here.
But now it's time to revisit those steps.

_What is the unknown?_
Why is the value at RAM[261] incorrect?

_What is the data?_
Nothing much really. The only knowns are the two VM programs.

_What are the conditions?_
When the two VM programs are combined into a single ASM file the output should be that of the expected results in the asm test.

_What can help me get a better picture of the unknown?_
Stepping through the VM programs.
Additionally, this program is to test `static` values so if anything maybe the problem lies within the `static` implementation in the *code_writer* module.

*Gameplan*
1. Look at the VM program code -- get an idea of what's going on
2. Step through the VM code using the VM test -- get the big picture
3. Look at your `static` implementation -- specifically check how it's implementation with multiple vm_programs
4. If 3 is flawed, repair it & re-run program
5. Else compile VM program to ASM and test, stepping through each step

It may also be worthwhile checking the parser to make sure inline comments are removed

### Considering the VM programs
Looking at the VM code it seems each 'class' sets its own static variables and subtracts them.

### Considering stepping through the VM code
Just stepped through the program using the VMEmulator. The main thing I see is that the Stack at the end of the program should look as the following:
| Address | Value |
| 261     | -2    |
| 262     | 8     |
| 267     | 8     |
| 268     | 15    |

The other values are 0s.
In consideration of our test, the *addresses should all be subtracted by 5*. This is because the VM test starts the SP at 261.

*Addresses 16-19 should hold the static variables*

I'm willing to bet that my implementation does not work because the static variables are not being set uniquely.

Yup. I just re-executed my code and I see only two slots instead of four of memory for the static variables.

Yes!! I patched that up and now the program works!!

### Mini Reflection
This has been the easiest subproject to complete, surprisingly enough. I learned my `static` implementation was incorrect, but that was the only thing holding me back. It was surprisingly quick to come to that idea too. Using the `How to Solve it` dialogue with myself was quite helpful here.




## End of Project Reflections

  This chapter wasn't as much as a doozy as the last chapter, but still held some important lessons, especially in problem solving. A big aid in all of this was starting George Polya's "How To Solve It" book during the middle of the process. One of my goals was to have less iterations between implementing details and testing solutions and the techniques given in the book definitely helped.
  One big point I'd like to spend some time on is the actual code itself. It's been getting messier as it's grown. I've realized I had to shoe-horn a few features in. I'd like to spend some time cleaning the program up a bit, but I'm still worried about the adaptibility of it. I realized I didn't give adaptibility that much thought which is a byproduct of not imagining varied conditions against my implementations. I was going to say it's tough to consider these options, but then again I can't really say that if I didn't do so.
  My code has been developed using a mixture of procedural and functional bits. Overall it is more procedural than functional. I encountered moments where I needed to introduce some new data into my older functions which lead me to thinking maybe the program would be suited to an object-oriented approach. However I'm not a fan of OOP because I don't like the idea of objects being both the data structure and having functions to manipulate the data. It's not as predictable. State seems like it can get complicated rather quickly once inheritance or polymorphism is introduced. Then again, since this program deals with relatively simple data points (vm files) an OOP approach would seem simple enough.
  A post-book project I would like to do is repeat these programming chapters twice: once with an OOP approach (using Python again) and another with a functional approach (using Haskell). My goal with this is to document the development process and the results and compare my notes. It's a project I'm looking forward to.
