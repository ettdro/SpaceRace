note
	description: "Contient les éléments généraux aux menus de sélection (piste et vaisseau)."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-05-09"
	revision: "1.4"

deferred class
	MENU_SELECTION

inherit

	MENU

feature {ANY} -- Access

	valider_bouton_suivant (a_x, a_y: INTEGER)
			-- Méthode vérifiant si la souris (a_x, a_y) est sur le bouton SUIVANT et exécute l'action en conséquence.
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
			-- Détermine si le bouton "SUIVANT" est visible.

feature {ANY} -- Constantes

	Bouton_suivant_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du bouton SUIVANT.
		once
			Result := [759, 519, 917, 577]
		end

end
