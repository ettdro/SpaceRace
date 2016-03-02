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
			-- M�thode qui ferme le programme.
		do
			game_library.stop
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8; a_fenetre: GAME_WINDOW_RENDERED)
			-- M�thode qui g�re les actions de la souris dans les menus.
		deferred
		end

	execution
			-- Faire afficher le menu.
		deferred
		end

end
