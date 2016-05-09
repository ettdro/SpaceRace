note
	description: "Classe qui crée les pistes."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-04-04"
	revision: "1.0"

class
	PISTE

create
	make_vert,
	make_bleu,
	make_jaune,
	make_mauve

feature {NONE} -- Initialization
	make (a_fenetre: FENETRE)
		do
			create {LINKED_LIST [TUPLE [x1, y1, x2, y2: INTEGER]]} checkpoint_liste.make
			create {LINKED_LIST [TUPLE [x, y: INTEGER]]} lumiere_liste.make
			create lumiere_verte.creer_affichable (a_fenetre.fenetre.renderer, "checkpointOui.png")
			create lumiere_rouge.creer_affichable (a_fenetre.fenetre.renderer, "checkpointNon.png")
			index_suivant_checkpoint := 2
		end

	make_vert (a_fenetre: FENETRE)
			-- Construit la piste Verte.
		do
			make(a_fenetre)
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteV.png")
			x := 59
			y := 250
			lumiere_liste.extend (lumiere_piste_verte_1)
			lumiere_liste.extend (lumiere_piste_verte_2)
			lumiere_liste.extend (lumiere_piste_verte_3)
			lumiere_liste.start
			checkpoint_liste.extend (Depart_verte)
			checkpoint_liste.extend (Checkpoint_verte_1)
			checkpoint_liste.extend (Checkpoint_verte_2)
			checkpoint_liste.extend (Checkpoint_verte_3)
			checkpoint_liste.start
		ensure
			Position_Depart_X: x = 59
			Position_Depart_Y: y = 250
		end

	make_jaune (a_fenetre: FENETRE)
			-- Construit la piste Jaune.
		do
			make(a_fenetre)
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteJ.png")
			x := 59
			y := 330
			lumiere_liste.extend (lumiere_piste_jaune_1)
			lumiere_liste.extend (lumiere_piste_jaune_2)
			lumiere_liste.extend (lumiere_piste_jaune_3)
			lumiere_liste.extend (lumiere_piste_jaune_4)
			lumiere_liste.start
			checkpoint_liste.extend (Depart_jaune)
			checkpoint_liste.extend (Checkpoint_jaune_1)
			checkpoint_liste.extend (Checkpoint_jaune_2)
			checkpoint_liste.extend (Checkpoint_jaune_3)
			checkpoint_liste.extend (Checkpoint_jaune_4)
			checkpoint_liste.start
		ensure
			Position_Depart_X: x = 59
			Position_Depart_Y: y = 330
		end

	make_mauve (a_fenetre: FENETRE)
			-- Construit la piste Mauve.
		do
			make(a_fenetre)
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteM.png")
			x := 33
			y := 330
			lumiere_liste.extend (lumiere_piste_mauve_1)
			lumiere_liste.extend (lumiere_piste_mauve_2)
			lumiere_liste.extend (lumiere_piste_mauve_3)
			lumiere_liste.extend (lumiere_piste_mauve_4)
			lumiere_liste.extend (lumiere_piste_mauve_5)
			lumiere_liste.extend (lumiere_piste_mauve_6)
			lumiere_liste.extend (lumiere_piste_mauve_7)
			lumiere_liste.start
			checkpoint_liste.extend (Depart_mauve)
			checkpoint_liste.extend (Checkpoint_mauve_1)
			checkpoint_liste.extend (Checkpoint_mauve_2)
			checkpoint_liste.extend (Checkpoint_mauve_3)
			checkpoint_liste.extend (Checkpoint_mauve_4)
			checkpoint_liste.extend (Checkpoint_mauve_5)
			checkpoint_liste.extend (Checkpoint_mauve_6)
			checkpoint_liste.extend (Checkpoint_mauve_7)
			checkpoint_liste.start
		ensure
			Position_Depart_X: x = 33
			Position_Depart_Y: y = 330
		end

	make_bleu (a_fenetre: FENETRE)
			-- Construit la piste Bleue.
		do
			make(a_fenetre)
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteB.png")
			x := 48
			y := 260
			lumiere_liste.extend (lumiere_piste_bleue_1)
			lumiere_liste.extend (lumiere_piste_bleue_2)
			lumiere_liste.extend (lumiere_piste_bleue_3)
			lumiere_liste.extend (lumiere_piste_bleue_4)
			lumiere_liste.start
			checkpoint_liste.extend (Depart_bleue)
			checkpoint_liste.extend (Checkpoint_bleue_1)
			checkpoint_liste.extend (Checkpoint_bleue_2)
			checkpoint_liste.extend (Checkpoint_bleue_3)
			checkpoint_liste.extend (Checkpoint_bleue_4)
			checkpoint_liste.start
		ensure
			Position_Depart_X: x = 48
			Position_Depart_Y: y = 260
		end

feature {ANY} -- Access

	valider_checkpoint(position_x, position_y: INTEGER)
		-- Regarde si le vaisseau a traversé un checkpoint.
		local
			checkpoint_valeurs: like checkpoint_liste.item
		do
			checkpoint_valeurs := checkpoint_liste.at (index_suivant_checkpoint)
			if
				position_x > checkpoint_valeurs.x1 and position_x < checkpoint_valeurs.x2 and
				position_y > checkpoint_valeurs.y1 and position_y < checkpoint_valeurs.y2
			then
				print("Checkpoint!%N")
				index_suivant_checkpoint := (index_suivant_checkpoint\\ checkpoint_liste.count) + 1
			end
		end

feature {ANY} -- Implementation

	index_suivant_checkpoint: INTEGER

	piste: AFFICHABLE
			-- L'image de la piste pour la partie.

	x: INTEGER
			-- La position de départ de la piste en X.

	y: INTEGER
			-- La position de départ de la piste en Y.

	checkpoint_liste: LIST [TUPLE [x1, y1, x2, y2: INTEGER]]
			-- Liste qui contient les constantes des coordonnées des checkpoints.

	lumiere_liste: LIST [TUPLE [x, y: INTEGER]]

	lumiere_verte: AFFICHABLE

	lumiere_rouge: AFFICHABLE

feature {NONE} -- Constantes

	Checkpoint_verte_1: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 1 de la piste verte.
		once
			Result := [374, 114, 380, 180]
		end

	Checkpoint_verte_2: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 2 de la piste verte.
		once
			Result := [554, 490, 560, 545]
		end

	Checkpoint_verte_3: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 3 de la piste verte.
		once
			Result := [193, 395, 200, 455]
		end

	Checkpoint_jaune_1: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 1 de la piste jaune.
		once
			Result := [315, 28, 325, 90]
		end

	Checkpoint_jaune_2: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 2 de la piste jaune.
		once
			Result := [500, 167, 510, 225]
		end

	Checkpoint_jaune_3: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 3 de la piste jaune.
		once
			Result := [580, 423, 645, 443]
		end

	Checkpoint_jaune_4: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 4 de la piste jaune.
		once
			Result := [265, 400, 275, 462]
		end

	Checkpoint_mauve_1: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 1 de la piste mauve.
		once
			Result := [100, 25, 120, 85]
		end

	Checkpoint_mauve_2: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 2 de la piste mauve.
		once
			Result := [360, 125, 380, 180]
		end

	Checkpoint_mauve_3: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 3 de la piste mauve.
		once
			Result := [585, 55, 605, 115]
		end

	Checkpoint_mauve_4: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 4 de la piste mauve.
		once
			Result := [530, 362, 600, 382]
		end

	Checkpoint_mauve_5: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 5 de la piste mauve.
		once
			Result := [370, 488, 378, 535]
		end

	Checkpoint_mauve_6: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 6 de la piste mauve.
		once
			Result := [215, 317, 221, 371]
		end

	Checkpoint_mauve_7: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 7 de la piste mauve.
		once
			Result := [105, 475, 111, 562]
		end

	Checkpoint_bleue_1: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 1 de la piste bleue.
		once
			Result := [405, 20, 425, 80]
		end

	Checkpoint_bleue_2: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 2 de la piste bleue.
		once
			Result := [397, 220, 417, 285]
		end

	Checkpoint_bleue_3: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 3 de la piste bleue.
		once
			Result := [557, 375, 577, 425]
		end

	Checkpoint_bleue_4: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 4 de la piste bleue.
		once
			Result := [452, 530, 472, 585]
		end

	Depart_verte: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [28, 246, 92, 256]
		end

	Depart_jaune: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [28, 323, 95, 333]
		end

	Depart_mauve: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [5, 335, 69, 345]
		end

	Depart_bleue: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [15, 266, 85, 286]
		end

feature {ANY}

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
