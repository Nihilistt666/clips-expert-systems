;;; ЛР3, завдання 2, варіант 2. Визначення класу пожежі та вогнегасників

;; вхідний факт: що горить
(deftemplate burning-material
   (slot name))

;; проміжний висновок: клас пожежі
(deftemplate fire
   (slot category (allowed-values A B C D)))

;; ---------- класифікація пожежі ----------
(defrule class-A
   (burning-material (name paper | wood | cloth))
   =>
   (assert (fire (category A))))

(defrule class-B
   (burning-material (name oil | gas | grease | gasoline))
   =>
   (assert (fire (category B))))

(defrule class-C
   (burning-material (name energized-electrical-equipment))
   =>
   (assert (fire (category C))))

(defrule class-D
   (burning-material (name magnesium | sodium | potassium))
   =>
   (assert (fire (category D))))

(defrule unknown-material
   (declare (salience -10))
   (burning-material (name ?m))
   (not (fire))
   =>
   (printout t
      "Material " ?m " is unknown, the fire class cannot be found." crlf))

;; ---------- вибір вогнегасника ----------
(defrule extinguish-A
   (fire (category A))
   =>
   (printout t "Class A fire: ordinary combustibles." crlf)
   (printout t
      "  Use heat-absorbing or combustion-retarding extinguishers:" crlf)
   (printout t "  water, water-based liquids, dry chemicals." crlf))

(defrule extinguish-B
   (fire (category B))
   =>
   (printout t "Class B fire: flammable liquids and greases." crlf)
   (printout t
      "  Exclude air, stop the vapours or break the chain reaction." crlf)
   (printout t
      "  Use dry chemicals, carbon dioxide, foam, bromotrifluoromethane." crlf))

(defrule extinguish-C
   (fire (category C))
   =>
   (printout t "Class C fire: energized electrical equipment." crlf)
   (printout t "  ACTION: cut the power if possible!" crlf)
   (printout t
      "  Use a nonconducting agent: dry chemicals, carbon dioxide," crlf)
   (printout t "  bromotrifluoromethane." crlf))

(defrule extinguish-D
   (fire (category D))
   =>
   (printout t "Class D fire: combustible metals." crlf)
   (printout t
      "  Use smothering heat-absorbing chemicals that do not react with metal:" crlf)
   (printout t "  trimethoxyboroxine, screened graphitized coke." crlf))
