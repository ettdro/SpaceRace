note
	description: "Classe qui gère les mécaniques du vaisseau dans JEU_PRINCIPAL."
	author: "Nicolas Bisson et Étienne Drolet"
	date: "2016-05-22"
	revision: "1.5"

deferred class
	MECANIQUE

inherit

	DOUBLE_MATH

feature {ANY} -- Access	

	acceleration_vaisseau
			-- Gère l'accélération du vaisseau.
		do
			if vitesse < 2 then
				vitesse := vitesse + Acceleration
			end
			if vitesse >= 2 then
				vitesse := 2
			end
		end

	deceleration_vaisseau
			-- Gère la décelération du vaisseau.
		do
			if vitesse > 0 then
				vitesse := vitesse - Deceleration
			end
			if vitesse <= 0 then
				vitesse := 0
			end
		end

	freiner_vaisseau
			-- Ralenti le vaisseau plus rapidement que `deceleration_vaisseau'.
		do
			if vitesse > 0 then
				vitesse := vitesse - (Deceleration * 2)
			end
			if vitesse <= 0 then
				vitesse := 0
			end
		end

	rotation_gauche
			-- Tourne le vaisseau vers la gauche.
		do
			if rotation_vaisseau = 0 then
				rotation_vaisseau := 360
			end
			rotation_vaisseau := rotation_vaisseau - 2.5
		end

	rotation_droite
			-- Tourne le vaisseau vers la droite.
		do
			if rotation_vaisseau = 360 then
				rotation_vaisseau := 0
			end
			rotation_vaisseau := rotation_vaisseau + 2.5
		end

	rotation_vaisseau_radiant: REAL_64
			-- Transforme l'angle qui est en degré en radiant.
		do
			Result := ((2 * pi) * rotation_vaisseau) / 360
		end

	avancer
			-- Fais avancer le vaisseau selon sa vitesse.
		do
			if vaisseau_y > 0 and vaisseau_y < 563 and vaisseau_x > 0 and vaisseau_x < 715 then
				if rotation_vaisseau = 0 or rotation_vaisseau = 360 then
					vaisseau_y := vaisseau_y - vitesse
				end
				if rotation_vaisseau = 90 then
					vaisseau_x := vaisseau_x + vitesse
				end
				if rotation_vaisseau = 180 then
					vaisseau_y := vaisseau_y + vitesse
				end
				if rotation_vaisseau = 270 then
					vaisseau_x := vaisseau_x - vitesse
				end
				if rotation_vaisseau > 0 and rotation_vaisseau < 90 then
					vaisseau_y := vaisseau_y - (cosine (rotation_vaisseau_radiant)) * vitesse
					vaisseau_x := vaisseau_x + (sine (rotation_vaisseau_radiant)) * vitesse
				end
				if rotation_vaisseau > 90 and rotation_vaisseau < 180 then
					vaisseau_y := vaisseau_y - (cosine (rotation_vaisseau_radiant)) * vitesse
					vaisseau_x := vaisseau_x + (sine (rotation_vaisseau_radiant)) * vitesse
				end
				if rotation_vaisseau > 180 and rotation_vaisseau < 270 then
					vaisseau_y := vaisseau_y - (cosine (rotation_vaisseau_radiant)) * vitesse
					vaisseau_x := vaisseau_x + (sine (rotation_vaisseau_radiant)) * vitesse
				end
				if rotation_vaisseau > 270 and rotation_vaisseau < 360 then
					vaisseau_y := vaisseau_y - (cosine (rotation_vaisseau_radiant)) * vitesse
					vaisseau_x := vaisseau_x + (sine (rotation_vaisseau_radiant)) * vitesse
				end
			end
		end

	verification_position_vaisseau
			-- Vérifie la position du vaisseau pour le remettre dans la zone de jeu s'il en sort.
		do
			if vaisseau_x > 715 then
				vaisseau_x := vaisseau_x - 1
			end
			if vaisseau_x < 0 then
				vaisseau_x := vaisseau_x + 1
			end
			if vaisseau_y > 563 then
				vaisseau_y := vaisseau_y - 1
			end
			if vaisseau_y < 0 then
				vaisseau_y := vaisseau_y + 1
			end
		end

feature {NONE} -- Implementation

	rotation_vaisseau: REAL_64
			-- L'angle de rotation du vaisseau.

	vaisseau_y: REAL_64
			-- La position en Y du vaisseau.

	vaisseau_x: REAL_64
			-- La position en X du vaisseau.

	vitesse: REAL_64
			-- La vitesse du vaisseau.

feature {NONE} -- Constantes

	Acceleration: REAL_64
		-- Constante qui représente la vitesse d'accélération.
		once
			Result := 0.02
		end

	Deceleration: REAL_64
		-- Constante qui représente la vitesse d'accélération.
		once
			Result := 0.02
		end

end
