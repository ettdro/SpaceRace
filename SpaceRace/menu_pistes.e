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

	make (a_fenetre: FENETRE; a_musique: MUSIQUE; a_son_click: EFFETS_SONORES)
			-- Construit le menu pour choisir la piste.
		do
			Precursor (a_fenetre, a_musique, a_son_click)
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			create bouton_suivant.creer_affichable (fenetre.fenetre.renderer, "bouton_suivant.png")
			create titre.creer_affichable (fenetre.fenetre.renderer, "choisir_piste.png")
			create cadre.creer_affichable (fenetre.fenetre.renderer, "bordure_pistes.png")
			create cadre_selectionne.creer_affichable (fenetre.fenetre.renderer, "bordure_pistes_selectionne.png")
			create piste_facile.creer_affichable (a_fenetre.fenetre.renderer, "piste_facile_cadre.png")
			create piste_moyen.creer_affichable (a_fenetre.fenetre.renderer, "piste_moyen_cadre.png")
			create piste_difficile.creer_affichable (a_fenetre.fenetre.renderer, "piste_difficile_cadre.png")
			create piste_extreme.creer_affichable (a_fenetre.fenetre.renderer, "piste_extreme_cadre.png")
			liste_coordonnees.extend ([30, 520, 236, 576]) -- Coordonnées du bouton RETOUR. (position liste = 1)
			liste_coordonnees.extend ([760, 520, 966, 576]) -- Coordonnées du bouton SUIVANT. (position liste = 2)
			liste_coordonnees.extend ([200, 120, 450, 270]) -- Coordonnées du bouton CADRE_1. (position liste = 3)
			liste_coordonnees.extend ([550, 120, 800, 270]) -- Coordonnées du bouton CADRE_2. (position liste = 4)
			liste_coordonnees.extend ([200, 300, 450, 450]) -- Coordonnées du bouton CADRE_3. (position liste = 5)
			liste_coordonnees.extend ([550, 300, 800, 450]) -- Coordonnées du bouton CADRE_4. (position liste = 6)
			liste_coordonnees.start
		end

feature -- Access

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
				if a_etat_souris.x > 29 and a_etat_souris.x < 237 and a_etat_souris.y > 519 and a_etat_souris.y < 577 then
						-- Bouton RETOUR
					verifier_si_muet
					curseur.reinitialiser_curseur
					retour_pistes := True
					quitter := False
					game_library.stop
				elseif a_etat_souris.x > 759 and a_etat_souris.x < 917 and a_etat_souris.y > 519 and a_etat_souris.y < 577 then
						-- Bouton SUIVANT
					if suivant_est_visible then
						verifier_si_muet
						curseur.reinitialiser_curseur
						lancer_fenetre_vaisseaux
					end
				elseif a_etat_souris.x > 200 and a_etat_souris.x < 450 and a_etat_souris.y > 120 and a_etat_souris.y < 270 then
					create piste.make_vert (fenetre)
					verifier_si_muet
					liste_coordonnees.go_i_th (3) -- CADRE 1
					actualiser_cadre (liste_coordonnees.item)
					deselectionner_cadre
				elseif a_etat_souris.x > 550 and a_etat_souris.x < 800 and a_etat_souris.y > 120 and a_etat_souris.y < 270 then
					create piste.make_jaune (fenetre)
					verifier_si_muet
					liste_coordonnees.go_i_th (4) -- CADRE 2
					actualiser_cadre (liste_coordonnees.item)
					deselectionner_cadre
				elseif a_etat_souris.x > 200 and a_etat_souris.x < 450 and a_etat_souris.y > 300 and a_etat_souris.y < 450 then
					create piste.make_mauve (fenetre)
					verifier_si_muet
					liste_coordonnees.go_i_th (5) -- CADRE 3
					actualiser_cadre (liste_coordonnees.item)
					deselectionner_cadre
				elseif a_etat_souris.x > 550 and a_etat_souris.x < 800 and a_etat_souris.y > 300 and a_etat_souris.y < 450 then
					create piste.make_bleu (fenetre)
					verifier_si_muet
					liste_coordonnees.go_i_th (6) -- CADRE 4
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
			piste_facile.afficher (230, 130, fenetre.fenetre.renderer)
			piste_moyen.afficher (580, 130, fenetre.fenetre.renderer)
			piste_difficile.afficher (230, 310, fenetre.fenetre.renderer)
			piste_extreme.afficher (580, 310, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
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

	cadre_selectionne: AFFICHABLE

	suivant_est_visible: BOOLEAN

	piste: detachable PISTE

	titre: AFFICHABLE

	bouton_suivant: AFFICHABLE

	bouton_retour: AFFICHABLE

	piste_facile: AFFICHABLE

	piste_moyen: AFFICHABLE

	piste_difficile: AFFICHABLE

	piste_extreme: AFFICHABLE

end
