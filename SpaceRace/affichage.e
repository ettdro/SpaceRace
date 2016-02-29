note
	description: "Classe qui affiche les images dans la fenêtre."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

class
	AFFICHAGE

inherit

	GAME_LIBRARY_SHARED

	IMG_LIBRARY_SHARED

create
	make_ecran

feature {NONE} -- Initialization

	make_ecran
			-- Initialization for `Current'.
		local
			l_fenetre: FENETRE
		do
			create l_fenetre.make
		end

	make_with_window (a_window: GAME_WINDOW_SURFACED) --Pour overwrite la fenetre (Pour pas être obligé de créer une fenêtre à chaque fois)
			-- Méthode à faire.
		do
		end

feature {ANY}

		--	fenetre:GAME_WINDOW_RENDERED

end
