;;; One variant of the Fermat test that cannot be fooled is called the
;;; Miller-Rabin test (Miller 1976; Rabin 1980). This starts from an
;;; alternate form of Fermat’s Little Theorem, which states that if n
;;; is a prime number and a is any positive integer less than n, then
;;; a raised to the (n - 1)st power is congruent to 1 modulo n.
;;;
;;; To test the primality of a number n by the Miller-Rabin test, we
;;; pick a random number a < n and raise a to the (n - 1)st power modulo
;;; n using the expmod procedure. However, whenever we perform the
;;; squaring step in expmod, we check to see if we have discovered a
;;; "nontrivial square root of 1 modulo n," that is, a number not equal
;;; to 1 or n - 1 whose square is equal to 1 modulo n. It is possible
;;; to prove that if such a nontrivial square root of 1 exists, then
;;; n is not prime. It is also possible to prove that if n is an odd
;;; number that is not prime, then, for at least half the numbers a < n,
;;; computing a n - 1 in this way will reveal a nontrivial square root of
;;; 1 modulo n. (This is why the Miller-Rabin test cannot be fooled.)
;;;
;;; Modify the expmod procedure to signal if it discovers a nontrivial
;;; square root of 1, and use this to implement the Miller-Rabin test
;;; with a procedure analogous to fermat-test. Check your procedure by
;;; testing various known primes and non-primes. Hint: One convenient
;;; way to make expmod signal is to have it return 0.

(define (mr-expmod b n m)
  (define (mr-sqmod x)
    (define (mr-sqmod-check x y)
      (if (and (not (or (= x 1)
                        (= x (- m 1))))
               (= y 1))
          0
          y))
    (mr-sqmod-check x (remainder (square x) m)))
  (cond ((= n 0) 1)
        ((even? n)
         (mr-sqmod (mr-expmod b (/ n 2) m)))
        (else
          (remainder (* b (mr-expmod b (- n 1) m))
                     m))))

(define (mr-test n)
  (define (try-it a)
    (= (mr-expmod a (- n 1) n) 1))
  (try-it (+ 1 (random (- n 1)))))

(define (smart-prime? n times)
  (cond ((= times 0) true)
        ((mr-test n) (smart-prime? n (- times 1)))
        (else false)))

(define (prime? n)
  (smart-prime? n 100))

;;; Prime Numbers
(prime? 37)
(prime? 101)
(prime? 1009)
(prime? 131071)
(prime? 524287)

;;; Carmichael Numbers
(prime? 561)
(prime? 1105)
(prime? 1729)
(prime? 2465)
(prime? 2821)
(prime? 6601)


