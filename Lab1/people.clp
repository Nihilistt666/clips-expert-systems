;;; Завдання 4. Шаблон person і список фактів people
(deftemplate person
   "Person: name, age, gender"
   (slot name)
   (slot age)
   (slot gender))

(deffacts people
   (person (name Berta) (age 25) (gender female))
   (person (name Ivan)  (age 31) (gender male))
   (person (name Olena) (age 19) (gender female)))
