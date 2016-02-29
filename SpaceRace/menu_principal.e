note
	description: "Affiche le menu de d�marrage o� l'on peut choisir de jouer ou les options."
	author: "�tienne Drolet & Nicolas Bisson"
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
		do
			make_affichage
			game_library.quit_signal_actions.extend (agent quitter_jeu)
			game_library.launch
		end

	navigation (a_choix: INTEGER)
			-- M�thode qui permet de changer au menu choisi.
		do
			print ("Navigation")
				--	elsif "bouton 'Quitter' presse" then
				--		quitter_jeu(true)
				--	end
		end

	quitter_jeu (a: NATURAL_32)
			-- M�thode qui ferme le programme.
		do
			game_library.stop
		end

end
