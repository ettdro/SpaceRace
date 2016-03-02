note
	description: "Contient les m�thodes que tous les menus se doivent d'avoir."
	author: "�tienne Drolet & Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

deferred class
	MENU

inherit

	AFFICHAGE

feature

	quitter_jeu (a_temps: NATURAL_32)
			-- M�thode pour fermer le programme.
		deferred
		end

	action_souris (a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8; a_window: GAME_WINDOW_RENDERED)
			-- M�thode pour changer de menu.
		deferred
		end

	execution
			-- Faire afficher le menu.
		deferred
		end

end
