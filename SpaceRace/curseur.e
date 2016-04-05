note
	description: "Classe qui fait la gestion de la position du curseur pour pouvoir le changer si nécessaire."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-04-03"
	revision: "1.0"

class
	CURSEUR

inherit

	GAME_LIBRARY_SHARED

create
	make

feature -- Initialization

	make
			-- Crée les curseurs.
		do
			create curseur_main.make_hand
			create curseur_defaut.make_arrow
		end

	est_sur_bouton (a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_MOTION_STATE; a_x, a_y: INTEGER_32; a_window: GAME_WINDOW_RENDERED; a_liste_coordonnees: LIST [TUPLE [x1, y1, x2, y2: INTEGER]])
			-- Vérifie que le curseur est sur un bouton et change l'image du curseur au besoin.
		require
			Liste_Vide: not a_liste_coordonnees.is_empty
			Position_X_Y_Valide:
			across a_liste_coordonnees as la_liste_coordonnees all
								la_liste_coordonnees.item.x1 >= 0 and
								la_liste_coordonnees.item.y1 >= 0 and
								la_liste_coordonnees.item.x2 >= 0 and
								la_liste_coordonnees.item.y2 >= 0 and
								la_liste_coordonnees.item.x1 <= 1000 and
								la_liste_coordonnees.item.y1 <= 600 and
								la_liste_coordonnees.item.x2 <= 1000 and
								la_liste_coordonnees.item.y2 <= 600
							end
		local
			est_defaut: BOOLEAN
		do
			x := a_mouse_state.x
			y := a_mouse_state.y
			est_defaut := True
			across
				a_liste_coordonnees as la_liste_coordonnees
			loop
				if x > la_liste_coordonnees.item.x1 and x < la_liste_coordonnees.item.x2 and y > la_liste_coordonnees.item.y1 and y < la_liste_coordonnees.item.y2 then
					game_library.set_cursor (curseur_main)
					est_defaut := False
				end
			end
			if est_defaut then
				game_library.set_cursor (curseur_defaut)
			end
		end

	reinitialiser_curseur
			-- Remets la flèche comme curseur.
		do
			game_library.set_cursor (curseur_defaut)
		end

feature {ANY} -- Implementation

	curseur_main: GAME_CURSOR

	curseur_defaut: GAME_CURSOR

	y, x: INTEGER

end
