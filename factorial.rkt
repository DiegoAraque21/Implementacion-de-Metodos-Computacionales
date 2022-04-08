#lang racket

(provide fact fact-tail fact-2 !)

(require racket/trace)

(define (fact n)
    "Regular recursion for factorial"
    (if (zero? n)
        1
        (* n(fact(- n 1)))))

(define (fact-tail n a)
    "Tail recursive version"
    (if (zero? n)
        a
        (fact-tail (- n 1)(* n a))))
(fact-tail n 1)

(define (fact-2 n)
    "Entry function for the tail recursion"
    (fact-tail n 1))

(define (! n)
    (let loop
        ([n n] [a 1])
        (if (zero? n)
            a
            [loop (- n 1)(* n a)])))
