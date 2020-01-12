;;;; Exercise 1.29

;;; Exercise 1.29. Simpson’s Rule is a more accurate method of
;;; numerical integration than the method illustrated above.
;;; Using Simpson’s Rule, the integral of a function f between
;;; a and b is approximated as
;;;
;;; (h / 3) * (y_0 + 4 * y_1 + 2 * y_2 + 4 * y_3 + 2 * y_4 + ...
;;; + 2 * y_(n - 2) + 4 * y_(n - 1) + y_n)
;;;
;;; where h = (b - a) / n, for some
;;; even integer n, and y_k = f(a + kh). (Increasing n increases
;;; the accuracy of the approximation.) Define a procedure that
;;; takes as arguments f, a, b, and n and returns the value of
;;; the integral, computed using Simpson’s Rule. Use your procedure
;;; to integrate cube between 0 and 1 (with n = 100 and n = 1000),
;;; and compare the results to those of the integral procedure
;;; shown above.

(define (cube x) (* x x x))

(define (inc n) (+ n 1))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (integral f a b n)
  (define h (/ (- b a) n))
  (define (term k)
    (define y (f (+ a (* k h))))
    (cond ((or (= k 0) (= k n)) y)
          ((odd? k) (* 4 y))
          (else (* 2 y))))
  (* (/ h 3.0) (sum term 0 inc n)))

(integral cube 0 1 100)
(integral cube 0 1 1000)
