note
	description: "Classe qui affiche les images dans la fen�tre."
	author: "�tienne Drolet et Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

class
	AFFICHAGE

inherit

	GAME_LIBRARY_SHARED

	IMG_LIBRARY_SHARED

create
	make_fenetre_menu

feature {NONE} -- Initialization

	make_fenetre_menu
			-- Construit la fen�tre du MENU_PRINCIPAL.
		local
			l_fenetre: FENETRE
		do
			create l_fenetre.make
		end

		--	make_with_window (a_window: GAME_WINDOW_SURFACED) --Pour overwrite la fenetre (Pour pas �tre oblig� de cr�er une fen�tre � chaque fois)
		--			-- M�thode � faire.
		--		do
		--		end

end
