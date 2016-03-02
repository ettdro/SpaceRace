note
	description: "Contient les méthodes que tous les menus se doivent d'avoir."
	author: "Étienne Drolet & Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

deferred class
	MENU

inherit

	AFFICHAGE

feature

	quitter_jeu (a_temps: NATURAL_32)
			-- Méthode qui ferme le programme.
		do
			game_library.stop
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8; a_fenetre: GAME_WINDOW_RENDERED)
			-- Méthode qui gère les actions de la souris dans les menus.
		deferred
		end

	execution
			-- Faire afficher le menu.
		deferred
		end

end
