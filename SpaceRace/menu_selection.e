note
	description: "Contient les �l�ments g�n�raux aux menus de s�lection (piste et vaisseau)."
	author: "�tienne Drolet et Nicolas Bisson"
	date: "2016-05-09"
	revision: "1.4"

deferred class
	MENU_SELECTION

inherit

	MENU

feature {ANY} -- Access

	valider_bouton_suivant (a_x, a_y: INTEGER)
			-- M�thode v�rifiant si la souris (a_x, a_y) est sur le bouton SUIVANT et ex�cute l'action en cons�quence.
		do
			if a_x > Bouton_suivant_coordonnees.x1 and a_x < Bouton_suivant_coordonnees.x2 and a_y > Bouton_suivant_coordonnees.y1 and a_y < Bouton_suivant_coordonnees.y2 then
				if suivant_est_visible then
					verifier_son_click_muet
					curseur.reinitialiser_curseur
					lancer_menu_suivant
				end
			end
		end

	lancer_menu_suivant
			-- Lance le menu suivant.
		deferred
		end

feature {ANY} -- Implementation

	suivant_est_visible: BOOLEAN
			-- D�termine si le bouton "SUIVANT" est visible.

feature {ANY} -- Constantes

	Bouton_suivant_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante repr�sentant les coordonn�es du bouton SUIVANT.
		once
			Result := [759, 519, 917, 577]
		end

end
