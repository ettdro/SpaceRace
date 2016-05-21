note
	description: "Classe qui crée les pistes."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-05-21"
	revision: "1.5"

class
	PISTE

create
	make_vert,
	make_bleu,
	make_jaune,
	make_mauve

feature {NONE} -- Initialization

	make (a_fenetre: FENETRE)
			-- Crée la liste des checkpoints pour les pistes.
		do
			create font.make ("impact.ttf", 72)
			font.open
			create couleur.make_rgb (255, 102, 0)
			create {LINKED_LIST [TUPLE [x1, y1, x2, y2: INTEGER]]} checkpoint_liste.make
			create lumiere_checkpoint.make (a_fenetre)
			create tours.make (a_fenetre.fenetre.renderer, font, couleur)
			index_suivant_checkpoint := 1
		end

	make_vert (a_fenetre: FENETRE)
			-- Construit la piste Verte dans la fenêtre (a_fenetre).
		do
			make(a_fenetre)
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteV.png")
			lumiere_checkpoint.make_lumiere_piste_verte (a_fenetre)
			x := 59
			y := 250
			checkpoint_liste.extend (Checkpoint_verte_1)
			checkpoint_liste.extend (Checkpoint_verte_2)
			checkpoint_liste.extend (Checkpoint_verte_3)
			checkpoint_liste.extend (Depart_verte)
			checkpoint_liste.start
		ensure
			Position_Depart_X: x = 59
			Position_Depart_Y: y = 250
		end

	make_jaune (a_fenetre: FENETRE)
			-- Construit la piste Jaune dans la fenêtre (a_fenetre).
		do
			make(a_fenetre)
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteJ.png")
			lumiere_checkpoint.make_lumiere_piste_jaune (a_fenetre)
			x := 59
			y := 330
			checkpoint_liste.extend (Checkpoint_jaune_1)
			checkpoint_liste.extend (Checkpoint_jaune_2)
			checkpoint_liste.extend (Checkpoint_jaune_3)
			checkpoint_liste.extend (Checkpoint_jaune_4)
			checkpoint_liste.extend (Depart_jaune)
			checkpoint_liste.start
		ensure
			Position_Depart_X: x = 59
			Position_Depart_Y: y = 330
		end

	make_mauve (a_fenetre: FENETRE)
			-- Construit la piste Mauve dans la fenêtre (a_fenetre).
		do
			make(a_fenetre)
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteM.png")
			lumiere_checkpoint.make_lumiere_piste_mauve (a_fenetre)
			x := 33
			y := 330
			checkpoint_liste.extend (Checkpoint_mauve_1)
			checkpoint_liste.extend (Checkpoint_mauve_2)
			checkpoint_liste.extend (Checkpoint_mauve_3)
			checkpoint_liste.extend (Checkpoint_mauve_4)
			checkpoint_liste.extend (Checkpoint_mauve_5)
			checkpoint_liste.extend (Checkpoint_mauve_6)
			checkpoint_liste.extend (Checkpoint_mauve_7)
			checkpoint_liste.extend (Depart_mauve)
			checkpoint_liste.start
		ensure
			Position_Depart_X: x = 33
			Position_Depart_Y: y = 330
		end

	make_bleu (a_fenetre: FENETRE)
			-- Construit la piste Bleue dans la fenêtre (a_fenetre).
		do
			make(a_fenetre)
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteB.png")
			lumiere_checkpoint.make_lumiere_piste_bleue (a_fenetre)
			x := 48
			y := 260
			checkpoint_liste.extend (Checkpoint_bleue_1)
			checkpoint_liste.extend (Checkpoint_bleue_2)
			checkpoint_liste.extend (Checkpoint_bleue_3)
			checkpoint_liste.extend (Checkpoint_bleue_4)
			checkpoint_liste.extend (Depart_bleue)
			checkpoint_liste.start
		ensure
			Position_Depart_X: x = 48
			Position_Depart_Y: y = 260
		end

feature {ANY} -- Access

	valider_checkpoint(a_position_x, a_position_y: INTEGER; a_fenetre: GAME_RENDERER)
			-- Regarde si le vaisseau a traversé un checkpoint (a_position_x et a_position_y) dans la fenêtre (a_fenetre).
		local
			checkpoint_valeurs: like checkpoint_liste.item
		do
			checkpoint_valeurs := checkpoint_liste.at (index_suivant_checkpoint)
			if
				a_position_x > checkpoint_valeurs.x1 and a_position_x < checkpoint_valeurs.x2 and
				a_position_y > checkpoint_valeurs.y1 and a_position_y < checkpoint_valeurs.y2
			then
				if index_suivant_checkpoint = checkpoint_liste.count then
					tours.incrementer_tour (True)
					index_suivant_checkpoint := (index_suivant_checkpoint \\ checkpoint_liste.count) + 1
				else
					print("Checkpoint!%N")
					index_suivant_checkpoint := (index_suivant_checkpoint \\ checkpoint_liste.count) + 1
				end
			end
			tours.afficher_tours (True)
		end

	allumer_lumiere(a_fenetre: GAME_RENDERER)
			-- Permet d'allumer les lumières des checkpoints dans la fenêtre (a_fenetre) si nécessaire.
		do
			from
				lumiere_checkpoint.lumiere_liste.start
			until
				lumiere_checkpoint.lumiere_liste.exhausted
			loop
				if lumiere_checkpoint.lumiere_liste.index < index_suivant_checkpoint then
					lumiere_checkpoint.lumiere_verte.afficher (
															lumiere_checkpoint.lumiere_liste.item.x,
															lumiere_checkpoint.lumiere_liste.item.y,
															a_fenetre
															)
				else
					lumiere_checkpoint.lumiere_rouge.afficher (
															lumiere_checkpoint.lumiere_liste.item.x,
															lumiere_checkpoint.lumiere_liste.item.y,
															a_fenetre
															)
				end
				lumiere_checkpoint.lumiere_liste.forth
			end
		end

feature {ANY} -- Implementation

	index_suivant_checkpoint: INTEGER
			-- L'index du prochain checkpoint dans la liste.

	piste: AFFICHABLE
			-- L'image de la piste pour la partie.

	x: INTEGER
			-- La position de départ de la piste en X.

	y: INTEGER
			-- La position de départ de la piste en Y.

	checkpoint_liste: LIST [TUPLE [x1, y1, x2, y2: INTEGER]]
			-- Liste qui contient les constantes des coordonnées des checkpoints.

	checkpoint_passe: BOOLEAN
			-- Détermine si le checkpoint est passé ou non.

	lumiere_checkpoint: LUMIERE_CHECKPOINT
			-- La lumière d'un checkpoint.

	tours: TOURS_PISTE
			-- Le nombre de tours de la partie.

	font: TEXT_FONT

	couleur: GAME_COLOR

feature {NONE} -- Constantes

	Checkpoint_verte_1: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 1 de la piste verte.
		once
			Result := [374, 114, 380, 180]
		end

	Checkpoint_verte_2: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 2 de la piste verte.
		once
			Result := [554, 451, 560, 536]
		end

	Checkpoint_verte_3: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 3 de la piste verte.
		once
			Result := [193, 356, 200, 417]
		end

	Checkpoint_jaune_1: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 1 de la piste jaune.
		once
			Result := [315, 28, 325, 90]
		end

	Checkpoint_jaune_2: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 2 de la piste jaune.
		once
			Result := [500, 126, 510, 192]
		end

	Checkpoint_jaune_3: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 3 de la piste jaune.
		once
			Result := [531, 423, 631, 443]
		end

	Checkpoint_jaune_4: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du checkpoint 4 de la piste jaune.
		once
			Result := [265, 358, 275, 425]
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
end
