note
	description: "Classe pour gérer le fond d'ecran {FOND_ECRAN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FOND_ECRAN

inherit
	GAME_SURFACE

create
	make_fond_ecran

feature {NONE} -- Initialization

	make_fond_ecran
		local
			l_fond:IMG_IMAGE_FILE
		do
			create l_fond.make("space_fond.gif")
			if l_fond.is_openable then
				l_fond.open
				if l_fond.is_open then
					make_from_image(l_fond)
				else
					has_error:= True
					make(1,1)
				end
			else
				has_error := True
				make(1,1)
			end
		end

end
