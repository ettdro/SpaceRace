note
	description: "Summary description for {LUMIERE_CHECKPOINT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LUMIERE_CHECKPOINT

create
	make

feature {ANY}

	make (a_fenetre: FENETRE)
		do
			create {LINKED_LIST [TUPLE [x, y: INTEGER]]} lumiere_liste.make
			create lumiere_verte.creer_affichable (a_fenetre.fenetre.renderer, "checkpointOui.png")
			create lumiere_rouge.creer_affichable (a_fenetre.fenetre.renderer, "checkpointNon.png")
		end

feature {ANY}
	make_lumiere_piste_verte (a_fenetre: FENETRE)
		do
			make (a_fenetre)
			lumiere_liste.extend (lumiere_piste_verte_1)
			lumiere_liste.extend (lumiere_piste_verte_2)
			lumiere_liste.extend (lumiere_piste_verte_3)
			lumiere_liste.start
		end

	make_lumiere_piste_jaune (a_fenetre: FENETRE)
		do
			make (a_fenetre)
			lumiere_liste.extend (lumiere_piste_jaune_1)
			lumiere_liste.extend (lumiere_piste_jaune_2)
			lumiere_liste.extend (lumiere_piste_jaune_3)
			lumiere_liste.extend (lumiere_piste_jaune_4)
			lumiere_liste.start
		end

	make_lumiere_piste_mauve (a_fenetre: FENETRE)
		do
			make (a_fenetre)
			lumiere_liste.extend (lumiere_piste_mauve_1)
			lumiere_liste.extend (lumiere_piste_mauve_2)
			lumiere_liste.extend (lumiere_piste_mauve_3)
			lumiere_liste.extend (lumiere_piste_mauve_4)
			lumiere_liste.extend (lumiere_piste_mauve_5)
			lumiere_liste.extend (lumiere_piste_mauve_6)
			lumiere_liste.extend (lumiere_piste_mauve_7)
			lumiere_liste.start
		end

	make_lumiere_piste_bleue (a_fenetre: FENETRE)
		do
			make (a_fenetre)
			lumiere_liste.extend (lumiere_piste_bleue_1)
			lumiere_liste.extend (lumiere_piste_bleue_2)
			lumiere_liste.extend (lumiere_piste_bleue_3)
			lumiere_liste.extend (lumiere_piste_bleue_4)
			lumiere_liste.start
		end

feature {ANY}

	afficher_lumiere (a_fenetre: GAME_RENDERER)
		do
			across
				lumiere_liste as la_coord_lumiere
			loop
				if lumiere_liste.readable then
					lumiere_verte.afficher (la_coord_lumiere.item.x, la_coord_lumiere.item.y, a_fenetre)
				end
				if lumiere_liste.readable then
					lumiere_rouge.afficher (la_coord_lumiere.item.x, la_coord_lumiere.item.y, a_fenetre)
				end
			end
		end

feature {ANY}

	lumiere_liste: LIST [TUPLE [x, y: INTEGER]]

	lumiere_verte: AFFICHABLE

	lumiere_rouge: AFFICHABLE

	lumiere_piste_verte_1: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [373, 105]
		end

	lumiere_piste_verte_2: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [552, 465]
		end

	lumiere_piste_verte_3: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [191, 370]
		end

	lumiere_piste_jaune_1: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [312, 18]
		end

	lumiere_piste_jaune_2: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [489, 142]
		end

	lumiere_piste_jaune_3: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [538, 430]
		end

	lumiere_piste_jaune_4: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [253, 375]
		end

	lumiere_piste_mauve_1: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [97, 15]
		end

	lumiere_piste_mauve_2: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [357, 115]
		end

	lumiere_piste_mauve_3: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [582, 45]
		end

	lumiere_piste_mauve_4: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [510, 369]
		end

	lumiere_piste_mauve_5: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [367, 498]
		end

	lumiere_piste_mauve_6: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [208, 330]
		end

	lumiere_piste_mauve_7: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [102, 488]
		end

	lumiere_piste_bleue_1: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [405, 6]
		end

	lumiere_piste_bleue_2: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [383, 198]
		end

	lumiere_piste_bleue_3: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [556, 363]
		end

	lumiere_piste_bleue_4: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [440, 505]
		end

end
