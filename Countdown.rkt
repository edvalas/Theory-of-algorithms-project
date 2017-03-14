#lang racket

;https://www.mathsisfun.com/combinatorics/combinations-permutations.html
;https://docs.racket-lang.org/reference/generic-numbers.html#%28part._.Random_.Numbers%29
;https://docs.racket-lang.org/reference/pairs.html#%28def._%28%28quote._~23~25kernel%29._list-ref%29%29
;https://www.rosettacode.org/wiki/Pick_random_element

;gamenumbers is our starting list for the game.
(define gameNumbers (list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100))

;Target number defined with random funcions of range 101 to 1000, as the function takes
;max boundary -1. 1000 is excluded from the range.
(define targetnumber (random 101 1000))
targetnumber

;define random6 list to be empty, which will be populated by a function to have random 6
;numbers from gameNumbers list.
(define random6 null)

;Function to select 6 random elements from the gameNumbers list, pass in the list
(define (randomElement l)
  ;element is our random element from the list. List-ref return an element from a list at given index
  ;our index is random function and we give it length of the list.
  (define element (list-ref l (random (length l))))
  ;use set! to set random6 to add the random element to the list of random6 numbers.
  (set! random6 (cons element random6))
  ; use set! to remove our random element from the gameNumbers list as we dont want to pick it
  ;multiple times.
  (set! l (remove element l))
  ;if the length of our random6 numbers is 6 then output the list,
  ;otherwise call the function again.
  (if (= (length random6) 6)
      random6
      (randomElement l)))

;call function to add 6 random elements to our null list random6 from gameNumbers list.
(randomElement gameNumbers)

;permutated6 is a list of our random6 numbers list but permutated
;for later use to create all permutations of equations. Also
;use remove duplicates function to remove permutations that are the same,
;if 2 of same numbers are picked..
(define permutated6 (remove-duplicates (permutations random6)))
(length permutated6)

;ops is a list of the operators, opsCP is cartisian product
;or permutations with repitition of the ops list
(define ops (list '+ '- '* '/))
(define opsCP (cartesian-product ops ops ops ops ops))
(length opsCP)

;define our base namespace to allow eval function to eval strings
(define ns (make-base-namespace))

;variable that will hold the maths equation
(define mathsEq 0)
;accumulator which will hold correct solutions
(define accumulator null)
;value variable which holds the evaluation of each maths equation,
;which is compared to the target number
(define value 0)
;counter to count how many iterations occur
(define counter 0)

;(+(-(+(/(- 10 2)2)2)3)1) = 4
;function that takes a list of numbers and operators and constructs a maths equation,
;sets it equal to the mathsEq variable to we can use it and evaluate it.
(define (equation perms ops numb a)
  (if (null? ops)
      0
      (begin
       ;increment counter
      (set! counter (+ counter 1))
      ;create maths equation
      (set! mathsEq (quasiquote ((unquote (fifth (first ops)))((unquote (fourth (first ops))) ((unquote (third (first ops))) ((unquote (second (first ops))) ((unquote (first (first ops))) (unquote (first perms)) (unquote (second perms))) (unquote (third perms))) (unquote (fourth perms))) (unquote(fifth perms))) (unquote(sixth perms)))))
      ;set value to be the eval of the string maths equation
      (set! value (eval mathsEq ns))
      ;if value == targetnumber, call function again and add mathsEq to accumulator,
      ;otherwise just call the function again.
      (if (= value numb)
          (equation perms (cdr ops) numb (set! accumulator (cons mathsEq accumulator)))
          (equation perms (cdr ops) numb a)))))

;main function which is called to run the project,
(define (mainFunc perms ops numb a)
  (if (null? perms)
      0
      (begin
        ;call equation function to make equations for car of perms list vs whole list
        ;of operators
        (equation (car perms) ops numb a)
        ;after call mainfunc with next element on perms list
        (mainFunc (cdr perms) ops numb a))))

;call function
(mainFunc permutated6 opsCP targetnumber accumulator)

(quasiquote ("iterations:" (unquote counter)))
(quasiquote ("solutions:" (unquote (length accumulator))))

;output of solutions, if there are any
(if (null? accumulator)
    (quote (no solutions found))
    accumulator)