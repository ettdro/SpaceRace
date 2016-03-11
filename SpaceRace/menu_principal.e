note
	description: "Affiche le menu de démarrage où l'on peut choisir de jouer ou les options."
	author: "Étienne Drolet & Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

class
	MENU_PRINCIPAL

inherit

	MENU

	GAME_LIBRARY_SHARED

	IMG_LIBRARY_SHARED

	AUDIO_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialization

	make
			-- Construit les éléments de MENU_PRINCIPAL.
		do
			create fenetre.make
			create son_click.creer
			create musique.creer
			create bouton_jouer.creer_affichable (fenetre.fenetre.renderer, "bouton_jouer2.png")
			create bouton_options.creer_affichable (fenetre.fenetre.renderer, "bouton_options2.png")
			create bouton_quitter.creer_affichable (fenetre.fenetre.renderer, "bouton_quitter2.png")
			create logo.creer_affichable (fenetre.fenetre.renderer, "logo2.png")
		end

feature -- Access

	execution
			-- Boucle principale du jeu.
		do
			generer_fenetre_principal(1, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
			musique.jouer(True)
			fenetre.fenetre.mouse_button_pressed_actions.extend (agent action_souris(?, ?, ?, fenetre.fenetre))
			game_library.quit_signal_actions.extend (agent quitter_jeu)
			game_library.launch
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8; a_fenetre: GAME_WINDOW_RENDERED)
			-- Méthode qui gère les clicks de souris pour permettre la navigation à partir de ce menu.
		do
			if a_etat_souris.is_left_button_pressed then
				if a_etat_souris.x > 399 and a_etat_souris.x < 607 and a_etat_souris.y > 449 and a_etat_souris.y < 507 then
					quitter_jeu (1)
				elseif a_etat_souris.x > 399 and a_etat_souris.x < 607 and a_etat_souris.y > 349 and a_etat_souris.y < 407 then
					son_click.jouer(False)
					generer_fenetre_options(0, fenetre.fenetre.renderer)
				elseif a_etat_souris.x > 399 and a_etat_souris.x < 607 and a_etat_souris.y > 249 and a_etat_souris.y < 307 then
					son_click.jouer(False)
				end
			end
		end

feature {NONE} -- Implementation

	generer_fenetre_principal (a_temps: NATURAL_32; l_renderer: GAME_RENDERER)
			-- Dessine les éléments de la fenêtre.
		do
			bouton_jouer.afficher (bouton_jouer, 400, 250, fenetre.fenetre.renderer)
			bouton_options.afficher (bouton_options, 400, 350, fenetre.fenetre.renderer)
			bouton_quitter.afficher (bouton_quitter, 400, 450, fenetre.fenetre.renderer)
			logo.afficher (logo, 250, 75, fenetre.fenetre.renderer)
		end

	generer_fenetre_options (a_temps: NATURAL_32; l_renderer: GAME_RENDERER)
		do
			fenetre.fenetre.renderer.clear
			fenetre.fenetre.renderer.draw_texture (fenetre.fond, 0, 0)
			fenetre.fenetre.clear_events
			fenetre.fenetre.renderer.present
		end

feature {ANY}

	son_click: EFFETS_SONORES

	musique: MUSIQUE

	bouton_jouer: BOUTONS

	bouton_options: BOUTONS

	bouton_quitter: BOUTONS

	logo: BOUTONS

	fenetre: FENETRE
end
