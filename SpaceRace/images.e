note
	description: "Contient les méthodes générales liées à la création et à l'affichage d'images."
	author: "Nicolas Bisson et Étienne Drolet"
	date: "2016-04-03"
	revision: "1.1"

deferred class
	IMAGES

inherit
	GAME_TEXTURE

feature {ANY} -- Initialization

	creer_image (a_renderer: GAME_RENDERER; a_nom_fichier: STRING)
			-- Méthode qui crée une image dans la fenêtre (a_renderer) si le fichier (a_nom_fichier) est ouvrable.
		require
			Bon_Format_Image: a_nom_fichier.ends_with (".png")
			Bonne_Taille_String: a_nom_fichier.count > 4
		local
			l_image: IMG_IMAGE_FILE
		do
			create l_image.make (a_nom_fichier)
			if l_image.is_openable then
				l_image.open
				if l_image.is_open then
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

feature {ANY} -- Access

	afficher (a_pos_x, a_pos_y: INTEGER; a_renderer: GAME_RENDERER)
			-- Affiche l'image aux coordonnées a_pos_x et a_pos_y dans la fenêtre (a_renderer).
		do
			a_renderer.draw_texture (Current, a_pos_x, a_pos_y)
		end

	afficher_rotation (a_angle_rotation: REAL_64; a_pos_x, a_pos_y: INTEGER; a_renderer: GAME_RENDERER)
			-- Affiche l'image aux coordonnées a_pos_x et a_pos_y dans la fenêtre (a_renderer) selon l'angle de rotation (a_angle_rotation).
		do
			a_renderer.draw_sub_texture_with_scale_rotation_and_mirror (Current, 0, 0, width, height, a_pos_x, a_pos_y, width, height, width // 2, height // 2, a_angle_rotation, False, False)
		end

end
