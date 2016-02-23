note
	description: "Classe pour gérer la fenetre {FENETRE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FENETRE

inherit
	GAME_LIBRARY_SHARED

create
	make_fenetre

feature {NONE} -- Initialization

	make_fenetre
			-- Initialization for `Current'.
		local
			l_construction_fenetre:GAME_WINDOW_SURFACED_BUILDER
		do
			create l_construction_fenetre
			l_construction_fenetre.set_dimension(1000,600)
			l_construction_fenetre.set_title("SpaceRace")
			fenetre:= l_construction_fenetre.generate_window
			if fenetre.has_error then
				game_library.stop
			end
		end


feature {ANY}

	fenetre:GAME_WINDOW_SURFACED

end
