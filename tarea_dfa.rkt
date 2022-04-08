#|
Simple implementation of a Deterministic Finite Automaton
Used to validate input strings
Example calls:
(automaton-2 (dfa-str 'start '(int var n_sp float exp) delta-arithmetic-1) "a = 3.2e-6 + 4.372e+7 + 7 + 8 ")
Diego Araque and Daniel Sanchez
2022-03-18
|#

#lang racket

(provide automaton-2 operator? sign? delta-arithmetic-1 dfa-str arithmetic-lexer)

(require racket/trace)

; Structure that describes a Deterministic Finite Automaton
(struct dfa-str (initial-state accept-states transitions))

(define (automaton-2 dfa input-string)
  " Evaluate a string to validate or not according to a DFA.
  Return a list of the tokens found"
  (let loop
    ([state (dfa-str-initial-state dfa)]    ; Current state
     [chars (string->list input-string)]    ; List of characters
     [result null]
     [temp-token null])                         ; List of tokens found
    (if (empty? chars)
      ; Check that the final state is in the accept states list
      ;(member state (dfa-str-accept-states dfa))
      (if (member state (dfa-str-accept-states dfa)) 
        (if (not (eq? state 'n_sp))
          (reverse (cons (list (list->string (reverse temp-token)) state) result))
          (reverse result))
        #f)
      ; Recursive loop with the new state and the rest of the list
      (let-values
        ; Get the new token found and state by applying the transition function
        ([(token state) ((dfa-str-transitions dfa) state (car chars))])
        (loop
          state
          (cdr chars)
          ; Update the list of tokens found
          (if token 
                (cons (list (list->string (reverse temp-token)) token) result) 
                result)
          (if (not token) (cons (car chars) temp-token) (if (eq? (car chars) #\space) 
                                                                (list ) 
                                                                (cons (car chars) (list )))))))))

 (define (arithmetic-lexer str)
        (automaton-2 (dfa-str 'start '(int var n_sp float exp par_close) delta-arithmetic-1) str))

(define (operator? char)
  (member char '(#\+ #\- #\* #\/ #\^ #\=)))

(define (sign? char)
  (member char '(#\+ #\-)))

(define (delta-arithmetic-1 state character)
  " Transition to identify basic arithmetic operations "
  (case state
    ['start (cond
              [(char-numeric? character) (values #f 'int)]
              [(eq? character #\space) (values #f 'o_sp)]
              [(eq? character #\( ) (values #f 'par_open)]
              [(sign? character) (values #f 'n_sign)]
              [(or (char-alphabetic? character) (eq? character #\_)) (values #f 'var)]
              [else (values #f 'fail)])]
    ['o_sp (cond
              [(char-numeric? character) (values #f 'int)]
              [(eq? character #\( ) (values #f 'par_open)]
              [(eq? character #\space) (values #f 'o_sp)]
              [(sign? character) (values #f 'n_sign)]
              [(or (char-alphabetic? character) (eq? character #\_)) (values #f 'var)]
              [else (values #f 'fail)])]
    ['n_sp (cond
              [(eq? character #\space) (values #f 'n_sp)]
              [(eq? character #\) ) (values #f 'par_close)]
              [(operator? character) (values #f 'op)]
              [else (values #f 'fail)])]
    ['n_sign (cond
               [(char-numeric? character) (values #f 'int)]
               [else (values #f 'fail)])]
    ['int (cond
            [(char-numeric? character) (values #f 'int)]
            [(eq? character #\space) (values 'int 'n_sp)]
            [(eq? character #\) ) (values 'int 'par_close)]
            [(operator? character) (values 'int 'op)]
            [(or (eq? character #\E) (eq? character #\e))(values #f 'cientific-num-sign)]
            [(eq? character #\.)(values #f 'point)]
            [else (values #f 'fail)])]

    ['point (cond
            [(char-numeric? character) (values #f 'float)]
            [else (values #f 'fail)])]

    ['float (cond
            [(char-numeric? character) (values #f 'float)]
            [(eq? character #\space) (values 'float 'n_sp)]
            [(eq? character #\) ) (values 'float 'par_close)]
            [(or (eq? character #\E) (eq? character #\e))(values #f 'cientific-num-sign)]
            [(operator? character) (values 'float 'op)]
            [else (values #f 'fail)])]

    ['par_open (cond
            [(char-numeric? character) (values 'par_open 'int)]
            [(eq? character #\( ) (values 'par_open 'par_open)]
            [(or (char-alphabetic? character) (eq? character #\_)) (values 'par_open 'var)]
            [(eq? character #\space) (values 'par_open 'o_sp)]
            [(sign? character) (values 'par_open 'n_sign)]
            [else (values #f 'fail)])]

    ['par_close (cond
            [(char-numeric? character) (values 'par_close 'int)]
            [(eq? character #\) ) (values 'par_close 'par_close)]
            [(or (char-alphabetic? character) (eq? character #\_)) (values 'par_close 'var)]
            [(eq? character #\space) (values 'par_close 'n_sp)]
            [(operator? character) (values 'par_close 'op)]
            [else (values #f 'fail)])]

    ['cientific-num-sign (cond
            [(char-numeric? character) (values #f 'exp)]
            [(sign? character) (values #f 'cientific-num-sign-2)]
            [else (values #f 'fail)])]

    
    ['cientific-num-sign-2 (cond
            [(char-numeric? character) (values #f 'exp)]
            [else (values #f 'fail)])]

    
     ['exp(cond
            [(char-numeric? character) (values #f 'exp)]
            [(eq? character #\space) (values 'exp 'n_sp)]
            [(eq? character #\) ) (values 'exp 'par_close)]
            [(operator? character) (values 'exp 'op)]
            [else (values #f 'fail)])]

    
    ['var (cond
            [(or (char-alphabetic? character) (eq? character #\_)) (values #f 'var)]
            [(eq? character #\space) (values 'var 'n_sp)]
            [(eq? character #\) ) (values 'var 'par_close)]
            [(char-numeric? character) (values #f 'var)]
            [(operator? character) (values 'var 'op)]
            [else (values #f 'fail)])]
    ['op (cond
           [(char-numeric? character) (values 'op 'int)]
           [(eq? character #\( ) (values 'op 'par_open)]
           [(eq? character #\space) (values 'op 'o_sp)]
           [(sign? character) (values 'op 'n_sign)]
           [(or (char-alphabetic? character) (eq? character #\_)) (values 'op 'var)]
           [else (values #f 'fail)])]
    ['fail (values #f 'fail)]))