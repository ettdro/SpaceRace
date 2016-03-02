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
	make_principal

feature {NONE} -- Initialization

	make_principal
			-- Initialization de `Current'.
		do
			game_library.enable_video
			image_file_library.enable_image (True, True, False)
			audio_library.enable_sound
			execution
			audio_library.quit_library
			image_file_library.quit_library
			game_library.quit_library
		end

	execution
			-- Boucle principale du jeu.
		local
			l_fenetre: FENETRE
		do
--			make_fenetre_menu
			create l_fenetre.make_menu_principal
			l_fenetre.fenetre.mouse_button_pressed_actions.extend (agent on_mouse_pressed(?, ?, ?, l_fenetre.fenetre))
			game_library.quit_signal_actions.extend (agent quitter_jeu)
			game_library.launch
		end

	on_mouse_pressed(a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8; a_window:GAME_WINDOW_RENDERED)
		local
			l_fenetre: FENETRE
		do
			if a_mouse_state.is_left_button_pressed then
				if a_mouse_state.x > 400 and a_mouse_state.x < 606 then
					print("QUITTER")
					quitter_jeu(1)
				end
			end
		end

	navigation
			-- Méthode qui permet de changer au menu choisi.
		do
			print ("Navigation")
				--	elsif "bouton 'Quitter' presse" then
				--		quitter_jeu(true)
				--	end
		end

	quitter_jeu (a: NATURAL_32)
			-- Méthode qui ferme le programme.
		do
			game_library.stop
		end

feature {ANY}

--	fenetre: GAME_WINDOW_RENDERED

end
