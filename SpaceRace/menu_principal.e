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

create
	make_principal

feature {NONE} -- Initialization

	make_principal
			-- Initialization de `Current'.
		do
			game_library.enable_video
			execution
			game_library.quit_library
		end

	execution
			-- Boucle principale du jeu.
		local
			l_fenetre: FENETRE
		do
				--l_fenetre := create fenetre.make_fenetre
			make_affichage
				--create musique.ajuster_son (make_affichage)
			game_library.quit_signal_actions.extend (agent quitter_jeu)
				--	elsif "bouton 'Quitter' pressé" then
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
