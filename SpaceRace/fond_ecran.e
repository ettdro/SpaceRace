note
	description: "Classe pour lancer la cr�ation du fond d'�cran."
	author: "�tienne Drolet et Nicolas Bisson"
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
			-- Cr�e l'image de fond de la fen�tre.
		do
			creer_image (a_renderer, "background_space.png")
		end

end
