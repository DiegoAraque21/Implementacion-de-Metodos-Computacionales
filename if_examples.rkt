#lang racket

(provide get-sign get-sign-2 month-days next-day)

(define (get-sign number)
    "Return wheter a number is positive or negative or zero"
    (if (zero? number)
        'zero
        (if (> number)
            'positive
            'negative)))

(define (get-sign-2 number)
    (cond
        [(zero? number) 'zero]
        [(> number 0) 'positive]
        [else 'negative]))

(define (month-days month)
    (case month
        [(2) (if(leap-year? year) 29 28)]
        [(1 3 5 7 8 10 12) 31]
        [(4 6 9 11) 30]))

(define (leap-year? year)
    (if (modulo (/(year 4)))
        #t
        (if (and(modulo (/(year 4))) (/(year 100)))
            #f
        )
    )
)

(define (next-day day month year)
    ; Check if today is the last day of the month
    (if (= day (month-days month year))
        (if (= month 12)
            (values 1 1 (+ year 1))
            (values 1 (+ month 1) year))
        (values (+ day 1) month year)))

