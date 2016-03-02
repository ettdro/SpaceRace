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
			create son_click.creer
		end

feature -- Access

	execution
			-- Boucle principale du jeu.
		local
			l_fenetre: FENETRE
		do
			create l_fenetre.make_menu_principal
			l_fenetre.fenetre.mouse_button_pressed_actions.extend (agent action_souris(?, ?, ?, l_fenetre.fenetre))
			game_library.quit_signal_actions.extend (agent quitter_jeu)
			game_library.launch
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8; a_fenetre: GAME_WINDOW_RENDERED)
			-- Méthode qui gère les clicks de souris pour permettre la navigation à partir de ce menu.
		do
			if a_etat_souris.is_left_button_pressed then
				if a_etat_souris.x > 400 and a_etat_souris.x < 606 and a_etat_souris.y > 450 and a_etat_souris.y < 506 then
					quitter_jeu (1)
				elseif a_etat_souris.x > 400 and a_etat_souris.x < 606 and a_etat_souris.y > 350 and a_etat_souris.y < 406 then
					son_click.jouer
				elseif a_etat_souris.x > 400 and a_etat_souris.x < 606 and a_etat_souris.y > 250 and a_etat_souris.y < 306 then
					son_click.jouer
				end
			end
		end

	son_click: EFFETS_SONORES

end
