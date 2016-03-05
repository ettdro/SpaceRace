note
	description: "Contient les méthodes générales liées à l'affichage d'images"
	author: "Nicolas Bisson et Étienne Drole"
	date: "2016-03-04"
	revision: "1.0"

deferred class
	IMAGES

inherit

	GAME_TEXTURE

feature -- Access

	creer_image (a_renderer: GAME_RENDERER; a_nom_fichier: STRING)
			-- Méthode qui crée une image.
		local
			l_image: IMG_IMAGE_FILE
		do
			create l_image.make (a_nom_fichier)
			if l_image.is_openable then
				l_image.open
				if l_image.is_open then
					image := l_image
					make_from_image (a_renderer, l_image)
				else
					has_error := True
					print ("L'image ne peut s'ouvrir.")
				end
			else
				has_error := True
				print ("L'image n'est pas un fichier ouvrable.")
			end
		end

	afficher (a_image: GAME_TEXTURE; a_pos_x, a_pos_y: INTEGER; l_renderer: GAME_RENDERER)
			-- Vérifie si l'image n'est pas NULL et affiche l'image.
		do
			if attached image as la_image then
				l_renderer.draw_texture (a_image, a_pos_x, a_pos_y)
			end
		end

feature {NONE} -- Implementation

	image: detachable IMG_IMAGE_FILE

end
