note
	description: "Classe pour la création et l'affichage des lumières de checkpoints."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-05-15"
	revision: "1.4"

class
	LUMIERE_CHECKPOINT

create
	make,
	make_lumiere_piste_verte,
	make_lumiere_piste_jaune,
	make_lumiere_piste_mauve,
	make_lumiere_piste_bleue

feature {ANY} -- Initialization

	make (a_fenetre: FENETRE)
			-- Création des images et de la liste des checkpoints dans la fenetre (a_fenetre).
		do
			create {LINKED_LIST [TUPLE [x, y: INTEGER]]} lumiere_liste.make
			create lumiere_verte.creer_affichable (a_fenetre.fenetre.renderer, "./images/checkpointOui.png")
			create lumiere_rouge.creer_affichable (a_fenetre.fenetre.renderer, "./images/checkpointNon.png")
		end

	make_lumiere_piste_verte (a_fenetre: FENETRE)
			-- Crée les checkpoints de la piste verte dans la fenetre (a_fenetre).
		do
			make (a_fenetre)
			lumiere_liste.extend (lumiere_piste_verte_1)
			lumiere_liste.extend (lumiere_piste_verte_2)
			lumiere_liste.extend (lumiere_piste_verte_3)
			lumiere_liste.start
		end

	make_lumiere_piste_jaune (a_fenetre: FENETRE)
			-- Crée les checkpoints de la piste jaune dans la fenetre (a_fenetre).
		do
			make (a_fenetre)
			lumiere_liste.extend (lumiere_piste_jaune_1)
			lumiere_liste.extend (lumiere_piste_jaune_2)
			lumiere_liste.extend (lumiere_piste_jaune_3)
			lumiere_liste.extend (lumiere_piste_jaune_4)
			lumiere_liste.start
		end

	make_lumiere_piste_mauve (a_fenetre: FENETRE)
			-- Crée les checkpoints de la piste mauve dans la fenetre (a_fenetre).
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
			-- Crée les checkpoints de la piste bleue dans la fenetre (a_fenetre).
		do
			make (a_fenetre)
			lumiere_liste.extend (lumiere_piste_bleue_1)
			lumiere_liste.extend (lumiere_piste_bleue_2)
			lumiere_liste.extend (lumiere_piste_bleue_3)
			lumiere_liste.extend (lumiere_piste_bleue_4)
			lumiere_liste.start
		end

feature {ANY} -- Implementation

	lumiere_liste: LIST [TUPLE [x, y: INTEGER]]
			-- Liste contenant les coordonnées des checkpoints.

	lumiere_verte: AFFICHABLE
			-- L'image de la lumière verte.

	lumiere_rouge: AFFICHABLE
			-- L'image de la lumière rouge.

feature {NONE} -- Constantes

	lumiere_piste_verte_1: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du checkpoint #1 de la piste verte.
		once
			Result := [373, 105]
		end

	lumiere_piste_verte_2: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du checkpoint #2 de la piste verte.
		once
			Result := [552, 465]
		end

	lumiere_piste_verte_3: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du checkpoint #3 de la piste verte.
		once
			Result := [191, 370]
		end

	lumiere_piste_jaune_1: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du checkpoint #1 de la piste jaune.
		once
			Result := [312, 18]
		end

	lumiere_piste_jaune_2: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du checkpoint #2 de la piste jaune.
		once
			Result := [489, 142]
		end

	lumiere_piste_jaune_3: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du checkpoint #3 de la piste jaune.
		once
			Result := [538, 430]
		end

	lumiere_piste_jaune_4: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du checkpoint #4 de la piste jaune.
		once
			Result := [253, 375]
		end

	lumiere_piste_mauve_1: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du checkpoint #1 de la piste mauve.
		once
			Result := [97, 15]
		end

	lumiere_piste_mauve_2: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du checkpoint #2 de la piste mauve.
		once
			Result := [357, 115]
		end

	lumiere_piste_mauve_3: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du checkpoint #3 de la piste mauve.
		once
			Result := [582, 45]
		end

	lumiere_piste_mauve_4: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du checkpoint #4 de la piste mauve.
		once
			Result := [510, 369]
		end

	lumiere_piste_mauve_5: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du checkpoint #5 de la piste mauve.
		once
			Result := [367, 498]
		end

	lumiere_piste_mauve_6: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du checkpoint #6 de la piste mauve.
		once
			Result := [208, 330]
		end

	lumiere_piste_mauve_7: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du checkpoint #7 de la piste mauve.
		once
			Result := [102, 488]
		end

	lumiere_piste_bleue_1: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du checkpoint #1 de la piste bleue.
		once
			Result := [405, 6]
		end

	lumiere_piste_bleue_2: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du checkpoint #2 de la piste bleue.
		once
			Result := [383, 198]
		end

	lumiere_piste_bleue_3: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du checkpoint #3 de la piste bleue.
		once
			Result := [556, 363]
		end

	lumiere_piste_bleue_4: TUPLE [x1, y1: INTEGER]
			-- Constante représentant les coordonnées du checkpoint #4 de la piste bleue.
		once
			Result := [440, 505]
		end

end
