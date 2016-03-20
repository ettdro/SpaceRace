note
	description: "Classe qui lance la cr�ation de la fen�tre pour l'application."
	author: "�tienne Drolet et Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

class
	AFFICHAGE

inherit

	GAME_LIBRARY_SHARED

	IMG_LIBRARY_SHARED

create
	make_menus

feature {NONE} -- Initialization

	make_menus
			-- Construit la fen�tre de l'application.
		local
			l_fenetre: FENETRE
		do
			create l_fenetre.make
		end

end
