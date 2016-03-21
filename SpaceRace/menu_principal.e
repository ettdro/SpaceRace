note
	description: "Affiche le menu de démarrage où l'on peut choisir de jouer ou d'aller dans les options."
	author: "Étienne Drolet & Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

class
	MENU_PRINCIPAL

inherit

	MENU
		redefine
			execution
		end

	GAME_LIBRARY_SHARED

	IMG_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialization

	make
			-- Construit le menu principal et ses images.
		do
			create fenetre.make
			create son_click.creer_son_click
			create musique.creer
			create bouton_jouer.creer_affichable (fenetre.fenetre.renderer, "bouton_jouer2.png")
			create bouton_options.creer_affichable (fenetre.fenetre.renderer, "bouton_options2.png")
			create bouton_quitter.creer_affichable (fenetre.fenetre.renderer, "bouton_quitter2.png")
			create logo.creer_affichable (fenetre.fenetre.renderer, "logo2.png")
			create curseur_main.make_hand
			create curseur_defaut.make_arrow
		end

feature -- Access

	execution
			-- Gère le menu principal et le bouton "X" rouge de la fenêtre pour tous les menus.
		do
			musique.jouer (True)
			from
				is_quit_principal := False
			until
				is_quit_principal
			loop
				game_library.clear_all_events
				lancer_fenetre_principal
				fenetre.fenetre.mouse_motion_actions.extend (agent mouvements_souris(?, ?, ?, ?, fenetre.fenetre))
				Precursor {MENU}
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les clicks de souris pour permettre la navigation à partir de ce menu.
		do
			if a_etat_souris.is_left_button_pressed then
				if a_etat_souris.x > 399 and a_etat_souris.x < 607 and a_etat_souris.y > 449 and a_etat_souris.y < 507 then
					quitter_jeu (1)
				elseif a_etat_souris.x > 399 and a_etat_souris.x < 607 and a_etat_souris.y > 349 and a_etat_souris.y < 407 then
					if not musique.est_muet then
						son_click.jouer (False)
					end
					game_library.set_cursor (curseur_defaut)
					is_quit_options := False
					is_quit_principal := True
					lancer_fenetre_options
				elseif a_etat_souris.x > 399 and a_etat_souris.x < 607 and a_etat_souris.y > 249 and a_etat_souris.y < 307 then
					if not musique.est_muet then
						son_click.jouer (False)
					end
					game_library.set_cursor (curseur_defaut)
					is_quit_principal := True
					is_quit_pistes := False
					is_quit_vaisseaux := True
					lancer_fenetre_jouer
				end
			end
		end

	mouvements_souris (a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_MOTION_STATE; a_delta_x, a_delta_y: INTEGER_32; a_window: GAME_WINDOW_RENDERED)
			-- When the mouse is moving, update the mouse information (from `a_mouse_state') on the `a_window' using
			-- `a_font' to draw text.
		do
			x := a_mouse_state.x
			y := a_mouse_state.y
			if (x > 399 and x < 607 and y > 249 and y < 307) or (x > 399 and x < 607 and y > 449 and y < 507) or (x > 399 and x < 607 and y > 349 and y < 407) then
				game_library.set_cursor (curseur_main)
			else
				game_library.set_cursor (curseur_defaut)
			end
		end

feature {NONE}

	lancer_fenetre_principal
			-- Dessine les éléments de la fenêtre.
		do
			fenetre.repeter_fenetre
			bouton_jouer.afficher (400, 250, fenetre.fenetre.renderer)
			bouton_options.afficher (400, 350, fenetre.fenetre.renderer)
			bouton_quitter.afficher (400, 450, fenetre.fenetre.renderer)
			logo.afficher (250, 75, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

	lancer_fenetre_options
			-- Lance le menu des options.
		local
			l_menu_options: MENU_OPTIONS
		do
			create l_menu_options.make (fenetre, musique, son_click)
			l_menu_options.execution
			is_quit_principal := l_menu_options.is_quit_principal
		end

	lancer_fenetre_jouer
			-- Lance le menu de sélection de la piste.
		local
			l_menu_piste: MENU_PISTES
		do
			create l_menu_piste.make (fenetre, musique, son_click)
			l_menu_piste.execution
			is_quit_principal := l_menu_piste.is_quit_principal
		end

feature {ANY} -- Implementation

	bouton_jouer: BOUTONS

	bouton_options: BOUTONS

	bouton_quitter: BOUTONS

	logo: BOUTONS

	is_option_clicked: BOOLEAN

	curseur_main: GAME_CURSOR

	curseur_defaut: GAME_CURSOR

	y, x: INTEGER

end
