#lang racket

;https://www.mathsisfun.com/combinatorics/combinations-permutations.html
;https://docs.racket-lang.org/reference/generic-numbers.html#%28part._.Random_.Numbers%29

;gamenumbers is our starting list for the game.
(define gameNumbers (list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100))

;Target number defined with random funcions of range 101 to 1000, as the function takes
;max boundary -1. 1000 is excluded from the range.
(define targetnumber (random 101 1000))
targetnumber

;define random6 list to be empty, which will be populated by a function to have random 6
;numbers from gameNumbers list.
(define random6 null)