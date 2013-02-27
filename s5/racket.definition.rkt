#lang racket

(define a 5) ; like val a=5

(define six (+ a 1)) ; + is a function

(define (pow1 x y) 
  (if (= y 0) ; if (expression to be tested) (then exp) (else expx)
     1
     (* x (pow1 x (- y 1)))))

(define pow2 ; curried version, binding anonymous function to pow2
  (lambda (x)
    (lambda (y)
      (pow1 x y))))

(define sixteen1 (pow1 2 4))
(define sixteen2 ((pow2 2) 4)) ; but calling the curried function is a little bit complex