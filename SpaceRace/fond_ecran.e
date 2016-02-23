note
	description: "Classe pour gérer le fond d'ecran {FOND_ECRAN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FOND_ECRAN

inherit
	GAME_TEXTURE

create
	make_fond_ecran

feature {NONE} -- Initialization

	make_fond_ecran(a_renderer:GAME_RENDERER)
		local
			l_fond:IMG_IMAGE_FILE
		do
			create l_fond.make ("space.jpg")
			if l_fond.is_openable then
				l_fond.open
				if l_fond.is_open then
					make_from_image (a_renderer, l_fond)
				else
					has_error := True
					print("Le fichier ne peut se faire.")
				end
			else
				has_error := True
				print("Le fichier n'est pas bon, pensez à regarder le type du fichier.")
			end
		end
end
