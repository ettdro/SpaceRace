note
	description: "Classe pour gérer le fond d'ecran {FOND_ECRAN}."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

class
	FOND_ECRAN

inherit

	GAME_TEXTURE

create
	make_image

feature {NONE} -- Initialization

	make_image (a_renderer: GAME_RENDERER)
			-- Initialization de `Current'.
		local
			l_fond_image: IMG_IMAGE_FILE
		do
			create l_fond_image.make ("space.jpg")
			if l_fond_image.is_openable then
				l_fond_image.open
				if l_fond_image.is_open then
					make_from_image (a_renderer, l_fond_image)
				else
					has_error := True
					print ("Le fichier ne peut se faire.")
				end
			else
				has_error := True
				print ("Le fichier n'est pas bon, pensez à regarder le type du fichier.")
			end
		end

end
