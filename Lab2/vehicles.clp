;;; ЛР2, завдання 2, варіант 8. Транспортні засоби

(deftemplate vehicle
   (slot name)
   (slot type)
   (slot max-speed  (type INTEGER))   ; км/год
   (slot passengers (type INTEGER))
   (slot fuel (allowed-values petrol diesel kerosene
                              electricity none)))

(deffacts transport
   (vehicle (name car) (type passenger-car)
            (max-speed 220) (passengers 5) (fuel petrol))
   (vehicle (name bicycle) (type two-wheeled)
            (max-speed 30) (passengers 1) (fuel none))
   (vehicle (name airplane) (type jet)
            (max-speed 900) (passengers 150) (fuel kerosene)))
