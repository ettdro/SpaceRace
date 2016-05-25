note
	description: "Classe contenant les tests de la mécanique du vaisseau de JEU_PRINCIPAL."
	author: "Nicolas Bisson et Étienne Drolet"
	date: "2016-05-22"
	revision: "1.5"
	testing: "type/manual"

class
	TESTS_MECANIQUE

inherit

	EQA_TEST_SET

	MECANIQUE
		undefine
			default_create
		end

feature {NONE} -- Test routines

	acceleration_vaisseau_normal
			-- Test normal de la routine `acceleration_vaisseau'.
		note
			testing: "execution/serial"
		do
			from
				vitesse := 0
			until
				vitesse = 3
			loop
				acceleration_vaisseau
			end
			assert ("acceleration_vaisseau test normal", vitesse ~ 3)
		end

	acceleration_vaisseau_limite
			-- Test limite de la routine `acceleration_vaisseau'.
		note
			testing: "execution/serial"
		do
			from
				vitesse := 0
			until
				vitesse = 6
			loop
				acceleration_vaisseau
			end
			assert ("acceleration_vaisseau test limite", vitesse ~ 6)
		end

	acceleration_vaisseau_errone
			-- Test erroné de la routine `acceleration_vaisseau'.
		note
			testing: "execution/serial"
		do
			from
				vitesse := 0
			until
				vitesse = 6
			loop
				acceleration_vaisseau
			end
			acceleration_vaisseau
			assert ("acceleration_vaisseau test erroné", vitesse ~ 6)
		end

	deceleration_vaisseau_normal
			-- Test normal de la routine `deceleration_vaisseau'.
		note
			testing: "execution/serial"
		do
			from
				vitesse := 6
			until
				vitesse = 3
			loop
				deceleration_vaisseau
			end
			assert ("deceleration_vaisseau test normal", vitesse ~ 3)
		end

	deceleration_vaisseau_limite
			-- Test limite de la routine `deceleration_vaisseau'.
		note
			testing: "execution/serial"
		do
			from
				vitesse := 6
			until
				vitesse = 0
			loop
				deceleration_vaisseau
			end
			assert ("deceleration_vaisseau test limite", vitesse ~ 0)
		end

	deceleration_vaisseau_errone
			-- Test erroné de la routine `deceleration_vaisseau'.
		note
			testing: "execution/serial"
		do
			from
				vitesse := 6
			until
				vitesse = 0
			loop
				deceleration_vaisseau
			end
			deceleration_vaisseau
			assert ("deceleration_vaisseau test erroné", vitesse ~ 0)
		end

	freiner_vaisseau_normal
			-- Test normal de la routine `freiner_vaisseau'.
		note
			testing: "execution/serial"
		do
			from
				vitesse := 6
			until
				vitesse = 3
			loop
				freiner_vaisseau
			end
			assert ("freiner_vaisseau test normal", vitesse ~ 3)
		end

	freiner_vaisseau_limite
			-- Test limite de la routine `freiner_vaisseau'.
		note
			testing: "execution/serial"
		do
			from
				vitesse := 6
			until
				vitesse = 0
			loop
				freiner_vaisseau
			end
			assert ("freiner_vaisseau test limite", vitesse ~ 0)
		end

	freiner_vaisseau_errone
			-- Test erroné de la routine `freiner_vaisseau'.
		note
			testing: "execution/serial"
		do
			from
				vitesse := 6
			until
				vitesse = 0
			loop
				freiner_vaisseau
			end
			freiner_vaisseau
			assert ("freiner_vaisseau test erroné", vitesse ~ 0)
		end

	rotation_gauche_normal
			-- Test normal de la routine `rotation_gauche'.
		note
			testing: "execution/serial"
		do
			from
				rotation_vaisseau := 0
			until
				rotation_vaisseau = 90
			loop
				rotation_gauche
			end
			assert ("rotation_gauche test normal", rotation_vaisseau ~ 90)
		end

	rotation_gauche_limite
			-- Test limite de la routine `rotation_gauche'.
		note
			testing: "execution/serial"
		do
			from
				rotation_vaisseau := 359
			until
				rotation_vaisseau = 0
			loop
				rotation_gauche
			end
			assert ("rotation_gauche test limite", rotation_vaisseau ~ 360)
		end

	rotation_droite_normal
			-- Test normal de la routine `rotation_droite'.
		note
			testing: "execution/serial"
		do
			from
				rotation_vaisseau := 0
			until
				rotation_vaisseau = 90
			loop
				rotation_droite
			end
			assert ("rotation_gauche test normal", rotation_vaisseau ~ 90)
		end

	rotation_droite_limite
			-- Test limite de la routine `rotation_droite'.
		note
			testing: "execution/serial"
		do
			from
				rotation_vaisseau := 1
			until
				rotation_vaisseau = 360
			loop
				rotation_droite
			end
			assert ("rotation_gauche test limite", rotation_vaisseau ~ 0)
		end

end
