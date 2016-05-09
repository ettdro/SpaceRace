note
	description: "Gère le menu où l'on choisi la piste sur laquelle courser."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-04-03"
	revision: "1.1"

class
	MENU_PISTES

inherit

	MENU
		redefine
			execution,
			make
		end

create
	make

feature {NONE} -- Initialization

	make (a_fenetre: FENETRE; a_musique: EFFET_SONORE; a_son_click: EFFET_SONORE)
			-- Construit le menu pour choisir la piste.
		do
			Precursor (a_fenetre, a_musique, a_son_click)
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			create bouton_suivant.creer_affichable (fenetre.fenetre.renderer, "bouton_suivant.png")
			create titre.creer_affichable (fenetre.fenetre.renderer, "choisir_piste.png")
			create cadre.creer_affichable (fenetre.fenetre.renderer, "bordure_pistes.png")
			create cadre_selectionne.creer_affichable (fenetre.fenetre.renderer, "bordure_pistes_selectionne.png")
			create piste_verte.creer_affichable (a_fenetre.fenetre.renderer, "piste_facile_cadre.png")
			create piste_jaune.creer_affichable (a_fenetre.fenetre.renderer, "piste_moyen_cadre.png")
			create piste_mauve.creer_affichable (a_fenetre.fenetre.renderer, "piste_difficile_cadre.png")
			create piste_bleue.creer_affichable (a_fenetre.fenetre.renderer, "piste_extreme_cadre.png")
			liste_coordonnees.extend (Bouton_retour_coordonnees)
			liste_coordonnees.extend (Bouton_suivant_coordonnees)
			liste_coordonnees.extend (Bouton_cadre_haut_gauche_coordonnees)
			liste_coordonnees.extend (Bouton_cadre_haut_droite_coordonnees)
			liste_coordonnees.extend (Bouton_cadre_bas_gauche_coordonnees)
			liste_coordonnees.extend (Bouton_cadre_bas_droite_coordonnees)
			liste_coordonnees.start
		end

feature {ANY} -- Access

	execution
			-- Faire afficher le menu et ses images et lancer la gestion de la souris.
		do
			from
				quitter := False
				retour_pistes := False
			until
				quitter or retour_pistes
			loop
				game_library.clear_all_events
				lancer_fenetre_pistes
				Precursor {MENU}
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris dans les menus.
		do
			if a_etat_souris.is_left_button_pressed then
				valider_bouton_retour (a_etat_souris.x, a_etat_souris.y)
				valider_bouton_suivant (a_etat_souris.x, a_etat_souris.y)
				valider_cadre_haut_gauche (a_etat_souris.x, a_etat_souris.y)
				valider_cadre_haut_droite (a_etat_souris.x, a_etat_souris.y)
				valider_cadre_bas_gauche (a_etat_souris.x, a_etat_souris.y)
				valider_cadre_bas_droite (a_etat_souris.x, a_etat_souris.y)
			end
		end

	valider_bouton_retour (a_x, a_y: INTEGER)
			-- Méthode vérifiant si la souris est sur le bouton RETOUR et exécute l'action en conséquence.
		do
			if
				a_x > Bouton_retour_coordonnees.x1 and
				a_x < Bouton_retour_coordonnees.x2 and
				a_y > Bouton_retour_coordonnees.y1 and
				a_y < Bouton_retour_coordonnees.y2
			then
				verifier_si_muet
				curseur.reinitialiser_curseur
				retour_pistes := True
				quitter := False
				game_library.stop
			end
		end

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
					lancer_fenetre_vaisseaux
				end
			end
		end

	valider_cadre_haut_gauche (a_x, a_y: INTEGER)
			-- Méthode vérifiant si la souris est sur le cadre en haut à gauche et exécute l'action en conséquence.
		do
			if
				a_x > Bouton_cadre_haut_gauche_coordonnees.x1 and
				a_x < Bouton_cadre_haut_gauche_coordonnees.x2 and
				a_y > Bouton_cadre_haut_gauche_coordonnees.y1 and
				a_y < Bouton_cadre_haut_gauche_coordonnees.y2
			then
				create piste.make_vert (fenetre)
				verifier_si_muet
				liste_coordonnees.go_i_th (3)
				actualiser_cadre (liste_coordonnees.item)
				deselectionner_cadre
			end
		end

	valider_cadre_haut_droite (a_x, a_y: INTEGER)
			-- Méthode vérifiant si la souris est sur le cadre en haut à droite et exécute l'action en conséquence.
		do
			if
				a_x > Bouton_cadre_haut_droite_coordonnees.x1 and
				a_x < Bouton_cadre_haut_droite_coordonnees.x2 and
				a_y > Bouton_cadre_haut_droite_coordonnees.y1 and
				a_y < Bouton_cadre_haut_droite_coordonnees.y2
			then
				create piste.make_jaune (fenetre)
				verifier_si_muet
				liste_coordonnees.go_i_th (4)
				actualiser_cadre (liste_coordonnees.item)
				deselectionner_cadre
			end
		end

	valider_cadre_bas_gauche (a_x, a_y: INTEGER)
			-- Méthode vérifiant si la souris est sur le cadre en bas à gauche et exécute l'action en conséquence.
		do
			if
				a_x > Bouton_cadre_bas_gauche_coordonnees.x1 and
				a_x < Bouton_cadre_bas_gauche_coordonnees.x2 and
				a_y > Bouton_cadre_bas_gauche_coordonnees.y1 and
				a_y < Bouton_cadre_bas_gauche_coordonnees.y2
			then
				create piste.make_mauve (fenetre)
				verifier_si_muet
				liste_coordonnees.go_i_th (5)
				actualiser_cadre (liste_coordonnees.item)
				deselectionner_cadre
			end
		end

	valider_cadre_bas_droite (a_x, a_y: INTEGER)
			-- Méthode vérifiant si la souris est sur le cadre en bas à droite et exécute l'action en conséquence.
		do
			if
				a_x > Bouton_cadre_bas_droite_coordonnees.x1 and
				a_x < Bouton_cadre_bas_droite_coordonnees.x2 and
				a_y > Bouton_cadre_bas_droite_coordonnees.y1 and
				a_y < Bouton_cadre_bas_droite_coordonnees.y2
			then
				create piste.make_bleu (fenetre)
				verifier_si_muet
				liste_coordonnees.go_i_th (6)
				actualiser_cadre (liste_coordonnees.item)
				deselectionner_cadre
			end
		end

feature {NONE} -- Affichage

	actualiser_cadre (a_liste_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER])
			-- Affiche le cadre en jaune puisqu'il est celui sélectionné et affiche le bouton SUIVANT.
		require
			Liste_Vide: not a_liste_coordonnees.is_empty
			Position_X1_Valide: a_liste_coordonnees.x1 >= 0 and a_liste_coordonnees.x1 <= 1000
			Position_Y1_Valide: a_liste_coordonnees.y1 >= 0 and a_liste_coordonnees.y1 <= 600
			Position_X2_Valide: a_liste_coordonnees.x2 >= 0 and a_liste_coordonnees.x2 <= 1000
			Position_Y2_Valide: a_liste_coordonnees.y2 >= 0 and a_liste_coordonnees.y2 <= 600
		do
			cadre_selectionne.afficher (a_liste_coordonnees.x1, a_liste_coordonnees.y1, fenetre.fenetre.renderer)
			bouton_suivant.afficher (760, 520, fenetre.fenetre.renderer)
			suivant_est_visible := True
			fenetre.fenetre.renderer.present
		ensure
			Bouton_Suivant_Affiche: suivant_est_visible
		end

	deselectionner_cadre
			-- Réaffiche le cadre mauve puisque ce cadre n'est pas sélectionné.
		do
			across
				liste_coordonnees as la_liste_coordonnees
			loop
				if liste_coordonnees.readable then
					cadre.afficher (liste_coordonnees.item.x1, liste_coordonnees.item.y1, fenetre.fenetre.renderer)
					liste_coordonnees.forth
				end
			end
		end

	lancer_fenetre_pistes
			-- Dessine les éléments de la fenêtre.
		do
			suivant_est_visible := False
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			titre.afficher (230, 30, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			cadre.afficher (200, 120, fenetre.fenetre.renderer)
			cadre.afficher (550, 120, fenetre.fenetre.renderer)
			cadre.afficher (200, 300, fenetre.fenetre.renderer)
			cadre.afficher (550, 300, fenetre.fenetre.renderer)
			piste_verte.afficher (230, 130, fenetre.fenetre.renderer)
			piste_jaune.afficher (580, 130, fenetre.fenetre.renderer)
			piste_mauve.afficher (230, 310, fenetre.fenetre.renderer)
			piste_bleue.afficher (580, 310, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		ensure
			Suivant_Visible: suivant_est_visible = False
		end

	lancer_fenetre_vaisseaux
			-- Lance le menu de sélection d'un vaisseau.
		require
			Piste_Selectionne: attached piste
		local
			l_menu_vaisseaux: MENU_VAISSEAUX
		do
			if attached piste as la_piste then
				create l_menu_vaisseaux.make (fenetre, musique, son_click, la_piste)
				l_menu_vaisseaux.execution
				quitter := l_menu_vaisseaux.quitter
			end
		end

feature {ANY} -- Implementation

	cadre: AFFICHABLE
			-- L'image d'un cadre non-sélectionné.

	cadre_selectionne: AFFICHABLE
			-- L'image d'un cadre sélectionné.

	suivant_est_visible: BOOLEAN
			-- Détermine si le bouton "SUIVANT" est visible.

	piste: detachable PISTE
			-- La piste qui est choisie au final. "detachable" parce qu'au départ, il n'y a pas de piste.

	titre: AFFICHABLE
			-- L'image du titre du menu.

	bouton_suivant: AFFICHABLE
			-- L'image du bouton "SUIVANT".

	bouton_retour: AFFICHABLE
			-- L'image du bouton "RETOUR".

	piste_verte: AFFICHABLE
			-- L'image de la piste verte.

	piste_jaune: AFFICHABLE
			-- L'image de la piste jaune.

	piste_mauve: AFFICHABLE
			-- L'image de la piste mauve.

	piste_bleue: AFFICHABLE
			-- L'image de la piste bleue.

feature {NONE} -- Constantes

	Bouton_retour_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du bouton RETOUR.
		once
			Result := [29, 519, 237, 577]
		end

	Bouton_suivant_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du bouton SUIVANT.
		once
			Result := [759, 519, 917, 577]
		end

	Bouton_cadre_haut_gauche_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du cadre en haut à gauche.
		once
			Result := [200, 120, 450, 270]
		end

	Bouton_cadre_haut_droite_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du cadre en haut à droite.
		once
			Result := [550, 120, 800, 270]
		end

	Bouton_cadre_bas_gauche_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du cadre en bas à gauche.
		once
			Result := [200, 300, 450, 450]
		end

	Bouton_cadre_bas_droite_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du cadre en bas à droite.
		once
			Result := [550, 300, 800, 450]
		end

end
