#lang racket

(provide average suma binary dot-product standard-deviation pow factorial fahrenheit-to-celsius roots binary-operation)


;EXERCISE 1

(define (fahrenheit-to-celsius far)
    (exact->inexact
       (/ (* 5 (- far 32)) 9)))



;EXERCISE 3

(define (roots a b c)
  (/ (+ (- 0 b) (sqrt (- (* b b) (* 4 a c) ) ) ) (* 2 a)))

;EXERCISE 5

(define (factorial n)
  (if(zero? n)1 (* n (factorial(- n 1)))))


;EXERCISE 7

(define (pow a b)
  (expt a b))



;EXERCISE 15

(define (dot-product a b)
    (apply + (for/list ([i a] [ii b]) (* i ii))))


;EXERCISE 16
(define (average lst)
    (if (empty? lst)
        0
        (/ (suma lst) (length lst))))

;Recursive function, with cdr we are selecting every number that isn't the last one and doing all the necessary sums
(define (suma lst)
    ; we call suma recursively in this function so we can sum every value of this list to each other
    (+ (car lst) (suma (cdr lst))))


;EXERCISE 17

(define (standard-deviation lst)
  (sqrt (/ (apply + (for/list ([i lst])
      (pow (- i (/ (apply + (for/list ([ii lst])
        (+ ii 0))) (length lst))) 2)))
          (length lst))))


;EXERCISE 20

(define (binary-operation n lst)
  (cond
    ; if n < 0 a list is returned
    [(= n 0) lst]
    ;if n >=1 calls the function agains but with the quotient of n and 2 as our new n and the list is updated with the remainder of n/2 
    [(>= n 1) (binary-operation (quotient n 2) (append (list (remainder n 2)) lst))]))

(define (binary n)
  (binary-operation n '()))



