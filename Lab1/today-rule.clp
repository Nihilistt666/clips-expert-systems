;;; Завдання 3. Просте правило: виведення дня тижня
(defrule what-day-today
   "Prints the day of the week found in fact (Today is ?day)"
   (Today is ?day)
   =>
   (printout t "Today is " ?day crlf))
