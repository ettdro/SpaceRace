note
	description: "Classe pour gérer le fond d'ecran {FOND_ECRAN}."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

class
	FOND_ECRAN

inherit

	IMAGES

create
	make_image

feature {NONE} -- Initialization

	make_image (a_renderer: GAME_RENDERER)
			-- Construit l'image de fond.
		do
			creer_image (a_renderer, "space.jpg")
		end

end
