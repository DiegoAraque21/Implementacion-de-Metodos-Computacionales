#lang racket

(provide fibo-1 fibo-2) 

(define (fibo-1 n)
    (cond
        [(= n 0) 0]
        [(= n 1) 1]
        [else (+ (fibo-1 (-n 1)) (fibo-1 (- n 2)))]))

(define (fibo-2 n)
    (cond
        [(= n 0) 0]
        [(= n 1) 1]
        [else (let loop
            ([n (- n 1)] [a 0] [b 1])
            (if(zero? n)
                b
                (loop (sub1 n) b (+ a b))))]))