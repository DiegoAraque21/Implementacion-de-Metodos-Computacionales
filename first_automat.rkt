#|
Simple implementation of a Deterministic Finite Automaton
Used to validate input strings
Example calls:
(automaton-1 (dfa-str 'q0 '(q2) delta-ab) "ab")
Diego Araque
2022-03-18
|#

#lang racket

; Structure that describes a Deterministic Finite Automaton
(struct dfa-str (initial-state accept-states transitions))

(define (automaton-1 dfa input-string)
  " Evaluate a string to validate or not according to
  a DFA "
  (let loop
    ([state (dfa-str-initial-state dfa)]    ; Current state
     [chars (string->list input-string)])   ; List of characters
    (if (empty? chars)
      ; Check that the final state is in the accept states list
      (member state (dfa-str-accept-states dfa))
      ; Recursive loop with the new state and the rest of the list
      (loop
        ; Get the new state by applying the transition function
        ((dfa-str-transitions dfa) state (car chars))
        ; Call again with the rest of the characters
        (cdr chars)))))


(define (delta-ab state character)
  " Transition function for an automaton
  that accepts only the string ab "
  (case state
    ['q0 (case character
             [(#\a) 'q1]
             [(#\b) 'q3])]
    ['q1 (case character
             [(#\a) 'q3]
             [(#\b) 'q2])]
    ['q2 (case character
             [(#\a) 'q3]
             [(#\b) 'q3])]
    ; Fail state
    ['q3 'q3]))



(define (delta-aab state character)
  " Transition function for an automaton that accepts strings that contain b,
  with an even number of a's before the first b "
  (case state
    ['q0 (case character
             [(#\a) 'q2]
             [(#\b) 'q1])]
    ['q1 (case character
             [(#\a) 'q1]
             [(#\b) 'q1])]
    ['q2 (case character
             [(#\a) 'q0]
             [(#\b) 'q3])]
    ; Fail state
    ['q3 'q3]))
