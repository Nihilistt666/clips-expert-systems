;;; Завдання 4*. Шаблон person з multislot, type та allowed-values
(deftemplate person
   "Person with slot constraints"
   (multislot name)
   (slot age (type INTEGER))
   (slot gender (allowed-values male female)))

(deffacts people
   (person (name Berta Ida)      (age 25) (gender female))
   (person (name Ivan Petrenko)  (age 31) (gender male))
   (person (name Olena Kovalenko)(age 19) (gender female))
   (person (name Taras Shevchuk) (age 45) (gender male)))
