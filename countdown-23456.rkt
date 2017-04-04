#lang racket

;https://www.mathsisfun.com/combinatorics/combinations-permutations.html
;https://docs.racket-lang.org/reference/generic-numbers.html#%28part._.Random_.Numbers%29
;https://docs.racket-lang.org/reference/pairs.html#%28def._%28%28quote._~23~25kernel%29._list-ref%29%29
;https://www.rosettacode.org/wiki/Pick_random_element
;https://docs.racket-lang.org/reference/pairs.html#%28def._%28%28lib._racket%2Flist..rkt%29._first%29%29
;http://docs.racket-lang.org/reference/quasiquote.html
;http://stackoverflow.com/questions/20147865/flatten-once-procedure

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
;permutated6-filtered is a list which will hold every other element of the permutated6 list.
(define permutated6 (remove-duplicates (permutations random6)))
(length permutated6)

;define list of combinations of size 2 3 4 5 to see if we can find solutions of this size not only solution of size 6
(define size2 (remove-duplicates (combinations random6 2)))
(define size3 (remove-duplicates (combinations random6 3)))
(define size4 (remove-duplicates (combinations random6 4)))
(define size5 (remove-duplicates (combinations random6 5)))

;permutated lists
(define permutated2 null)
(define permutated3 null)
(define permutated4 null)
(define permutated5 null)

;ops is a list of the operators, opsCP is cartisian product
;or permutations with repitition of the ops list
(define ops (list '+ '- '* '/))
(define opsCP6 (cartesian-product ops ops ops ops ops))

;define ops 3 4 5 which we will use to loop over to try and find solutions for lists of size 2 3 4 5
(define opsCP3 (cartesian-product ops ops))
(define opsCP4 (cartesian-product ops ops ops))
(define opsCP5 (cartesian-product ops ops ops ops))

;define our base namespace to allow eval function to eval strings
(define ns (make-base-namespace))

;functions to cons permutations of our combinations to a list
(define (consperms2 list)
  (if (null? list)
    0
    (begin
      (set! permutated2 (cons (permutations (car list)) permutated2))
    (consperms2 (cdr list)))))

(define (consperms3 list)
  (if (null? list)
    0
    (begin
      (set! permutated3 (cons (permutations (car list)) permutated3))
    (consperms3 (cdr list)))))

(define (consperms4 list)
  (if (null? list)
    0
    (begin
      (set! permutated4 (cons (permutations (car list)) permutated4))
    (consperms4 (cdr list)))))

(define (consperms5 list)
  (if (null? list)
    0
    (begin
      (set! permutated5 (cons (permutations (car list)) permutated5))
    (consperms5 (cdr list)))))

(consperms2 size2)
(consperms3 size3)
(consperms4 size4)
(consperms5 size5)

;function to flatten a list by one level, we need this as the previous function of getting
;permutations of combinations give a list such as ( (5 6 8 7) ) and we want to have ((5 6) (8 7))
(define (flattenonce lst)
  (apply append lst))

(set! permutated2 (flattenonce permutated2))
(set! permutated3 (flattenonce permutated3))
(set! permutated4 (flattenonce permutated4))
(set! permutated5 (flattenonce permutated5))

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
(define (equation2 perms ops numb a)
  (if (null? ops)
      0
      (if (or (and (> (second perms) (first perms)) (equal? (first ops) '-))
        (and (> (second perms) (first perms)) (equal? (first ops) '/))
        (and (not (= (remainder (first perms) (second perms)) 0)) (equal? (first ops) '/))
         )
         (equation2 perms (cdr ops) numb a) 
      (begin
       ;increment counter
      (set! counter (+ counter 1))
      ;create maths equation
      (set! mathsEq (quasiquote ((unquote (first ops)) (unquote (first perms)) (unquote (second perms)))))
      ;set value to be the eval of the string maths equation
      (set! value (eval mathsEq ns))
      ;if value == targetnumber, call function again and add mathsEq to accumulator,
      ;otherwise just call the function again.
      (if (= value numb)
          (equation2 perms (cdr ops) numb (set! accumulator (cons mathsEq accumulator)))
          (equation2 perms (cdr ops) numb a))))))

(define (equation3 perms ops numb a)
  (if (null? ops)
      0
      (if (or (and (> (second perms) (first perms)) (equal? (first (first ops)) '-))
        (and (> (second perms) (first perms)) (equal? (first (first ops)) '/))
        (and (not (= (remainder (first perms) (second perms)) 0)) (equal? (first (first ops)) '/))
        (and (< ((eval (first (first ops)) ns) (first perms) (second perms)) (third perms)) (equal? (second (first ops)) '-))
        (and (< ((eval (first (first ops)) ns) (first perms) (second perms)) (third perms)) (equal? (second (first ops)) '/))
        (and (equal? (second (first ops)) '/) (not (= (remainder ((eval (first (first ops)) ns) (first perms) (second perms)) (third perms)) 0)))
         )
         (equation3 perms (cdr ops) numb a) 
      (begin
       ;increment counter
      (set! counter (+ counter 1))
      ;create maths equation
      (set! mathsEq (quasiquote ((unquote (second (first ops))) ((unquote (first (first ops))) (unquote (first perms)) (unquote (second perms))) (unquote (third perms)))))
      ;set value to be the eval of the string maths equation
      (set! value (eval mathsEq ns))
      ;if value == targetnumber, call function again and add mathsEq to accumulator,
      ;otherwise just call the function again.
      (if (= value numb)
          (equation3 perms (cdr ops) numb (set! accumulator (cons mathsEq accumulator)))
          (equation3 perms (cdr ops) numb a))))))

(define (equation4 perms ops numb a)
  (if (null? ops)
      0
      (if (or (and (> (second perms) (first perms)) (equal? (first (first ops)) '-))
        (and (> (second perms) (first perms)) (equal? (first (first ops)) '/))
        (and (not (= (remainder (first perms) (second perms)) 0)) (equal? (first (first ops)) '/))
        (and (< ((eval (first (first ops)) ns) (first perms) (second perms)) (third perms)) (equal? (second (first ops)) '-))
        (and (< ((eval (first (first ops)) ns) (first perms) (second perms)) (third perms)) (equal? (second (first ops)) '/))
        (and (equal? (second (first ops)) '/) (not (= (remainder ((eval (first (first ops)) ns) (first perms) (second perms)) (third perms)) 0)))
         )
         (equation4 perms (cdr ops) numb a) 
      (begin
       ;increment counter
      (set! counter (+ counter 1))
      ;create maths equation
      (set! mathsEq (quasiquote ((unquote (third (first ops))) ((unquote (second (first ops))) ((unquote (first (first ops))) (unquote (first perms)) (unquote (second perms))) (unquote (third perms))) (unquote (fourth perms)))))
      ;set value to be the eval of the string maths equation
      (set! value (eval mathsEq ns))
      ;if value == targetnumber, call function again and add mathsEq to accumulator,
      ;otherwise just call the function again.
      (if (= value numb)
          (equation4 perms (cdr ops) numb (set! accumulator (cons mathsEq accumulator)))
          (equation4 perms (cdr ops) numb a))))))

(define (equation5 perms ops numb a)
  (if (null? ops)
      0
      (if (or (and (> (second perms) (first perms)) (equal? (first (first ops)) '-))
        (and (> (second perms) (first perms)) (equal? (first (first ops)) '/))
        (and (not (= (remainder (first perms) (second perms)) 0)) (equal? (first (first ops)) '/))
        (and (< ((eval (first (first ops)) ns) (first perms) (second perms)) (third perms)) (equal? (second (first ops)) '-))
        (and (< ((eval (first (first ops)) ns) (first perms) (second perms)) (third perms)) (equal? (second (first ops)) '/))
        (and (equal? (second (first ops)) '/) (not (= (remainder ((eval (first (first ops)) ns) (first perms) (second perms)) (third perms)) 0)))
         )
         (equation5 perms (cdr ops) numb a) 
      (begin
       ;increment counter
      (set! counter (+ counter 1))
      ;create maths equation
      (set! mathsEq (quasiquote ((unquote (fourth (first ops))) ((unquote (third (first ops))) ((unquote (second (first ops))) ((unquote (first (first ops))) (unquote (first perms)) (unquote (second perms))) (unquote (third perms))) (unquote (fourth perms))) (unquote(fifth perms)))))
      ;set value to be the eval of the string maths equation
      (set! value (eval mathsEq ns))
      ;if value == targetnumber, call function again and add mathsEq to accumulator,
      ;otherwise just call the function again.
      (if (= value numb)
          (equation5 perms (cdr ops) numb (set! accumulator (cons mathsEq accumulator)))
          (equation5 perms (cdr ops) numb a))))))

(define (equation6 perms ops numb a)
  (if (null? ops)
      0
      (if (or (and (> (second perms) (first perms)) (equal? (first (first ops)) '-))
        (and (> (second perms) (first perms)) (equal? (first (first ops)) '/))
        (and (not (= (remainder (first perms) (second perms)) 0)) (equal? (first (first ops)) '/))
        (and (< ((eval (first (first ops)) ns) (first perms) (second perms)) (third perms)) (equal? (second (first ops)) '-))
        (and (< ((eval (first (first ops)) ns) (first perms) (second perms)) (third perms)) (equal? (second (first ops)) '/))
        (and (equal? (second (first ops)) '/) (not (= (remainder ((eval (first (first ops)) ns) (first perms) (second perms)) (third perms)) 0)))
         )
         (equation6 perms (cdr ops) numb a) 
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
          (equation6 perms (cdr ops) numb (set! accumulator (cons mathsEq accumulator)))
          (equation6 perms (cdr ops) numb a))))))

;main function which is called to run the project,
(define (mainFunc2 perms ops numb a)
  (if (null? perms)
      0
      (begin
        ;call equation function to make equations for car of perms list vs whole list
        ;of operators
        (equation2 (car perms) ops numb a)
        ;after call mainfunc with next element on perms list
        (mainFunc2 (cdr perms) ops numb a))))

(define (mainFunc3 perms ops numb a)
  (if (null? perms)
      0
      (begin
        ;call equation function to make equations for car of perms list vs whole list
        ;of operators
        (equation3 (car perms) ops numb a)
        ;after call mainfunc with next element on perms list
        (mainFunc3 (cdr perms) ops numb a))))

(define (mainFunc4 perms ops numb a)
  (if (null? perms)
      0
      (begin
        ;call equation function to make equations for car of perms list vs whole list
        ;of operators
        (equation4 (car perms) ops numb a)
        ;after call mainfunc with next element on perms list
        (mainFunc4 (cdr perms) ops numb a))))

(define (mainFunc5 perms ops numb a)
  (if (null? perms)
      0
      (begin
        ;call equation function to make equations for car of perms list vs whole list
        ;of operators
        (equation5 (car perms) ops numb a)
        ;after call mainfunc with next element on perms list
        (mainFunc5 (cdr perms) ops numb a))))

(define (mainFunc6 perms ops numb a)
  (if (null? perms)
      0
      (begin
        ;call equation function to make equations for car of perms list vs whole list
        ;of operators
        (equation6 (car perms) ops numb a)
        ;after call mainfunc with next element on perms list
        (mainFunc6 (cdr perms) ops numb a))))

;call function
(mainFunc2 permutated2 ops targetnumber accumulator)
(mainFunc3 permutated3 opsCP3 targetnumber accumulator)
(mainFunc4 permutated4 opsCP4 targetnumber accumulator)
(mainFunc5 permutated5 opsCP5 targetnumber accumulator)
(mainFunc6 permutated6 opsCP6 targetnumber accumulator)

(set! accumulator (reverse accumulator))
;output of solutions, if there are any
(if (null? accumulator)
    (quote (no solutions found))
    accumulator)

(quasiquote ("iterations:" (unquote counter)))
(quasiquote ("solutions:" (unquote (length accumulator))))