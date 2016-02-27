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

create
	make_principal

feature {NONE} -- Initialization

	make_principal
			-- Initialization de `Current'.
		do
			game_library.enable_video
			image_file_library.enable_image (True, True, False)
			execution
			image_file_library.quit_library
			game_library.quit_library
		end

	execution
			-- Boucle principale du jeu.
		local
			l_musique: FENETRE
		do
			make_affichage
			--create l_musique.ajuster_son (l_fenetre)
			game_library.quit_signal_actions.extend (agent quitter_jeu)
				--	elsif "bouton 'Quitter' presse" then
				--		quitter_jeu(true)
				--	end
			game_library.launch
		end

	navigation (a_choix: INTEGER)
		do
			print ("Navigation")
		end

	quitter_jeu (a: NATURAL_32)
		do
			game_library.stop
		end

end
