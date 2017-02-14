# Theory-of-algorithms-project

## Ed Lasauskas
## 4th Year
## College: Galway-Mayo Institute of Technology
## Module: Theory of Algorithms
## Lecturer: Dr. Ian Mcloughlin

### Introduction
This is a project for the above module, which requires to program a maths game: Countdown Numbers. 

**explanation of the game here to come!!**

This project will be implemented in the racket programming language

### My Approach
From looking at some maths examples and thinking about this problem mathematically, I believe that this is a testing of all posible outcomes problem, which is a Brute Force approach in computing.

For my approach to solve this problem, I have broken this problem down into a few smaller steps:

1. We will need all of the permutations of our starting numbers. There are a maximum of 6 which means we will have 6x5x4x3x2x1 or 6!(factorial) posibilities for our list of permutations of the numbers which equates to 720 outcomes.
2. For our operators we have, + - * /. For six numbers, we will need 5 operators from the list of 4 operators. We need to generate all permutations of size 5 from a list of 4 choices, however this list of permutations needs to include repetition in it, as you can have repeating operators such as: + + - / /. We will have 4x4x4x4x4 or 4^5 choices for our list of permutations with repetition of the operators, which equates to 1024 outcomes.
3. We need some logic to take the first number permutation from the list of all number permutations and apply each permutation of the operator list to it. This means we will need 720 number permutations to be checked against 1024 operator permutations for each number permutationk, which will net 720x1024 = 737280 comparisons to find out all the posible equations that could give the correct answer.
4. From step 3 we need to recurse over the number list of permutations and have a check if our target number equals to the output of our equations which will be made from taking a number permutation and filling in an operator permutation with it eg. 1 2 3 4 5 6 for numbers and + + - * / for operators. A generic maths equation for 6 numbers and 5 operators will be required eg. ***n O n O n O n O n O n*** (n = number, O = operator), which will be populated by both lists eg. 1 + 2 + 3 - 4 * 5 / 6.
5. If the equation such as above equals our target number, we want to output that equation to an accumulator list, so it can accumulate all of the correct answers for us for display at the end of all comparisons or it will be empty if there are no solutions to reach our target number.

There is a problem with this approach, which is that there are redundant checks, which result in the calculation going into fractions or negative numbers, but it is brute force approach and these redundant checks will not make it, on the correct solution list, which is our accumulator list.
