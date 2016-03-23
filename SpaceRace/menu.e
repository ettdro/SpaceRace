note
	description: "Contient les méthodes de gestion que tous les menus se doivent d'avoir."
	author: "Étienne Drolet & Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

deferred class
	MENU

inherit

	AUDIO_LIBRARY_SHARED

	GAME_LIBRARY_SHARED

	IMG_LIBRARY_SHARED

feature {NONE} -- Initialization

	make(a_fenetre: FENETRE; a_musique: MUSIQUE; a_son_click: EFFETS_SONORES)
		do
			fenetre := a_fenetre
			musique := a_musique
			son_click := a_son_click
			create curseur.make
			create {LINKED_LIST[TUPLE[x1, y1, x2, y2:INTEGER]]}liste_coordonnees.make
--			is_quit := False
		end

feature --Access

	quitter_jeu (a_temps: NATURAL_32)
			-- Méthode qui ferme l'application.
		do
			is_quit := True
--			is_quit_credits := True
--			is_quit_options := True
--			is_quit_vaisseaux := True
--			is_quit_principal := True
--			is_quit_comment_jouer := True
--			is_quit_pistes := True
			game_library.stop
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris dans les menus.
		deferred
		end

	mouvements_souris (a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_MOTION_STATE; a_x, a_y: INTEGER_32; a_window: GAME_WINDOW_RENDERED)
			-- When the mouse is moving, update the mouse information (from `a_mouse_state') on the `a_window' using
			-- `a_font' to draw text.
		do
			curseur.est_sur_bouton (a_timestamp, a_mouse_state, a_x, a_y, a_window, liste_coordonnees)
		end

	execution
			-- Faire afficher le menu et leurs images et lancer la gestion de la souris.
		do
			fenetre.fenetre.mouse_motion_actions.extend (agent mouvements_souris(?, ?, ?, ?, fenetre.fenetre))
			game_library.iteration_actions.extend (agent  (a_timestamp: NATURAL)
				do
					audio_library.update
				end)
			fenetre.fenetre.mouse_button_pressed_actions.extend (agent action_souris(?, ?, ?))
			game_library.quit_signal_actions.extend (agent quitter_jeu)
		end

feature {ANY} -- Implementation

	is_quit: BOOLEAN

	is_retour: BOOLEAN

	fenetre: FENETRE

	musique: MUSIQUE

	son_click: EFFETS_SONORES

	curseur: CURSEUR

	liste_coordonnees: LIST[TUPLE[x1, y1, x2, y2:INTEGER]]

end
