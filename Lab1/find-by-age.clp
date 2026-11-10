;;; Завдання 5. Пошук людей певного віку (25 років) та старших за 30
(defrule find-age-25
   (person (name $?name) (age 25))
   =>
   (printout t "Age 25: " (implode$ ?name) crlf))

(defrule find-older-30
   (person (name $?name) (age ?age&:(> ?age 30)))
   =>
   (printout t "Older than 30: " (implode$ ?name) ", age " ?age crlf))
