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

	make_vert (a_fenetre: FENETRE)
			-- Construit la piste Verte.
		do
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteV.png")
			x := 59
			y := 250
				--			limite_gauche := 41
				--			limite_droite := 77
				--			limite_haut := 34
				--			limite_bas := 55
			create {LINKED_LIST [TUPLE [x1, y1, x2, y2: INTEGER]]} checkpoint_liste.make
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
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteJ.png")
			x := 59
			y := 330
			create {LINKED_LIST [TUPLE [x1, y1, x2, y2: INTEGER]]} checkpoint_liste.make
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
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteM.png")
			x := 33
			y := 330
			create {LINKED_LIST [TUPLE [x1, y1, x2, y2: INTEGER]]} checkpoint_liste.make
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
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteB.png")
			x := 48
			y := 260
			create {LINKED_LIST [TUPLE [x1, y1, x2, y2: INTEGER]]} checkpoint_liste.make
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

feature {ANY} -- Implementation

	piste: AFFICHABLE -- L'image de la piste pour la partie.

		--	limite_gauche: INTEGER

		--	limite_droite: INTEGER

		--	limite_haut: INTEGER

		--	limite_bas: INTEGER

	x: INTEGER -- La position de départ de la piste en X.

	y: INTEGER -- La position de départ de la piste en Y.

	checkpoint_liste: LIST [TUPLE [x1, y1, x2, y2: INTEGER]] -- Liste qui contient les constantes des coordonnées des checkpoints.

feature {NONE} -- Constantes

	Checkpoint_verte_1: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du checkpoint 1 de la piste verte.
		once
			Result := [374, 114, 374, 180]
		end

	Checkpoint_verte_2: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du checkpoint 2 de la piste verte.
		once
			Result := [554, 490, 554, 545]
		end

	Checkpoint_verte_3: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du checkpoint 3 de la piste verte.
		once
			Result := [193, 395, 193, 455]
		end

	Checkpoint_jaune_1: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du checkpoint 1 de la piste jaune.
		once
			Result := [315, 28, 315, 90]
		end

	Checkpoint_jaune_2: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du checkpoint 2 de la piste jaune.
		once
			Result := [500, 167, 500, 225]
		end

	Checkpoint_jaune_3: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du checkpoint 3 de la piste jaune.
		once
			Result := [580, 433, 645, 433]
		end

	Checkpoint_jaune_4: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du checkpoint 4 de la piste jaune.
		once
			Result := [265, 400, 265, 462]
		end

	Checkpoint_mauve_1: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du checkpoint 1 de la piste mauve.
		once
			Result := [100, 25, 100, 85]
		end

	Checkpoint_mauve_2: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du checkpoint 2 de la piste mauve.
		once
			Result := [360, 125, 360, 180]
		end

	Checkpoint_mauve_3: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du checkpoint 3 de la piste mauve.
		once
			Result := [585, 55, 585, 115]
		end

	Checkpoint_mauve_4: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du checkpoint 4 de la piste mauve.
		once
			Result := [580, 372, 630, 372]
		end

	Checkpoint_mauve_5: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du checkpoint 5 de la piste mauve.
		once
			Result := [375, 525, 375, 575]
		end

	Checkpoint_mauve_6: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du checkpoint 6 de la piste mauve.
		once
			Result := [218, 360, 218, 410]
		end

	Checkpoint_mauve_7: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du checkpoint 7 de la piste mauve.
		once
			Result := [113, 515, 113, 575]
		end

	Checkpoint_bleue_1: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du checkpoint 1 de la piste bleue.
		once
			Result := [405, 20, 405, 80]
		end

	Checkpoint_bleue_2: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du checkpoint 2 de la piste bleue.
		once
			Result := [397, 220, 397, 285]
		end

	Checkpoint_bleue_3: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du checkpoint 3 de la piste bleue.
		once
			Result := [557, 375, 557, 425]
		end

	Checkpoint_bleue_4: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du checkpoint 4 de la piste bleue.
		once
			Result := [452, 530, 452, 585]
		end

	Depart_verte: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [28, 256, 92, 256]
		end

	Depart_jaune: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [28, 333, 95, 333]
		end

	Depart_mauve: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [5, 335, 69, 335]
		end

	Depart_bleue: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante représentant les coordonnées du départ de la piste bleue.
		once
			Result := [15, 266, 85, 266]
		end

end
