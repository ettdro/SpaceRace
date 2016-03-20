note
	description: "Classe pour lancer la création du fond d'écran."
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
			-- Crée l'image de fond de la fenêtre.
		do
			creer_image (a_renderer, "background_space.png")
		end

end
