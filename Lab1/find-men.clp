;;; Завдання 5. Пошук усіх чоловіків
(defrule find-men
   (person (name $?name) (age ?age) (gender male))
   =>
   (printout t "Man found: " (implode$ ?name) ", age " ?age crlf))
