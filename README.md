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

From further investigation into the patterns.txt file and manually looking at permutations, I have come to the conclusion that taking out every other element to shorten the length
of the permutation list, only works 50% of the time or only with + and * operators. This is simply based on what number list we get Eg. 3 5 2 6 7 8, taking out the next permutation of
5 3 2 6 7 8 is not good here as the first permutation will be handled by if statements which will not allow the equation going into negatives ie. subtracting a larger number from a
smaller one or doing the same thing with division. These few simple rules of not allowing remainders on division and negative numbers from subtraction will take care of cutting out half the list
and iterations anyways.

Added countdown-23456 file, which also checks for solutions of sizes 2 3 4 and 5. The code is very repetive as I worked from the size 6 methods and lists. I Cant get around to writing a more
general function to handle different sized lists as I need 5 different lists of numbers and operators and equation patterns, hence the code is poor.
This addition is adding around 100 thousand extra iterations to the overall run time making it now a total of around 400 thousand iterations when all of the game numbers are distinct.

Some maths, adding lists of size 2 3 4 and 5 require to get combinations of the specific size and then permutations of each element as well.

6 choose 2 gives 15 combinations and 15 x 2! gives a permutated list of size 2 elements with 30 elements. For 2 operands we will need 1 operator. We have only 4 choices for our operand, which gives us 4 and 30 x 4 posible checks which evaluates to 120 iterations.

6 choose 3 gives 20 combinations and 20 x 3! gives a permutated list of size 3 elements with 120 elements. For 3 operands we will need 2 operators. For 2 operators we have a choice of 4 x 4, which gives us 16 and 120 x 16 posible checks which evaluates to 1920 iterations.

6 choose 4 gives 15 combinations and 15 x 4! gives a permutated list of size 4 elements with 360 elements. For 4 operands we will need 3 operators. For 3 operators we have a choice of 4 x 4 x 4, which gives us 64 and 360 x 64 posible checks which evaluates to 23040 iterations.

6 choose 5 gives 6 combinations and 6 x 5! gives a permutated list of size 5 elements with 720 elements. For 5 operands we will need 4 operators. For 4 operators we have a choice of 4 x 4 x 4 x 4, which gives us 256 and 720 x 256 posible checks which evaluates to 184320 iterations.

#### Reviewing my approach

After doing some more research and thinking about this problem from a maths perspective, I cannot come up with a better solution than a brute force search of checking number permutations vs cartesian product of our operators. This makes 720 x 1024, which is 737280 checks but with some if statement logic we can cut that number in half or close to half, by simply checking our equation to not go into negatives or remainders on division. 

From testing I did find that there are posbile solutions where the equation starts out by going into a fraction but in this project that is not what we are looking for.

Adding almost the same code for another 4 lists of operands and operators, I added a file which checks solutions of sizes 2 3 4 5 and this adds around 100 thousand extra iterations to the program. As seen above the extra lists of size 2 3 4 5 add up to around 210 thousand iterations but that is cut in half by our if statements mentioned above. For the code itself I cannot come up with a way to write a more general function to handle all of my lists as there are 8 extra lists of all different sizes and they need 4 different types of equation blueprint hence repetitive code.

One other approach that I have tried and tested is checking combinations of operators vs permutations of operands. This gives us 56 combinations of operators and still 720 permutations for a list of size 6 with 5 operators. This gives 40320 iterations if all numbers are distinct. This 40 thousand looks a lot better than the 737 thousand for the other approach but this approach from testing it quite a lot seems to leave out some solutions. This is because combinations do not have order and there are some other distinct solutions which need a specific order of the operators, however the first approach does find those solutions with the expense of more iterations and checking.
