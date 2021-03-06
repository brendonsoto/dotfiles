# Project 9
This project's goal is to be familiar with the Jack programming language as prep for creating a compiler for it.

At first I was thinking of creating the game Snake for my project, but now I'm a bit unsure. I don't want to spend a whole lot of time working on this, especially when this is just a language to practice with, not to use seriously. Therefore I'm thinking about doing a game I already have made like Breakout. I considered trying to mimick the version of Pong the book uses, but I figured to do something different to be at least a little creative/different.

Yeah, I think I'll go with Breakout. Its mechanics are relatively simple enough: no AI, simple collision detection, only have to worry about two objects moving simultaneously. I've also implemented it in JS which is a plus so I won't have to worry about thinking out the logic of it too much.

_Update - Same day, 7:39pm_
So I realized my "Breakout" game is basically the same as the book's version of "Pong" when the bricks are taken out so I'm going to just do "Pong" instead.

## Understanding the Problem
There are actually two "big" problems, but they are related to each other. The first is to understand the Jack programming language. This is achieved through the second problem: developing an application using the Jack programming language.

## The Data
The data here is the Standard API library. That tells us what functionality is native to the language, what we can use without having to implement.

## The Unknown
The unknown is the language and the program, but primarily the language.

## The Conclusion
The expected conclusion is through creating a simple application I will have sufficient knowledge of the language to construct a compiler for the language and eventually an OS.


### Breakout
The application to be developed is to be a relatively simple program. The program I chose to develop is the game Breakout. Now let's break it down (no pun intended) into its parts.

#### Core Components
- Player (movable brick)
- Ball
- Bricks
- Walls

The Player & Ball both move while the Bricks are stationary. The walls are also stationary, but that didn't need mentioning, even though I just did (cue in the awkward turtle).

#### Mechanics
The game will be simple. Not much detail will be given to the physics of the ball or paddle or bricks. The speed of the ball and paddle will be kept constant, only direction will change.

Crude collision detection will be set for the bricks, wall, and paddle. The detection will be done by simple math (i.e. is the ball within the bounds of the object).

The game loop will need to encapsulate everything, but this can come into play when creating the game object.

#### Gameplan
1. [X] Create the directory for the game
2. [X] ReCreate a simple hello world to get stuff out onto the screen
3. [X] Create the ball
4. [X] Give the ball movement
5. [X] Create collision detection for walls -- start with four and then take away the bottom
6. [X] Create a user paddle
7. [X] Give the user paddle collision detection
8. [X] Give the user paddle movement
9. [X] Add a score component
10. [X] Add a game over screen
//Ignoring the below, see the Update in the main header
//9. [ ] Create a brick object
//10. [ ] Give the brick object collision detection
//11. [ ] Make the brick object disappear on collision detection
//12. [ ] Create a mapping of bricks


##### The Ball
Since Jack is an ObjectOriented-like language we'll have to think of the components to the game as objects. Luckily the state is nothing extreme so it should be straightforward.

Our ball will be an object with four variables to it: x-pos, y-pos, height, and width. In traditional OO-style we'll have getter and setter methods to the ball.

*One thing to consider is where the collision detection should occurr....

We will also need to draw the ball onto the screen so the API will need to be consulted.
Color will need to be set using `setColor`. The ball can then be drawn with `drawRectangle`.

We need data on the size of the screen. It's somewhere in the book I believe...
Ahh, it's in the API doc. We're working with 512H x 256W.

So our *gameplan* for the ball is then:
1. [X] Create a class for the ball
2. [X] Add the fields/variables to the ball
3. [X] Add a constructor
4. [X] Add a draw method
5. [X] Create `dispose` method
6. [X] Create a ball in the `Main` class
7. [X] Draw the ball and test that


##### Giving the Ball Movement
Here's where the game loop will actually come into play. There needs to be a loop to get the program to continually move the ball. It doesn't matter that there's no collision detection yet, the goal is basic movement.

Things needed:
- While/Game loop
- Something to tell the ball to move
- Direction

The *While/Game* loop should be easy. We'll just set a `while true` loop in the main for now. Once we have collision detection, we'll set an actual condition to reach in the while statement.

There can be a *method* to move the ball. That will be easy to create. The steps would be:
1. Add _direction-x_ to X
2. Add _direction-y_ to Y
But in order to do that we will need to add direction to the ball somehow.
Direction can be split up into X-speed and Y-speed field variables.
Last thing is to move the ball drawing function call from the main func to the game loop.

Actually, since we'll be implementing the game loop here we might as well create the game class now and have the game loop be in some method named `run` or something.

I almost forgot! We need to constantly clear the screen too while doing it.

*Gameplan:*
1. [X] Add X/Y-speed fields to Ball class
2. [X] Add a `moveBall` method to Ball class
3. [X] Create a class for the Game
4. [X] Create a game loop in the game class
5. [X] Add the game run call to the main method.


The ball is moving, but it has an error saying "Illegal rectangle coordinates". So I guess that means that now I do need collision detection now.


##### Collision Detection -- Walls
Detecting the walls is a matter of checking the boundaries of the screen against the ball.

We know the max height is 256 and the max width is 512. Therefore:
- 0 <# y <# 256
- 0 <# x <# 512

Hopefully Jack can do comparisons like these: If X # 0: xSpeed # -1 * xSpeed.

*Gameplan:*
- [X] Add the above conditional checks to the Ball's `moveBall` method

Turns out something's wrong with my moving ball method. For some reason the values are spiking way above and below the ranges. For instance, I'm looking at a value that is -1967 right now for the x-value. Another weird thing is that the values are oscillating between high and low, but they switch at extremes.

Alright. I have movement. Really stupidly fast movement so now I need to throttle it somehow.

Yes, got the x-movement working. Took some time to lock into the values needed. I don't know why simply doing 512-size wouldn't do the trick, or even 510!

Nice. I got the ball bouncing around. I also forgot that any arithmetic within a conditional clause needs to wrapped in its own parenthesis.


##### User Paddle
The user paddle will be its own class/object.
The data it will need is:
- X pos
- Height
- Width
These can be set in the constructor.
With that said, here's a *gameplan:*
1. [X] Create a paddle class
2. [X] Add a paddle constructor
3. [X] Add a `draw` method for the paddle
4. [X] Add the draw in the main loop


##### Collision Detection -- Paddle
We have a `moveBall` function.
We have `x/y` field variables for the paddle.
We need to pass the field variables into the function to determine the bounce.
To test, let's change the ball's trajectory to go towards the paddle initially.

*gameplan:*
1. [X] Modify the `moveBall` function to accept the coordinates of a paddle
2. [X] In the call to `moveBall` add the ball's `x/y` coordinates
3. [X] If necessary, modify the ball's x/y Speed so the ball always hits the paddle

One thing I didn't consider enough is the *condition* to represent contact between the ball and the paddle.
I feel like it needs to be a range from the top of the paddle to a few pixels below.


##### Moving the user paddle
I need to detect user motion using the keys.
So within every cycle of the game loop I need to read for input and react to it.
So before even drawing stuff I'll look for any pressed keys and react only to the left and right ones. If they are pressed, then the paddle will be moved to the left/right.

I need to keep boundaries in mind. Nothing more than the width of the canvas.

*Gameplan*:
1. [X] Create `moveLeft` and `moveRight` methods on the `Paddle` class
2. [X] Create a `readInput` mechanism in the `gameLoop`
3. [X] Map the *left* and *right* arrow keys to `moveLeft` and `moveRight`


##### Adding a Score Component
The score needs to be displayed somewhere so it needs to be printed out on every screen. I think at least.

This is a bit late, but *gameplan:*
1. [X] Write words out to screen
2. [X] Add a score variable to the game
3. [X] Increment the score everytime the ball makes contact with the ball


##### Adding a Game Over Screen
I think the easiest way is to check the Y values after the `moveBall` method has been called and if its below and outside of the paddle, then declare game over.

This entails introducing some sort of `isGameRunning` variable.
This is the variable we can and should be using in our game loop funciton.

*Gameplan:*
1. [X] Add a `isGameRunning` variable to the `Game` class
2. [X] Swap out the `true` in the game loop `while` statement with `isGameRunning`
3. [X] Add the conditional check to see if the ball has touched the ground after `moveBall`


## Reflections
I AM SO GLAD FOR THE LANGUAGES WE HAVE TODAY! It sucks having to enter return statements everywhere and having separate commands to create and assign variables.

This project's focus was on getting familiar with the language itself which seemed pretty straightforward with the project. I feel like this project wasn't as intense as the other past few, but it makes sense since this is more about creating a program rather than implementing some sort of service/translation part.
