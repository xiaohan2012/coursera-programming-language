
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

(define (sequence low high stride)
  (if (> low high)
     null
     (cons low (sequence (+ low stride) high stride))))
     
(define seq-test1 (sequence 3 11 2))
(define seq-test2 (sequence 3 8 3))
(define seq-test3 (sequence 3 2 1))

(define (string-append-map xs suffix)
  (map (lambda (x) (string-append x suffix)) xs))

(define string-list (list "xiao" "feng" "chun" "fei" "shuai" "wang" "guo"))
(define string-append-map-test1 (string-append-map string-list " 540"))
 
(define (list-nth-mod  xs n)
  (cond 
    [(< n 0) (error "list-nth-mod: negative number")]
    [(null? xs) (error "list-nth-mod: empty list")]
    [#t (let ([i (remainder n (length xs))])
          (car (list-tail xs  i )))]))

(define list-nth-mod-test1 (list-nth-mod string-list 7))
(define list-nth-mod-test2 (list-nth-mod (quote (1 2 3 4 5)) 4))

;start "for testing only"
(define (stream-maker fn arg)
  (letrec
      ([f (lambda (x) (cons x (lambda () (f (fn arg x)))))])
    (f arg)))

(define (powers-of-two)
  (stream-maker * 2))
;end for testing only

(define (stream-for-n-steps s n)
  (if (= n 0)
     null
     (let ([ans (s)]) 
       (cons (car ans) (stream-for-n-steps (cdr ans) (- n 1))))))

(define power-sequence (stream-for-n-steps powers-of-two 1))


(define funny-number-stream
  (letrec
      ([f (lambda (x) (cons (if (= (remainder x 5) 0) (- x) x)  
                           (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

(define funny-number-sequence (stream-for-n-steps funny-number-stream 13))

(define (cycle xs)
  (letrec ([f (lambda (ys) (if (null? ys) 
                             (cons (car xs) (lambda () (f (cdr xs)))) ;if empty, start from the begining
                             (cons (car ys) (lambda () (f (cdr ys))))))]); if not empty, go on
    (lambda () (f xs))))

(define dan-then-dog 
  (cycle (list "dan.jpg" "dog.jpg")))

(define abc
  (cycle (list "a" "b" "c")))

(define dan-then-dog-test1 (stream-for-n-steps dan-then-dog 10))
(define abc-test1 (stream-for-n-steps abc 10))

(define (stream-add-zero s)
  (letrec ([ans (s)]
           [f (lambda () (cons (cons 0 (car ans)) (stream-add-zero (cdr ans))))])
    f))

(define add-zero-thunk (stream-add-zero dan-then-dog))
(define added-zeros (stream-for-n-steps add-zero-thunk 10))

(define (cycle-lists xs ys)
  (letrec
      ([xs-stream (cycle xs)] 
       [ys-stream (cycle ys)]
       [f (lambda (x y) 
            (let
             ([x (x)] [y (y)])
             (cons (cons (car x) (car y)) (lambda () (f (cdr x) (cdr y))))))])
    (lambda () (f xs-stream ys-stream))))
    
    
    
(define cycle-lists-test1 (stream-for-n-steps (cycle-lists (list "a" "b" "c") (list "1" "2")) 10))
  
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

(define v1 (vector (cons 1 2) 3 (cons 4 5) (cons 6 7)))
(define pr1 (vector-assoc 1 v1))
(define pr2 (vector-assoc 4 v1))
(define pr3 (vector-assoc 5 v1))

(define (cached-assoc xs n)
  (letrec
      ([cache (make-vector n #f)]
       [slot-idx 0]
       [f (lambda (x)
            (letrec
                ([ans (vector-assoc x cache)])
              (if ans
                 (begin
                   (print "hit")
                   ans)
                 (letrec
                     ([newans (assoc x xs)])
                   (if newans 
                      (begin
                        (print "miss")
                        (vector-set! cache slot-idx newans)
                        (set! slot-idx (modulo (+ slot-idx 1) n))
                        newans)
                      newans)))))])
    f))
                       
(define cached-assoc-for-xs (cached-assoc (list (cons 1 2) (cons 3 3) (cons 4 5) (cons 6 7)) 3))
(define cached-assoc-test1 (cached-assoc-for-xs 1))
(define cached-assoc-test2 (cached-assoc-for-xs 3))
(define cached-assoc-test3 (cached-assoc-for-xs 4))
(define cached-assoc-test4 (cached-assoc-for-xs 3))
(define cached-assoc-test5 (cached-assoc-for-xs 4))
(define cached-assoc-test6 (cached-assoc-for-xs 6))
(define cached-assoc-test7 (cached-assoc-for-xs 1))
(define cached-assoc-test8 (cached-assoc-for-xs 1))