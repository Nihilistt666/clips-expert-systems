;;; Завдання 5. Пошук людини з певним ім'ям (перше ім'я Ivan)
(defrule find-by-name
   (person (name Ivan $?rest) (age ?age) (gender ?g))
   =>
   (printout t "Person with name Ivan: Ivan " (implode$ ?rest)
               ", age " ?age ", gender " ?g crlf))
