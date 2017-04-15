#lang racket
;https://rosettacode.org/wiki/Combinations_with_repetitions#Racket
;#|
(define gameNumbers (list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100))

(define targetnumber (random 101 1000))
targetnumber

(define random6 null)

(define (randomElement l)
  (define element (list-ref l (random (length l))))
  (set! random6 (cons element random6))
  (set! l (remove element l))
  (if (= (length random6) 6)
      random6
      (randomElement l)))

(randomElement gameNumbers)

(define permutated6 (permutations random6))
(length permutated6)
(set! permutated6 (remove-duplicates permutated6))
(length permutated6)

(define (combinations xs k)
  (cond [(= k 0)     '(())]
        [(empty? xs) '()]
        [(append (combinations (rest xs) k)
                 (map (λ(x) (cons (first xs) x))
                      (combinations xs (- k 1))))]))

(define operators (combinations '(+ - * /) 5))

(define mathsEq 0)
(define accumulator null)
(define value 0)
(define counter 0)

(define ns (make-base-namespace))

(define (equation perms ops numb a)
  (if (null? perms)
      0
      (if (or (and (> (second (first perms)) (first (first perms))) (equal? (first ops) '-))
        (and (> (second (first perms)) (first (first perms))) (equal? (first ops) '/))
        (and (not (= (remainder (first (first perms)) (second (first perms))) 0)) (equal? (first ops) '/))
        (and (< ((eval (first ops) ns) (first (first perms)) (second (first perms))) (third (first perms))) (equal? (first ops) '-))
        (and (< ((eval (first ops) ns) (first (first perms)) (second (first perms))) (third (first perms))) (equal? (first ops) '/))
        (and (equal? (first ops) '/) (not (= (remainder ((eval (first ops) ns) (first (first perms)) (second (first perms))) (third (first perms))) 0)))
         )
         (equation (cdr perms) ops numb a) 
      (begin
      (set! counter (+ counter 1))
      (set! mathsEq (quasiquote ((unquote (fifth ops))((unquote (fourth ops)) ((unquote (third ops)) ((unquote (second ops)) ((unquote (first ops)) (unquote (first (first perms))) (unquote (second (first perms)))) (unquote (third (first perms)))) (unquote (fourth (first perms)))) (unquote(fifth (first perms)))) (unquote(sixth (first perms))))))
      (set! value (eval mathsEq ns))
      (if (= value numb)
          (equation (cdr perms) ops numb (set! accumulator (cons mathsEq accumulator)))
          (equation (cdr perms) ops numb a))))))

(define (mainFunc perms ops numb a)
  (if (null? ops)
      0
      (begin
        (equation perms (car ops) numb a)
        (mainFunc perms (cdr ops) numb a))))

(mainFunc permutated6 operators targetnumber accumulator)

(if (null? accumulator)
    (quote "no solutions found")
    accumulator)

(quasiquote ("iterations:" (unquote counter)))
(quasiquote ("solutions:" (unquote (length accumulator))))