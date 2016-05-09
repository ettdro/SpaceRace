note
	description: "Summary description for {MENU_SELECTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MENU_SELECTION

inherit
	MENU

feature

	valider_bouton_suivant (a_x, a_y: INTEGER)
			-- Méthode vérifiant si la souris est sur le bouton SUIVANT et exécute l'action en conséquence.
		do
			if
				a_x > Bouton_suivant_coordonnees.x1 and
				a_x < Bouton_suivant_coordonnees.x2 and
				a_y > Bouton_suivant_coordonnees.y1 and
				a_y < Bouton_suivant_coordonnees.y2
			then
				if suivant_est_visible then
					verifier_si_muet
					curseur.reinitialiser_curseur
					lancer_menu_suivant
				end
			end
		end

	lancer_menu_suivant
		deferred
		end

feature {ANY}

	suivant_est_visible: BOOLEAN
			-- Détermine si le bouton "SUIVANT" est visible.

	Bouton_suivant_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
				-- Constante représentant les coordonnées du bouton SUIVANT.
			once
				Result := [759, 519, 917, 577]
			end
end
