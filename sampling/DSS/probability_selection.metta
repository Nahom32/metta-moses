!(register-module! ../../../metta-moses)
!(import! &self metta-moses:utilities:general-helpers)
! (bind! power (py-atom pow))
!(bind! &dataspace (new-space))
!(bind! &subspace (new-space))


;;(data_point $index $diff $age $w $probability)

(: data_point (->  $index $diff $age $w $probability data_point))

;;This function adds points to a DataSpace
;;
(= (addToDataSpace $space)
    (add-reduct $space (superpose (
        (data_point 3 3 3 18 0.8780487804878049) 
        (data_point 2 2 1 5 0.24390243902439024) 
        (data_point 1 3 2 13 0.6341463414634146) 
        (data_point 0 2 1 5 0.24390243902439024)

    )))
)

(=(fitness-weight (data_point $index $D $A $w $p) $d $a)
    (let* (
          ($Di  ((py-dot power pow) $D $d))
          ($Ai  ((py-dot power pow) $A $a))
          ($wi  (+ $Di  $Ai))
         )
         (data_point $index $D $A $wi $p)
    )
)

;;This function calculates the total probability of selection.
(= (compute_probability ($data_point $index $diff $age $w $probability $Wip) $total_fitness_weight)
    (let $newProbability (/ $Wip $total_fitness_weight) 
        ($data_point $index $diff $age $w $newProbability)
    )
)
;;select n subset based on probability
;; (data_point 3 3 3 18 0.8780487804878049) (data_point 2 2 1 5 0.24390243902439024) (data_point 1 3 2 13 0.6341463414634146) (data_point 0 2 1 5 0.24390243902439024)

(= (get-data $space) (collapse (match $space ($data $index $D $A $w $pro) $pro)))


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
(=(get-data-dss $size $dataspace)
    (let* (
        ($prob (get-data &dataspace))
        ($length (len $prob))
        ($sorted (sort $prob $length >=))
        (() (println! (sorted $sorted)))
    
        ($selected (select $sorted $sorted ()))
        (() (println! (selected $selected)))
    )
    (get-data-with-probability' &dataspace $selected)

)   
)



;; !(get-data-with-probability (select 2 (reverse (sort (get-data &dataspace) )) ()))

;!(select 2 () (reverse (sort (to-list (collapse (superpose (get-data ())))))))
;; !(reverse (1 2 3 4 5 6 7))
;; !(appendAtom 6 (1 2 3 4 5))