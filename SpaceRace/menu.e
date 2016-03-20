note
	description: "Contient les méthodes que tous les menus se doivent d'avoir."
	author: "Étienne Drolet & Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

deferred class
	MENU

inherit

	AFFICHAGE

	AUDIO_LIBRARY_SHARED

feature --Access

	quitter_jeu (a_temps: NATURAL_32)
			-- Méthode qui ferme le programme.
		do
			game_library.stop
			is_quit_selected := True
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris dans les menus.
		deferred
		end

--	mouvements_souris (a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_MOTION_STATE; a_delta_x, a_delta_y: INTEGER_32; a_window: GAME_WINDOW_RENDERED)
--			-- When the mouse is moving, update the mouse information (from `a_mouse_state') on the `a_window' using
--			-- `a_font' to draw text.
--		deferred
--		end

	execution
			-- Faire afficher le menu.
		do
			game_library.iteration_actions.extend (agent  (a_timestamp: NATURAL)
				do
					audio_library.update
				end)
			fenetre.fenetre.mouse_button_pressed_actions.extend (agent action_souris(?, ?, ?))
			game_library.quit_signal_actions.extend (agent quitter_jeu)
		end

feature {ANY} -- Implementation

	is_quit_selected: BOOLEAN

	fenetre: FENETRE

	musique: MUSIQUE

	son_click: EFFETS_SONORES

end
