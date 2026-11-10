;;; Завдання 4*. Перевірка динамічних обмежень:
;;; вік передається через змінну, тому статична перевірка його не бачить
(deffacts raw-data
   (raw-age twenty))

(defrule make-person
   (raw-age ?x)
   =>
   (assert (person (name Pavlo) (age ?x) (gender male))))
