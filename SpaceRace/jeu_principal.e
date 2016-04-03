note
	description: "Classe pour gérer le jeu qui consiste à faire une course pour enregistrer le meilleur temps."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-04-03"
	revision: "1.1"

class
	JEU_PRINCIPAL

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
			-- Construit le menu du jeu et ses images.
			--		local
			--			nom_piste: STRING
			--			nom_vaisseau: STRING
		do
				-- nom_piste := choix_piste
				-- nom_vaisseau := choix_vaisseau
			Precursor (a_fenetre, a_musique, a_son_click)
			create titre_tours.creer_affichable (fenetre.fenetre.renderer, "titre_tours.png")
			create titre_chrono.creer_affichable (fenetre.fenetre.renderer, "titre_chrono.png")
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			create bouton_pause.creer_affichable (fenetre.fenetre.renderer, "bouton_pause.png")
			create bouton_jouer.creer_affichable (fenetre.fenetre.renderer, "bouton_jouer2.png")
				--			create piste.creer_affichable (fenetre.fenetre.renderer, nom_piste)
				--			create vaisseau.creer_affichable (fenetre.fenetre.renderer, nom_vaisseau)
			liste_coordonnees.extend ([760, 520, 966, 576]) -- Coordonnées du bouton RETOUR.
			liste_coordonnees.extend ([760, 420, 966, 476]) -- Coordonnées du bouton PAUSE.
			liste_coordonnees.extend ([760, 320, 966, 376]) -- Coordonnées du bouton JOUER.
		end

feature -- Access

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
				lancer_fenetre_jeu_principal
				Precursor {MENU}
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris dans le menu.
		do
			if a_etat_souris.is_left_button_pressed then
				if a_etat_souris.x > 759 and a_etat_souris.x < 917 and a_etat_souris.y > 519 and a_etat_souris.y < 577 then
					if not musique.est_muet then
						son_click.jouer (False)
					end
					curseur.reinitialiser_curseur
					retour_jeu_principal := True
					quitter := False
					game_library.stop
				elseif a_etat_souris.x > 759 and a_etat_souris.x < 917 and a_etat_souris.y > 419 and a_etat_souris.y < 477 then
					if not musique.est_muet then
						son_click.jouer (False)
					end
					curseur.reinitialiser_curseur
						-- STOP LE CHRONO ET LES MOUVEMENTS DU VAISSEAU
				elseif a_etat_souris.x > 759 and a_etat_souris.x < 917 and a_etat_souris.y > 319 and a_etat_souris.y < 377 then
					if not musique.est_muet then
						son_click.jouer (False)
					end
					curseur.reinitialiser_curseur
						-- DÉMARRE LA PARTIE (LE CHRONO, LE VAISSEAU PEUT BOUGER, REPREND LA PARTIE SI PAUSE IL Y A)
				end
			end
		end

feature {NONE}

	lancer_fenetre_jeu_principal
			-- Dessine les éléments de la fenêtre.
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			bouton_retour.afficher (760, 520, fenetre.fenetre.renderer)
			bouton_pause.afficher (760, 420, fenetre.fenetre.renderer)
			bouton_jouer.afficher (760, 320, fenetre.fenetre.renderer)
			titre_tours.afficher (760, 160, fenetre.fenetre.renderer)
			titre_chrono.afficher (760, 40, fenetre.fenetre.renderer)
				--			piste.afficher (0, 0, fenetre.fenetre.renderer)
				--			vaisseau.afficher (a_pos_x_vaisseau, a_pos_y_vaisseau, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

		--		choix_piste
		-- Gère le choix de la piste pour afficher la bonne à l'écran et avoir les bonnes coordonnées de départ pour le vaisseau.
		--			if piste_choisie(du menu pistes) := 1 then
		--				nom_piste := "pisteV.png"
		--				a_pos_x_vaisseau := X
		--				a_pos_y_vaisseau := Y
		--			elseif piste_choisie(du menu pistes) := 2 then
		--				nom_piste := "pisteJ.png"
		--				a_pos_x_vaisseau := X
		--				a_pos_y_vaisseau := Y
		--			elseif piste_choisie(du menu pistes) := 3 then
		--				nom_piste := "pisteM.png"
		--				a_pos_x_vaisseau := X
		--				a_pos_y_vaisseau := Y
		--			elseif piste_choisie(du menu pistes) := 4 then
		--				nom_piste := "pisteB.png"
		--				a_pos_x_vaisseau := X
		--				a_pos_y_vaisseau := Y
		--			end

		--		choix_vaisseau
		-- Gère le bon choix du vaisseau pour afficher le bon à l'écran.
		--			if vaisseau_choisi(du menu vaisseaux) := 1 then
		--				nom_vaisseau := "vaisseau1.png"
		--			elseif vaisseau_choisi(du menu vaisseaux) := 2 then
		--				nom_vaisseau := "vaisseau2.png"
		--			elseif vaisseau_choisi(du menu vaisseaux) := 3 then
		--				nom_vaisseau := "vaisseau3.png"
		--			end

		--	VA DEVOIR CRÉER DEUX ATTRIBUTS INTEGER POUR GÉRER LE CODE CI-DESSUS (ATTRIBUTS POUR TOUS LES MENUS??? À VOIR)

feature {ANY} -- Implementation

	bouton_retour: AFFICHABLE

	bouton_pause: AFFICHABLE

	bouton_jouer: AFFICHABLE

	titre_tours: AFFICHABLE

	titre_chrono: AFFICHABLE

		--	piste: AFFICHABLE

		--	vaisseau: AFFICHABLE

		--  a_pos_x_vaisseau: INTEGER

		--	a_pos_y_vaisseau: INTEGER

end
