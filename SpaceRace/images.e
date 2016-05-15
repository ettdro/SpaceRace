note
	description: "Contient les m�thodes g�n�rales li�es � la cr�ation et � l'affichage d'images."
	author: "Nicolas Bisson et �tienne Drolet"
	date: "2016-04-03"
	revision: "1.1"

deferred class
	IMAGES

inherit
	GAME_TEXTURE

feature {ANY} -- Initialization

	creer_image (a_renderer: GAME_RENDERER; a_nom_fichier: STRING)
			-- M�thode qui cr�e une image dans la fen�tre (a_renderer) si le fichier (a_nom_fichier) est ouvrable.
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

end
