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