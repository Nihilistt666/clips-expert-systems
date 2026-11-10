;;; Завдання 5. Пошук усіх жінок
(defrule find-women
   (person (name $?name) (age ?age) (gender female))
   =>
   (printout t "Woman found: " (implode$ ?name) ", age " ?age crlf))
