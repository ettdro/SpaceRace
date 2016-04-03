note
	description: "Classe pour lancer la création du fond d'écran."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-04-03"
	revision: "1.1"

class
	FOND_ECRAN

inherit

	IMAGES

create
	make_image

feature {NONE} -- Initialization

	make_image (a_renderer: GAME_RENDERER; a_nom_fichier: STRING)
			-- Crée l'image de fond de l'application.
		require
			Bon_Format_Image: a_nom_fichier.ends_with (".png")
		do
			creer_image (a_renderer, a_nom_fichier)
		end

end
