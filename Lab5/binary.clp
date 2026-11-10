;;; ЛР5, індивідуальне завдання 8.
;;; Додавання двох двійкових чисел без арифметичних функцій.
;;; Цифри числа записуються окремими значеннями: (digits 1 0 1 1 1)

(deftemplate binary-#
   (multislot name)
   (multislot digits))

;; запит: скласти числа з іменами name-1 і name-2
(deftemplate add-binary-#s
   (slot name-1)
   (slot name-2))

;; робочий стан додавання «стовпчиком» справа наліво
(deftemplate adding
   (slot name-1) (slot name-2)
   (multislot rest-1)      ; ще не оброблені цифри першого числа
   (multislot rest-2)      ; ще не оброблені цифри другого числа
   (slot carry)            ; перенос у наступний розряд
   (multislot result))     ; уже отримані цифри суми

;; таблиця додавання одного розряду: a + b + перенос = s, новий перенос
(deftemplate bit-sum
   (slot a) (slot b) (slot c) (slot s) (slot carry))

(deffacts addition-table
   (bit-sum (a 0) (b 0) (c 0) (s 0) (carry 0))
   (bit-sum (a 0) (b 0) (c 1) (s 1) (carry 0))
   (bit-sum (a 0) (b 1) (c 0) (s 1) (carry 0))
   (bit-sum (a 0) (b 1) (c 1) (s 0) (carry 1))
   (bit-sum (a 1) (b 0) (c 0) (s 1) (carry 0))
   (bit-sum (a 1) (b 0) (c 1) (s 0) (carry 1))
   (bit-sum (a 1) (b 1) (c 0) (s 0) (carry 1))
   (bit-sum (a 1) (b 1) (c 1) (s 1) (carry 1)))

;; початок: знаходимо обидва числа і створюємо робочий факт
(defrule start-adding
   ?q <- (add-binary-#s (name-1 ?n1) (name-2 ?n2))
   (binary-# (name ?n1) (digits $?d1))
   (binary-# (name ?n2) (digits $?d2))
   =>
   (retract ?q)
   (assert (adding (name-1 ?n1) (name-2 ?n2)
                   (rest-1 $?d1) (rest-2 $?d2) (carry 0) (result))))

;; крок: в обох числах ще є цифри
(defrule add-both
   ?f <- (adding (rest-1 $?r1 ?a) (rest-2 $?r2 ?b)
                 (carry ?c) (result $?res))
   (bit-sum (a ?a) (b ?b) (c ?c) (s ?s) (carry ?co))
   =>
   (modify ?f (rest-1 $?r1) (rest-2 $?r2) (carry ?co) (result ?s $?res)))

;; крок: цифри лишилися тільки в першому числі
(defrule add-first-only
   ?f <- (adding (rest-1 $?r1 ?a) (rest-2) (carry ?c) (result $?res))
   (bit-sum (a ?a) (b 0) (c ?c) (s ?s) (carry ?co))
   =>
   (modify ?f (rest-1 $?r1) (carry ?co) (result ?s $?res)))

;; крок: цифри лишилися тільки в другому числі
(defrule add-second-only
   ?f <- (adding (rest-1) (rest-2 $?r2 ?b) (carry ?c) (result $?res))
   (bit-sum (a 0) (b ?b) (c ?c) (s ?s) (carry ?co))
   =>
   (modify ?f (rest-2 $?r2) (carry ?co) (result ?s $?res)))

;; кінець: цифр немає, останній перенос дописуємо попереду
(defrule finish-adding
   ?f <- (adding (name-1 ?n1) (name-2 ?n2) (rest-1) (rest-2)
                 (carry ?c) (result $?res))
   =>
   (retract ?f)
   (if (eq ?c 1) then (bind ?res (create$ 1 ?res)))
   (assert (binary-# (name ?n1 + ?n2) (digits ?res)))
   (bind ?text "")                          ; склеюємо цифри в один рядок
   (progn$ (?d ?res) (bind ?text (str-cat ?text ?d)))
   (printout t ?n1 " + " ?n2 " = " ?text crlf))

(deffacts test-numbers
   (binary-# (name A) (digits 1 0 1 1 1))
   (binary-# (name B) (digits 1 1 1 0))
   (add-binary-#s (name-1 A) (name-2 B)))
