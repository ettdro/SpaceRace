note
	description: "Summary description for {AFFICHAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AFFICHAGE

inherit
	GAME_LIBRARY_SHARED

	IMG_LIBRARY_SHARED

create
	make_affichage

feature {NONE} -- Initialization

	make_affichage
			-- Initialization for `Current'.
		local
			l_fenetre:FENETRE
			l_fond:FOND_ECRAN
		do
			create l_fenetre.make_fenetre
			create l_fond.make_fond_ecran("space.png")
		end

	make_with_window(a_window:GAME_WINDOW_SURFACED) --Pour overwrite la fenetre (Pour pas �tre oblig� de cr�er une fen�tre � chaque fois
	--M�thode � faire.
		do
		end
end
