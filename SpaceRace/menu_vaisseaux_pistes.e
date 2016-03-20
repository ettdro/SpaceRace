note
	description: "Gère le menu où l'on décide de faire le choix d'une piste et d'un vaisseau ou de jouer."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

class
	MENU_VAISSEAUX_PISTES

inherit

	MENU
		redefine
			execution
		end

create
	make

feature -- Initialisation

	make (a_fenetre: FENETRE; a_musique: MUSIQUE; a_son_click: EFFETS_SONORES)
			-- Construit le menu pour choisir les vaisseaux et pistes.
		do
			fenetre := a_fenetre
			musique := a_musique
			son_click := a_son_click
			create musique.creer
			create bouton_pistes.creer_affichable (fenetre.fenetre.renderer, "bouton_pistes.png")
			create bouton_vaisseaux.creer_affichable (fenetre.fenetre.renderer, "bouton_vaisseaux.png")
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			create bouton_jouer.creer_affichable (fenetre.fenetre.renderer, "bouton_jouer2.png")
			create fond.make_image (fenetre.fenetre.renderer)
		end

feature -- Access

	execution
			-- Faire afficher le menu et ses images et lancer la gestion de la souris.
		do
			game_library.clear_all_events
			lancer_fenetre_vaisseaux_pistes
			Precursor {MENU}
			game_library.launch
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris dans les menus.
		do
			if a_etat_souris.is_left_button_pressed then
				if a_etat_souris.x > 399 and a_etat_souris.x < 607 and a_etat_souris.y > 149 and a_etat_souris.y < 207 then
						-- LANCE LE "JEU_PRINCIPAL"
				elseif a_etat_souris.x > 399 and a_etat_souris.x < 607 and a_etat_souris.y > 249 and a_etat_souris.y < 307 then
					lancer_fenetre_pistes
				elseif a_etat_souris.x > 399 and a_etat_souris.x < 607 and a_etat_souris.y > 349 and a_etat_souris.y < 407 then
						-- LANCE LE MENU POUR CHOISIR SON VAISSEAU
				elseif a_etat_souris.x > 30 and a_etat_souris.x < 236 and a_etat_souris.y > 519 and a_etat_souris.y < 577 then
					game_library.stop
				end
			end
		end

		--	mouvements_souris (a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_MOTION_STATE; a_delta_x, a_delta_y: INTEGER_32; a_window: GAME_WINDOW_RENDERED)
		--			 When the mouse is moving, update the mouse information (from `a_mouse_state') on the `a_window' using
		--			 `a_font' to draw text.
		--		do
		--		end

feature {NONE}

	lancer_fenetre_vaisseaux_pistes
			-- Dessine les éléments de la fenêtre.
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			bouton_jouer.afficher (400, 150, fenetre.fenetre.renderer)
			bouton_pistes.afficher (400, 250, fenetre.fenetre.renderer)
			bouton_vaisseaux.afficher (400, 350, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

	lancer_fenetre_pistes
			-- Lance le menu de sélection de la piste.
		local
			l_menu_pistes: PISTES
		do
			create l_menu_pistes.make (fenetre, musique, son_click)
			l_menu_pistes.execution
			is_quit_selected := l_menu_pistes.is_quit_selected
		end

	lancer_fenetre_vaisseaux
			-- Lance le menu de sélection du vaisseau.
		local
			l_menu_vaisseaux: MODELES_VAISSEAUX
		do
			create l_menu_vaisseaux.make (fenetre, musique, son_click)
			l_menu_vaisseaux.execution
			is_quit_selected := l_menu_vaisseaux.is_quit_selected
		end

feature {ANY} -- Implementation

	fond: FOND_ECRAN

	bouton_pistes: BOUTONS

	bouton_vaisseaux: BOUTONS

	bouton_retour: BOUTONS

	bouton_jouer: BOUTONS

end
