note
	description: "Classe pour générer la fenêtre de l'application."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-04-03"
	revision: "1.2"

class
	FENETRE

inherit

	GAME_LIBRARY_SHARED

	IMG_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialization

	make
			-- Construit la fenêtre pour l'application.
		local
			l_construction_fenetre: GAME_WINDOW_RENDERED_BUILDER
		do
			create l_construction_fenetre
			l_construction_fenetre.set_dimension (1000, 600)
			l_construction_fenetre.set_title ("SpaceRace")
			fenetre := l_construction_fenetre.generate_window
		end

feature {ANY} -- Implementation

	fenetre: GAME_WINDOW_RENDERED
			-- La fenêtre de l'application

end
