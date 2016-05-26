note
	description: "Classe effectuant des tests sur les méthodes testables de la classe MECANIQUE."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-05-17"
	revision: "1.4"
	testing: "type/manual"

class
	TESTS_MECANIQUE

inherit
	EQA_TEST_SET

	MECANIQUE
		undefine
			default_create
		end

feature -- Test routines

	acceleration_vaisseau_normal
			-- Test normal de la routine `acceleration_vaisseau'.
		note
			testing: "execution/serial"
		do
			vitesse := 3
			acceleration_vaisseau
			assert ("acceleration_vaisseau test normal", vitesse ~ 2)
		end

	acceleration_vaisseau_limite
			-- Test limite de la routine `acceleration_vaisseau'.
		note
			testing: "execution/serial"
		do
			vitesse := 0
			acceleration_vaisseau
			assert ("acceleration_vaisseau test limite", vitesse ~ 0.02)
		end

	deceleration_vaisseau_normal
			-- Test normal de la routine `deceleration_vaisseau'.
		note
			testing: "execution/serial"
		do
			vitesse := 3
			deceleration_vaisseau
			assert ("deceleration_vaisseau test normal", vitesse ~ 2.98)
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

	freiner_vaisseau_normal
			-- Test normal de la routine `freiner_vaisseau'.
		note
			testing: "execution/serial"
		do
			vitesse := 4
			freiner_vaisseau
			assert ("freiner_vaisseau test normal", vitesse ~ 3.96)
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
			rotation_vaisseau := 0
			rotation_gauche
			assert ("rotation_gauche test limite", rotation_vaisseau ~ 357.5)
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
			assert ("rotation_droite test normal", rotation_vaisseau ~ 90)
		end

	rotation_droite_limite
			-- Test limite de la routine `rotation_droite'.
		note
			testing: "execution/serial"
		do
			rotation_vaisseau := 360
			rotation_droite
			assert ("rotation_droite test limite", rotation_vaisseau ~ 2.5)
		end
		
end


