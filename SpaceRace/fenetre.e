note
	description: "Classe pour gérer la fenetre {FENETRE}."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

class
	FENETRE

inherit

	GAME_LIBRARY_SHARED

	IMG_LIBRARY_SHARED

create
	make_fenetre

feature {NONE} -- Initialization

	make_fenetre
			-- Initialization for `Current'.
		local
			l_construction_fenetre: GAME_WINDOW_RENDERED_BUILDER
			l_fenetre: GAME_WINDOW_RENDERED
			l_fond: FOND_ECRAN
			l_icone_image: GAME_IMAGE_BMP_FILE
			l_icone: GAME_TEXTURE
		do
			create l_construction_fenetre
			create l_icone_image.make ("iconeVaisseau.bmp")
			l_construction_fenetre.set_dimension (1000, 600)
			l_construction_fenetre.set_title ("SpaceRace")
			l_fenetre := l_construction_fenetre.generate_window
			l_fenetre.renderer.set_drawing_color (create {GAME_COLOR}.make_rgb (0, 0, 0))
			if l_icone_image.is_openable then
				l_icone_image.open
				if l_icone_image.is_open then
					create l_icone.make_from_image (l_fenetre.renderer, l_icone_image)
				end
			end
			l_fenetre.renderer.clear
			create l_fond.make_fond_ecran (l_fenetre.renderer)
			if not l_fond.has_error then
				game_library.iteration_actions.extend (agent repeter_fenetre(?, l_fond, l_fenetre.renderer))
			else
				print ("Ne peut ouvrir le fond d'ecran")
			end
		end

feature {NONE} -- Implementation

	repeter_fenetre (a_timestamp: NATURAL_32; a_fond: GAME_TEXTURE; l_renderer: GAME_RENDERER)
		do
			l_renderer.set_drawing_color (create {GAME_COLOR}.make_rgb (0, 128, 255))
			l_renderer.draw_filled_rectangle (0, 0, a_fond.width, a_fond.height)
			l_renderer.draw_texture (a_fond, 0, 0)

				-- Update modification in the screen
			l_renderer.present
		end

feature {ANY}

		--	fenetre:GAME_WINDOW_SURFACED

end
