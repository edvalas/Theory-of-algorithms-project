# Theory-of-algorithms-project

## Ed Lasauskas
## 4th Year
## College: Galway-Mayo Institute of Technology
## Module: Theory of Algorithms
## Lecturer: Dr. Ian Mcloughlin

### Introduction
This is a project for the above module, which requires to program a maths game: Countdown Numbers.

This project will be implemented in the racket programming language.

###The Game
The game of countdown numbers involves a list of numbers, which include: `1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,25,50,75,100`. 

Six numbers are choosen at random from the list only once. Example of choosen numbers: `1,5,3,10,50,5`.

A **target number**, which is a random number also in the range of 101 to 999 inclusive is choosen randomly.

The goal of the game is to use the six random numbers and try to come up with a maths equation using the operators `+, -, *, /` , such that the equation when evaluated will equal the target number. There is posibilities such as there being no correct equation from the six numbers, which will evaluate to the target number or there can be one or more solutions to reach the target number.

This program should take 6 numbers and evaluate all posibble equations using those 6 numbers and math operators to try reach the target number. Then output all of the correct solutions, if there are any.

### My Approach
From looking at some maths examples and thinking about this problem mathematically, I believe that this is a testing of all posible outcomes problem, which is a Brute Force approach in computing.

For my approach to solve this problem, I have broken this problem down into a few smaller steps:

1. We will need all of the permutations of our starting numbers. There are a maximum of 6 which means we will have 6x5x4x3x2x1 or 6!(factorial) posibilities for our list of permutations of the numbers which equates to 720 outcomes.
2. For our operators we have, + - * /. For six numbers, we will need 5 operators from the list of 4 operators. We need to generate all permutations of size 5 from a list of 4 choices, however this list of permutations needs to include repetition in it, as you can have repeating operators such as: + + - / /. We will have 4x4x4x4x4 or 4^5 choices for our list of permutations with repetition of the operators, which equates to 1024 outcomes.
3. We need some logic to take the first number permutation from the list of all number permutations and apply each permutation of the operator list to it. This means we will need 720 number permutations to be checked against 1024 operator permutations for each number permutationk, which will net 720x1024 = 737280 comparisons to find out all the posible equations that could give the correct answer.
4. From step 3 we need to recurse over the number list of permutations and have a check if our target number equals to the output of our equations which will be made from taking a number permutation and filling in an operator permutation with it eg. 1 2 3 4 5 6 for numbers and + + - * / for operators. A generic maths equation for 6 numbers and 5 operators will be required eg. ***n O n O n O n O n O n*** (n = number, O = operator), which will be populated by both lists eg. 1 + 2 + 3 - 4 * 5 / 6.
5. If the equation such as above equals our target number, we want to output that equation to an accumulator list, so it can accumulate all of the correct answers for us for display at the end of all comparisons or it will be empty if there are no solutions to reach our target number.

There is a problem with this approach, which is that there are redundant checks, which result in the calculation going into fractions or negative numbers, but it is brute force approach and these redundant checks will not make it, on the correct solution list, which is our accumulator list.

### Development
Working solution completed 14/3/17. At worst case, if all numbers are distict there are 737280 maths equations formed and evaluated.
At the moment there are a lot of duplicate solutions eg. 2 + 3 * 5 and 2 + 5 * 3...
The run time is around 2 minutes 25 seconds with 737280 iterations if all numbers are distinct.

Next steps:
1. Review my approach of comparing number permutations vs operator permutations with repetition.
2. Check if the operator list can be reduced as it produces many duplicate solutions currently, meaning there are many redundant checks.
3. Reduce number of checks by adding rules to make sure not to evaluate equations which go into negative numbers or decimals.
