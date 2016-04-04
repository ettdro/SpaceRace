note
	description: "Classe pour gérer le jeu qui consiste à faire une course pour enregistrer le meilleur temps."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-04-03"
	revision: "1.1"

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

	make (a_fenetre: FENETRE; a_musique: MUSIQUE; a_son_click: EFFETS_SONORES; a_piste_selectionne: STRING; a_vaisseau_selectionne: STRING)
			-- Construit le menu du jeu et ses images.
		do
			piste_selectionne := a_piste_selectionne
			vaisseau_selectionne := a_vaisseau_selectionne
			make_menu (a_fenetre, a_musique, a_son_click)
			create titre_tours.creer_affichable (fenetre.fenetre.renderer, "titre_tours.png")
			create titre_chrono.creer_affichable (fenetre.fenetre.renderer, "titre_chrono.png")
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			create bouton_pause.creer_affichable (fenetre.fenetre.renderer, "bouton_pause.png")
			create bouton_jouer.creer_affichable (fenetre.fenetre.renderer, "bouton_jouer2.png")
			create piste.creer_affichable (fenetre.fenetre.renderer, piste_selectionne)
			create vaisseau.creer_affichable (fenetre.fenetre.renderer, vaisseau_selectionne)
			create {LINKED_LIST [TUPLE [x, y: INTEGER]]} liste_depart.make
			liste_coordonnees.extend ([760, 520, 966, 576]) -- Coordonnées du bouton RETOUR.
			liste_coordonnees.extend ([760, 420, 966, 476]) -- Coordonnées du bouton PAUSE.
			liste_coordonnees.extend ([760, 320, 966, 376]) -- Coordonnées du bouton JOUER.
			liste_depart.extend ([53, 245]) -- Coordonnées piste VERTE
			liste_depart.extend ([59, 330]) -- Coordonnées piste JAUNE
			liste_depart.extend ([50, 300]) -- Coordonnées piste MAUVE
			liste_depart.extend ([42, 260]) -- Coordonnées piste BLEUE
			liste_depart.start
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
					-- BOUTON RETOUR
					if not musique.est_muet then
						son_click.jouer (False)
					end
					curseur.reinitialiser_curseur
					retour_jeu_principal := True
					quitter := False
					game_library.stop
				elseif a_etat_souris.x > 759 and a_etat_souris.x < 917 and a_etat_souris.y > 419 and a_etat_souris.y < 477 then
					-- BOUTON PAUSE
					if not musique.est_muet then
						son_click.jouer (False)
					end
					curseur.reinitialiser_curseur
						-- STOP LE CHRONO ET LES MOUVEMENTS DU VAISSEAU
				elseif a_etat_souris.x > 759 and a_etat_souris.x < 917 and a_etat_souris.y > 319 and a_etat_souris.y < 377 then
					-- BOUTON JOUER
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
			piste.afficher (0, 0, fenetre.fenetre.renderer)
			choix_vaisseau
			print(liste_depart.item.x)
			vaisseau.afficher (liste_depart.item.x, liste_depart.item.y, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

		choix_vaisseau
				-- Gère le bon choix du vaisseau pour afficher le bon à l'écran.
			do
				if vaisseau_selectionne = "vaisseau1.png" then
					if piste_selectionne = "pisteV.png" then
						liste_depart.go_i_th (1)
					elseif piste_selectionne = "pisteJ.png" then
						liste_depart.go_i_th (2)
					elseif piste_selectionne = "pisteM.png" then
						liste_depart.go_i_th (3)
					elseif piste_selectionne = "pisteB.png" then
						liste_depart.go_i_th (4)
					end
				end
				if vaisseau_selectionne = "vaisseau2.png" then
					if piste_selectionne = "pisteV.png" then
						liste_depart.go_i_th (1)
					end
					if piste_selectionne = "pisteJ.png" then
						liste_depart.go_i_th (2)
					end
					if piste_selectionne = "pisteM.png" then
						liste_depart.go_i_th (3)
					end
					if piste_selectionne = "pisteB.png" then
						liste_depart.go_i_th (4)
					end
				end
				if vaisseau_selectionne = "vaisseau3.png" then
					if piste_selectionne = "pisteV.png" then
						liste_depart.go_i_th (1)
					elseif piste_selectionne = "pisteJ.png" then
						liste_depart.go_i_th (2)
					elseif piste_selectionne = "pisteM.png" then
						liste_depart.go_i_th (3)
					elseif piste_selectionne = "pisteB.png" then
						liste_depart.go_i_th (4)
					end
				end
			end

feature {ANY} -- Implementation

	bouton_retour: AFFICHABLE

	bouton_pause: AFFICHABLE

	bouton_jouer: AFFICHABLE

	titre_tours: AFFICHABLE

	titre_chrono: AFFICHABLE

	liste_depart: LIST[TUPLE[x, y:INTEGER]]

	piste_selectionne: STRING

	vaisseau_selectionne: STRING

	piste: AFFICHABLE

	vaisseau: AFFICHABLE

end
