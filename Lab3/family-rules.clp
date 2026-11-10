;;; ЛР3, завдання 1. Виведення речень про родину John правилами

(deftemplate father-of  (slot father) (slot child))
(deftemplate mother-of  (slot mother) (slot child))
(deftemplate parents-of (slot father) (slot mother) (slot child))
(deftemplate role   (slot person) (slot is))
(deftemplate gender (slot person) (slot is))

;; Стратегія depth першим запускає правило для найновішого факту,
;; тому факти role і gender записано у зворотному порядку
(deffacts family
   (father-of  (father Tom)   (child John))
   (mother-of  (mother Susan) (child John))
   (parents-of (father Tom) (mother Susan) (child John))
   (role   (person John)  (is son))
   (role   (person Susan) (is mother))
   (role   (person Tom)   (is father))
   (gender (person John)  (is male))
   (gender (person Susan) (is female))
   (gender (person Tom)   (is male)))

;; Пріоритет salience задає порядок груп речень
(defrule print-father
   (declare (salience 50))
   (father-of (father ?f) (child ?c))
   =>
   (printout t "The father of " ?c " is " ?f "." crlf))

(defrule print-mother
   (declare (salience 40))
   (mother-of (mother ?m) (child ?c))
   =>
   (printout t "The mother of " ?c " is " ?m "." crlf))

(defrule print-parents
   (declare (salience 30))
   (parents-of (father ?f) (mother ?m) (child ?c))
   =>
   (printout t "The parents of " ?c " are " ?f " and " ?m "." crlf))

(defrule print-role
   (declare (salience 20))
   (role (person ?p) (is ?r))
   =>
   (printout t ?p " is a " ?r "." crlf))

(defrule print-gender
   (declare (salience 10))
   (gender (person ?p) (is ?g))
   =>
   (printout t ?p " is a " ?g "." crlf))
