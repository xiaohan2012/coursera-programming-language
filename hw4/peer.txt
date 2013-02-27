
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

;Problem  1
(define (sequence low high stride)
  (if (> low high)
     null
     (cons low (sequence (+ low stride) high stride))))

;Problem  2
(define (string-append-map xs suffix)
  (map (lambda (x) (string-append x suffix)) xs))

;Problem  3 
(define (list-nth-mod  xs n)
  (cond 
    [(< n 0) (error "list-nth-mod: negative number")]
    [(null? xs) (error "list-nth-mod: empty list")]
    [#t (let ([i (remainder n (length xs))])
          (car (list-tail xs  i )))]))

;Problem  4
(define (stream-for-n-steps s n)
  (if (= n 0)
     null
     (let ([ans (s)]) 
       (cons (car ans) (stream-for-n-steps (cdr ans) (- n 1))))))

;Problem  5
(define funny-number-stream
  (letrec
      ([f (lambda (x) (cons (if (= (remainder x 5) 0) (- x) x)  
                           (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

; helper function for `dan-then-dog` and `cycle-lists`;
; Demo: 
; given a list, (1 2 3)
; produces a stream (1 2 3 1 2 3 1 2 3 ...)
(define (cycle xs)
  (letrec ([f (lambda (ys) (if (null? ys) 
                             (cons (car xs) (lambda () (f (cdr xs)))) ;if empty, start from the begining
                             (cons (car ys) (lambda () (f (cdr ys))))))]); if not empty, go on
    (lambda () (f xs))))

;Problem  6
(define dan-then-dog 
  (cycle (list "dan.jpg" "dog.jpg")))

;Problem  7
(define (stream-add-zero s)
  (letrec ([ans (s)]
           [f (lambda () (cons (cons 0 (car ans)) (stream-add-zero (cdr ans))))])
    f))

;Problem  8
(define (cycle-lists xs ys)
  (letrec
      ([xs-stream (cycle xs)] 
       [ys-stream (cycle ys)]
       [f (lambda (x y) 
            (let
             ([x (x)] [y (y)])
             (cons (cons (car x) (car y)) (lambda () (f (cdr x) (cdr y))))))])
    (lambda () (f xs-stream ys-stream))))

;Problem  9
(define (vector-assoc v vec)
  (letrec
      ([f (lambda (i) 
            (if (= (vector-length vec) i)
               #f
               (letrec
                   ([e (vector-ref vec i)])
                 (cond
                   [(not (pair? e)) (f (+ i 1))]
                   [(equal? (car e) v) e]
                   [#t (f (+ i 1))]))))])   
       (f 0)))

;Problem  10
(define (cached-assoc xs n)
  (letrec
      ([cache (make-vector n #f)]
       [slot-idx 0]
       [f (lambda (x)
            (letrec
                ([ans (vector-assoc x cache)])
              (if ans
                   ans
                 (letrec
                     ([newans (assoc x xs)])
                   (if newans 
                      (begin
                        (vector-set! cache slot-idx newans)
                        (set! slot-idx (modulo (+ slot-idx 1) n))
                        newans)
                      newans)))))])
    f))
                       