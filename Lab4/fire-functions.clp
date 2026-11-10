;;; ЛР4. Експертна система «Пожежі та вогнегасники» на функціях deffunction

;; ---------- шаблони ----------
(deftemplate burning-material      ; вхід: що горить
   (slot name))

(deftemplate fire                  ; висновок: категорія пожежі
   (slot category (allowed-values A B C D)))

;; ---------- функції ----------
;; категорія пожежі за матеріалом, або unknown
(deffunction fire-class (?material)
   (if (member$ ?material (create$ paper wood cloth))
      then A
   else (if (member$ ?material (create$ oil gas grease gasoline))
      then B
   else (if (eq ?material energized-electrical-equipment)
      then C
   else (if (member$ ?material (create$ magnesium sodium potassium))
      then D
   else unknown)))))

;; короткий опис категорії
(deffunction class-description (?class)
   (switch ?class
      (case A then "ordinary combustibles")
      (case B then "flammable liquids and greases")
      (case C then "energized electrical equipment")
      (case D then "combustible metals")
      (default "unknown")))

;; список вогнегасників для категорії (мультиполе)
(deffunction extinguishers (?class)
   (switch ?class
      (case A then (create$ water water-based-liquids dry-chemicals))
      (case B then (create$ dry-chemicals carbon-dioxide foam
                            bromotrifluoromethane))
      (case C then (create$ dry-chemicals carbon-dioxide
                            bromotrifluoromethane))
      (case D then (create$ trimethoxyboroxine
                            screened-graphitized-coke))
      (default (create$))))

;; додаткові дії, крім гасіння
(deffunction extra-action (?class)
   (if (eq ?class C)
      then "cut the power if possible!"
      else "none"))

;; повна порада: друкує все про категорію пожежі
(deffunction print-advice (?class)
   (printout t "Class " ?class " fire: " (class-description ?class) crlf)
   (printout t "  Extinguishers: " (implode$ (extinguishers ?class)) crlf)
   (printout t "  Extra action:  " (extra-action ?class) crlf))

;; груповий параметр: класифікує будь-яку кількість матеріалів
(deffunction classify-all ($?materials)
   (printout t "Materials: " (length$ ?materials) crlf)
   (progn$ (?m ?materials)
      (printout t "  " ?m " -> " (fire-class ?m) crlf)))

;; ---------- правила ----------
(defrule classify-fire
   (burning-material (name ?m))
   (test (neq (fire-class ?m) unknown))      ; функція в лівій частині
   =>
   (assert (fire (category (fire-class ?m)))))

(defrule unknown-material
   (burning-material (name ?m))
   (test (eq (fire-class ?m) unknown))
   =>
   (printout t "Material " ?m " is unknown." crlf))

(defrule give-advice
   (fire (category ?c))
   =>
   (print-advice ?c))                         ; функція в правій частині
