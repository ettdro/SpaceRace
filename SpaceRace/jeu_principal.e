note
	description: "Classe pour gérer le jeu qui consiste à faire une course pour enregistrer le meilleur temps."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-04-22"
	revision: "1.2"

class
	JEU_PRINCIPAL

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

	make (a_fenetre: FENETRE; a_musique: MUSIQUE; a_son_click: EFFETS_SONORES; a_piste_selectionne: PISTE; a_vaisseau_selectionne: VAISSEAU)
			-- Construit le menu du jeu et ses images.
		do
			piste_selectionne := a_piste_selectionne
			vaisseau_selectionne := a_vaisseau_selectionne
			vaisseau_y := piste_selectionne.y
			vaisseau_x := piste_selectionne.x
			make_menu (a_fenetre, a_musique, a_son_click)
			if not musique.est_muet then
				doit_afficher_bouton_muet := False
			end
			if musique.est_muet then
				doit_afficher_bouton_muet := True
			end
			create font.make ("impact.ttf", 72)
			font.open
			create couleur.make_rgb (255, 102, 0)
			create bouton_muet.creer_affichable (fenetre.fenetre.renderer, "bouton_muet_jeu.png")
			create bouton_non_muet.creer_affichable (fenetre.fenetre.renderer, "bouton_non_muet_jeu.png")
			create titre_tours.creer_affichable (fenetre.fenetre.renderer, "titre_tours.png")
			create titre_chrono.creer_affichable (fenetre.fenetre.renderer, "titre_chrono.png")
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			create bouton_pause.creer_affichable (fenetre.fenetre.renderer, "bouton_pause.png")
			create bouton_jouer.creer_affichable (fenetre.fenetre.renderer, "bouton_jouer2.png")
			create image_pause.creer_affichable (fenetre.fenetre.renderer, "popup_pause.png")
			create image_cliquez_jouer.creer_affichable (fenetre.fenetre.renderer, "cliquez_jouer.png")
			create chronometre.make (fenetre.fenetre.renderer, font, couleur)
			create tours.make (fenetre.fenetre.renderer, font, couleur)
			liste_coordonnees.extend ([760, 520, 966, 576]) -- Coordonnées du bouton RETOUR.
			liste_coordonnees.extend ([760, 420, 966, 476]) -- Coordonnées du bouton PAUSE.
			liste_coordonnees.extend ([760, 320, 966, 376]) -- Coordonnées du bouton JOUER.
			liste_coordonnees.extend ([930, 0, 999, 48]) -- Coordonnées du bouton MUET.
		ensure
			Piste_Assigne: piste_selectionne = a_piste_selectionne
			Vaisseau_Assigne: vaisseau_selectionne = a_vaisseau_selectionne
			Position_Vaisseau_Y: vaisseau_y = piste_selectionne.y
			Position_Vaisseau_X: vaisseau_x = piste_selectionne.x
		end

feature {ANY} -- Access

	execution
			-- Faire afficher le menu et ses images et lancer la gestion de la souris.
		do
			from
				quitter := False
				retour_jeu_principal := False
			until
				quitter or retour_jeu_principal
			loop
				game_library.clear_all_events
				Precursor {MENU}
				est_debut := True
				deja_afficher := False
				lancer_fenetre_jeu_principal
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris dans le menu.
		do
			if a_etat_souris.is_left_button_pressed then
				valider_bouton_muet (a_etat_souris.x, a_etat_souris.y)
				valider_bouton_jouer(a_temps, a_etat_souris.x, a_etat_souris.y)
				valider_bouton_pause(a_temps, a_etat_souris.x, a_etat_souris.y)
				valider_bouton_retour(a_etat_souris.x, a_etat_souris.y)
			end
		end

	valider_bouton_muet(a_x, a_y:INTEGER)
			-- Méthode vérifiant si la souris est sur le bouton MUET et exécute l'action en conséquence.
		do
			if
				a_x > Bouton_muet_coordonnees.x1 and
				a_x < Bouton_muet_coordonnees.x2 and
				a_y > Bouton_muet_coordonnees.y1 and
				a_y < Bouton_muet_coordonnees.y2
			then
				doit_afficher_bouton_muet := not doit_afficher_bouton_muet
				afficher_bouton_son
				lancer_fenetre_jeu_principal
			end
		end

	valider_bouton_jouer(a_temps: NATURAL_32; a_x, a_y:INTEGER)
			-- Méthode vérifiant si la souris est sur le bouton JOUER et exécute l'action en conséquence.
		do
			if
				a_x > Bouton_jouer_coordonnees.x1 and
				a_x < Bouton_jouer_coordonnees.x2 and
				a_y > Bouton_jouer_coordonnees.y1 and
				a_y < Bouton_jouer_coordonnees.y2
			then
				verifier_si_muet
				if est_debut then
					chronometre.depart_chrono (a_temps)
					fenetre.fenetre.key_pressed_actions.extend (agent action_clavier(?, ?))
				--	fenetre.fenetre.key_released_actions.extend (agent action_clavier_relache(?, ?))
					fenetre.game_library.iteration_actions.extend (agent sur_iteration(?, fenetre.fenetre.renderer))
					est_debut := False
				else
					chronometre.unpause(a_temps)
				end
				curseur.reinitialiser_curseur
			end
		end

	valider_bouton_pause(a_temps:NATURAL_32; a_x, a_y:INTEGER)
			-- Méthode vérifiant si la souris est sur le bouton PAUSE et exécute l'action en conséquence.
		do
			if
				a_x > Bouton_pause_coordonnees.x1 and
				a_x < Bouton_pause_coordonnees.x2 and
				a_y > Bouton_pause_coordonnees.y1 and
				a_y < Bouton_pause_coordonnees.y2
			then
				verifier_si_muet
				chronometre.pause_chrono(a_temps)
				curseur.reinitialiser_curseur
			end
		end

	valider_bouton_retour(a_x, a_y:INTEGER)
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
				retour_jeu_principal := True
				quitter := False
				game_library.stop
			end
		end

	action_clavier (a_timestamp: NATURAL_32; a_etat_clavier: GAME_KEY_STATE)
			-- Vérifie quelle touche est pressée pour pouvoir exécuter la bonne action.
		do
			if not chronometre.pause then
				if a_etat_clavier.is_repeat or not a_etat_clavier.is_repeat then
					if a_etat_clavier.is_up then
						if vaisseau_y >= 1 then
							vaisseau_y := vaisseau_y - 1
							print("X:" + vaisseau_x.out + " Y:" + vaisseau_y.out + "%N")
						end
					end
					if a_etat_clavier.is_down then
						if vaisseau_y <= 559 then
							vaisseau_y := vaisseau_y + 1
							print("X:" + vaisseau_x.out + " Y:" + vaisseau_y.out + "%N")
						end
					end

						-- draw_sub_texture_scale_rotate() pour effectuer une rotation sur le vaisseau

						-- LE MOUVEMENT EN X EST TEMPORAIRE
					if a_etat_clavier.is_left then
						if vaisseau_x >= 1 then
							vaisseau_x := vaisseau_x - 1
							print("X:" + vaisseau_x.out + " Y:" + vaisseau_y.out + "%N")
						end
					end
					if a_etat_clavier.is_right then
						if vaisseau_x <= 700 then
							vaisseau_x := vaisseau_x + 1
							print("X:" + vaisseau_x.out + " Y:" + vaisseau_y.out + "%N")
						end
					end
				end
			end
		end

		--	action_clavier_relache (a_timestamp: NATURAL_32; a_etat_clavier: GAME_KEY_STATE)
		--		do
		--		end

	sur_iteration (a_timestamp: NATURAL_32; a_fenetre: GAME_RENDERER)
			-- Rafraichit la fenêtre du jeu principal à chaque itération.
		do
			if not chronometre.pause then
				chronometre.chronometre (a_timestamp)
			end
			lancer_fenetre_jeu_principal
		end

feature {NONE} -- Affichage

	lancer_fenetre_jeu_principal
			-- Dessine les éléments de la fenêtre.
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			bouton_retour.afficher (760, 520, fenetre.fenetre.renderer)
			bouton_pause.afficher (760, 420, fenetre.fenetre.renderer)
			bouton_jouer.afficher (760, 320, fenetre.fenetre.renderer)
			titre_tours.afficher (760, 160, fenetre.fenetre.renderer)
			titre_chrono.afficher (760, 40, fenetre.fenetre.renderer)
			piste_selectionne.piste.afficher (0, 0, fenetre.fenetre.renderer)
			afficher_bouton_son
			chronometre.afficher_temps
			if chronometre.pause then
				image_pause.afficher (380, 250, fenetre.fenetre.renderer)
			end
			if est_debut then
				image_cliquez_jouer.afficher (100, 250, fenetre.fenetre.renderer)
			end
			if tour_complete then
				tours.afficher_tours (True)
				tour_complete := False
			else
				tours.afficher_tours (False)
			end
			vaisseau_selectionne.vaisseau.afficher (vaisseau_x, vaisseau_y, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

	afficher_bouton_son
			-- Affiche le bon bouton "MUET" selon l'état du son (s'il avait été changé ou non dans le menu "OPTIONS" et celui-ci).
		do
			if doit_afficher_bouton_muet then
				bouton_muet.afficher (935, 0, fenetre.fenetre.renderer)
				musique.mute
			else
				bouton_non_muet.afficher (935, 0, fenetre.fenetre.renderer)
				musique.unmute
			end
		end

	update_vaisseau (a_x, a_y: INTEGER; a_renderer: GAME_RENDERER)
		do
			vaisseau_selectionne.vaisseau.afficher (a_x, a_y, a_renderer)
		end

feature {ANY} -- Implementation

	image_pause: AFFICHABLE	-- L'image du « popup » de pause.

	image_cliquez_jouer: AFFICHABLE	-- L'image du « popup » pour jouer.

	bouton_retour: AFFICHABLE -- L'image du bouton "RETOUR"

	bouton_pause: AFFICHABLE -- L'image du bouton "PAUSE"

	bouton_jouer: AFFICHABLE -- L'image du bouton "JOUER"

	titre_tours: AFFICHABLE -- L'image du titre "TOURS"

	titre_chrono: AFFICHABLE -- L'image du titre "CHRONO"

	piste_selectionne: PISTE -- La piste qui a été choisie.

	vaisseau_selectionne: VAISSEAU -- Le vaisseau qui a été sélectionné.

	bouton_muet: AFFICHABLE -- L'image du bouton "MUET" lorsque le son est muet.

	bouton_non_muet: AFFICHABLE -- L'image du bouton "MUET" lorsque le son est actif.

	doit_afficher_bouton_muet: BOOLEAN -- Détermine lequel des boutons "MUET" sera affiché.

	deja_afficher: BOOLEAN -- Détermine si le vaisseau est déjà affiché.

	vaisseau_y: INTEGER -- La position en Y du vaisseau.

	vaisseau_x: INTEGER -- La position en X du vaisseau.

	chronometre: TEMPS_CHRONOMETRE -- Le chronomètre du jeu.

	font: TEXT_FONT -- La police d'écriture du texte (chornomètre et tours).

	couleur: GAME_COLOR -- La couleur du texte (chronomètre et tours).

	tours: TOURS_PISTE -- Le nombre de tours de la partie.

	est_debut: BOOLEAN -- Détermine s'il s'agit du début de la partie pour afficher le bon temps du chronomètre.

	tour_complete: BOOLEAN -- Détermine si le nombre de tours completés doit changer.


feature {NONE} -- Constantes

	Bouton_retour_coordonnees:TUPLE[x1, y1, x2, y2:INTEGER]		-- Constante représentant les coordonnées du bouton RETOUR.
		once
			Result := [759, 519, 917, 577]
		end

	Bouton_pause_coordonnees:TUPLE[x1, y1, x2, y2:INTEGER]		-- Constante représentant les coordonnées du bouton PAUSE.
		once
			Result := [759, 419, 917, 477]
		end

	Bouton_jouer_coordonnees:TUPLE[x1, y1, x2, y2:INTEGER]		-- Constante représentant les coordonnées du bouton JOUER.
		once
			Result := [759, 319, 917, 377]
		end

	Bouton_muet_coordonnees:TUPLE[x1, y1, x2, y2:INTEGER]		-- Constante représentant les coordonnées du bouton MUET.
		once
			Result := [930, 0, 999, 48]
		end



end
