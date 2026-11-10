;;; ЛР2, завдання 1. Родинні зв'язки John, Tom і Susan

;; батько дитини
(deftemplate father-of
   (slot father)
   (slot child))

;; мати дитини
(deftemplate mother-of
   (slot mother)
   (slot child))

;; обидва батьки дитини
(deftemplate parents-of
   (slot father)
   (slot mother)
   (slot child))

;; роль людини в родині
(deftemplate role
   (slot person)
   (slot is (allowed-values father mother son daughter)))

;; стать людини
(deftemplate gender
   (slot person)
   (slot is (allowed-values male female)))

(deffacts family
   (father-of  (father Tom)    (child John))
   (mother-of  (mother Susan)  (child John))
   (parents-of (father Tom) (mother Susan) (child John))
   (role   (person Tom)   (is father))
   (role   (person Susan) (is mother))
   (role   (person John)  (is son))
   (gender (person Tom)   (is male))
   (gender (person Susan) (is female))
   (gender (person John)  (is male)))
