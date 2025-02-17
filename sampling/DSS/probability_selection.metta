!(register-module! ../../../metta-moses)
!(import! &self metta-moses:utilities:general-helpers)
!(bind! &dataspace (new-space))
(: data_point type)
;;(data_point $index $diff $age $w $probability)

(: data_point (->  $index $diff $age $w $probability data_point))

(= (addToDataSpace $space)
    (add-reduct $space (superpose (
        (data_point 3 3 3 18 0.8780487804878049) 
        (data_point 2 2 1 5 0.24390243902439024) 
        (data_point 1 3 2 13 0.6341463414634146) 
        (data_point 0 2 1 5 0.24390243902439024)

    )))
)
;;select n subset based on probability
;; (data_point 3 3 3 18 0.8780487804878049) (data_point 2 2 1 5 0.24390243902439024) (data_point 1 3 2 13 0.6341463414634146) (data_point 0 2 1 5 0.24390243902439024)

(= (get-data $space) (collapse (match $space ($data $index $D $A $w $pro) $pro)))

(= (to-list $expr)
   (if (== $expr ()) Nil
     (Cons (car-atom $expr)
           (to-list (cdr-atom $expr)))
   )
)
(= (get-data-with-probability  $space $probability)
    ;; ((superpose (match)) (superpose (&self)) ($data $index $D $A $w (superpose $probabilities))  ($data $index $D $A $w) )
    (collapse (match $space ($data $index $D $A $w $probability) ($data $index $D $A $w)))
)
(=(get-data-with-probability' $space $probabilities) (collapse (get-data-with-probability $space (superpose $probabilities))))
;; (= (swap $x $y $accum) 
;;     (let* ( ($newAccum (cons-atom $x $accum)) ($newAccum' (cons-atom $y $newAccum))) $newAccum'))
;; (= (swap' $x $y)
;;     (swap $x $y ())
;; )
(= (reverse-helper $list $accum)
    (if (== $list ())
        $accum
        (let ($head $tail) (decons $list)
            (reverse-helper $tail (cons-atom $head $accum))
        )
    )
)
(= (reverse $list)
     (reverse-helper $list ())
    
)

(= (select $size $list $accum)
    (if (== $size 0)
        $accum
        (let ($head $tail) (decons $list)
            (select (- $size 1) $tail (cons-atom $head $accum)) 
        )
    )
)
!(addToDataSpace &dataspace)
!(get-atoms &dataspace)
;; !(get-type (get-atoms &dataspace))
!(get-data &dataspace)

;; !(let* (
;;     ($prob (get-data &dataspace))
;;     ($length (len $prob))
;;     ($sorted (sort $prob $length >=))
;;     (() (println! (sorted $sorted)))
   
;;     ($selected (select 2 $sorted ()))
;;     (() (println! (selected $selected)))
;; )
;;     (get-data-with-probability' &dataspace $selected)

;; )
;; !(get-data-with-probability (select 2 (reverse (sort (get-data &dataspace) )) ()))

;!(select 2 () (reverse (sort (to-list (collapse (superpose (get-data ())))))))
;; !(reverse (1 2 3 4 5 6 7))
;; !(appendAtom 6 (1 2 3 4 5))