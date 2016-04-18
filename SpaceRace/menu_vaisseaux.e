note
	description: "Gère le menu où l'on choisi le modèle du vaisseau avec lequel courser."
	author: "Nicolas Bisson et Étienne Drolet"
	date: "2016-04-03"
	revision: "1.1"

class
	MENU_VAISSEAUX

inherit

	MENU
		rename
			make as make_menu
		redefine
			execution
		end

create
	make

feature {NONE} -- Initialization

	make (a_fenetre: FENETRE; a_musique: MUSIQUE; a_son_click: EFFETS_SONORES; a_piste_selectionne: PISTE)
			-- Construit le menu pour choisir le vaisseaux.
		do
			make_menu (a_fenetre, a_musique, a_son_click)
			piste_selectionne := a_piste_selectionne
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			create bouton_suivant.creer_affichable (fenetre.fenetre.renderer, "bouton_suivant.png")
			create titre.creer_affichable (fenetre.fenetre.renderer, "choisir_vaisseau.png")
			create cadre.creer_affichable (fenetre.fenetre.renderer, "bordure_vaisseaux.png")
			create cadre_selectionne.creer_affichable (fenetre.fenetre.renderer, "bordure_vaisseaux_selectionne.png")
			create vaisseau1.creer_affichable (fenetre.fenetre.renderer, "vaisseau1_cadre.png")
			create vaisseau2.creer_affichable (fenetre.fenetre.renderer, "vaisseau2_cadre.png")
			create vaisseau3.creer_affichable (fenetre.fenetre.renderer, "vaisseau3_cadre.png")
			liste_coordonnees.extend ([30, 520, 236, 576]) -- Coordonnées du bouton RETOUR.
			liste_coordonnees.extend ([760, 520, 966, 576]) -- Coordonnées du bouton SUIVANT.
			liste_coordonnees.extend ([200, 200, 380, 380]) -- Coordonnées du bouton CADRE_1.
			liste_coordonnees.extend ([430, 200, 610, 380]) -- Coordonnées du bouton CADRE_2.
			liste_coordonnees.extend ([660, 200, 840, 380]) -- Coordonnées du bouton CADRE_3.
			liste_coordonnees.start
		ensure
			Piste_Assigne: piste_selectionne = a_piste_selectionne
		end

feature -- Access

	execution
			-- Faire afficher le menu et ses images et lancer la gestion de la souris.
		do
			from
				quitter := False
				retour_vaisseaux := False
			until
				quitter or retour_vaisseaux
			loop
				game_library.clear_all_events
				lancer_fenetre_vaisseaux
				Precursor {MENU}
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris dans le menu.
		do
			if a_etat_souris.is_left_button_pressed then
				if a_etat_souris.x > 29 and a_etat_souris.x < 237 and a_etat_souris.y > 519 and a_etat_souris.y < 577 then
						-- Bouton RETOUR
					verifier_si_muet
					curseur.reinitialiser_curseur
					retour_vaisseaux := True
					quitter := False
					game_library.stop
				elseif a_etat_souris.x > 759 and a_etat_souris.x < 917 and a_etat_souris.y > 519 and a_etat_souris.y < 577 then
						-- Bouton SUIVANT
					if suivant_est_visible then
						verifier_si_muet
						curseur.reinitialiser_curseur
						lancer_fenetre_jeu_principal
					end
				elseif a_etat_souris.x > 200 and a_etat_souris.x < 380 and a_etat_souris.y > 200 and a_etat_souris.y < 380 then
					create vaisseau_selectionne.make_1 (fenetre)
					verifier_si_muet
					liste_coordonnees.go_i_th (3) -- CADRE 1
					actualiser_cadre (liste_coordonnees.item)
					deselectionner_cadre
				elseif a_etat_souris.x > 430 and a_etat_souris.x < 610 and a_etat_souris.y > 200 and a_etat_souris.y < 380 then
					create vaisseau_selectionne.make_2 (fenetre)
					verifier_si_muet
					liste_coordonnees.go_i_th (4) -- CADRE 2
					actualiser_cadre (liste_coordonnees.item)
					deselectionner_cadre
				elseif a_etat_souris.x > 660 and a_etat_souris.x < 840 and a_etat_souris.y > 200 and a_etat_souris.y < 380 then
					create vaisseau_selectionne.make_3 (fenetre)
					verifier_si_muet
					liste_coordonnees.go_i_th (5) -- CADRE 3
					actualiser_cadre (liste_coordonnees.item)
					deselectionner_cadre
				end
			end
		end

feature {NONE}

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
					liste_coordonnees.move (1)
				end
			end
		end

	lancer_fenetre_vaisseaux
			-- Dessine les éléments de la fenêtre.
		do
			suivant_est_visible := False
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			titre.afficher (180, 30, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			cadre.afficher (200, 200, fenetre.fenetre.renderer)
			vaisseau1.afficher (240, 230, fenetre.fenetre.renderer)
			cadre.afficher (430, 200, fenetre.fenetre.renderer)
			vaisseau2.afficher (470, 230, fenetre.fenetre.renderer)
			cadre.afficher (660, 200, fenetre.fenetre.renderer)
			vaisseau3.afficher (700, 230, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

	lancer_fenetre_jeu_principal
			-- Lance le menu du jeu principal
		require
			Vaisseau_Selectionne: attached vaisseau_selectionne
		local
			l_menu_jeu_principal: JEU_PRINCIPAL
		do
			if attached vaisseau_selectionne as la_vaisseau_selectionne then
				create l_menu_jeu_principal.make (fenetre, musique, son_click, piste_selectionne, la_vaisseau_selectionne)
				l_menu_jeu_principal.execution
				quitter := l_menu_jeu_principal.quitter
			end
		end

feature {ANY} -- Implementation

	titre: AFFICHABLE -- L'image du titre du menu.

	vaisseau1: AFFICHABLE -- L'image du vaisseau 1.

	vaisseau2: AFFICHABLE -- L'image du vaisseau 2.

	vaisseau3: AFFICHABLE -- L'image du vaisseau 3.

	piste_selectionne: PISTE -- La piste qui a été choisie.

	vaisseau_selectionne: detachable VAISSEAU -- Le vaisseau qui est choisi au final. "detachable" parce qu'au départ, il n'y a pas de vaisseau.

	cadre: AFFICHABLE -- L'image d'un cadre non-sélectionné.

	bouton_retour: AFFICHABLE -- L'image du bouton "RETOUR"

	bouton_suivant: AFFICHABLE -- L'image du bouton "SUIVANT"

	cadre_selectionne: AFFICHABLE -- L'image d'un cadre sélectionné.

	suivant_est_visible: BOOLEAN -- Détermine si le bouton "SUIVANT" est visible.

end
