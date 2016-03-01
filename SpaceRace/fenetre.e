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
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		local
			l_construction_fenetre: GAME_WINDOW_RENDERED_BUILDER
			l_fond: FOND_ECRAN
			l_icone_image: GAME_IMAGE_BMP_FILE
			l_icone: GAME_SURFACE
			l_musique: MUSIQUE
		do
			create l_construction_fenetre
			create l_icone_image.make ("iconeVaisseau.bmp")
			l_construction_fenetre.set_dimension (1000, 600)
			l_construction_fenetre.set_title ("SpaceRace")
			fenetre := l_construction_fenetre.generate_window
			create l_musique.creer_son (fenetre.renderer)
			fenetre.renderer.set_drawing_color (create {GAME_COLOR}.make_rgb (0, 0, 0))
			if l_icone_image.is_openable then
				l_icone_image.open
				if l_icone_image.is_open then
					create l_icone.share_from_image (l_icone_image)
					l_icone.set_transparent_color (create {GAME_COLOR}.make_rgb (255, 0, 255))
					fenetre.set_icon (l_icone)
				end
			end
			fenetre.renderer.clear
			create l_fond.make_image (fenetre.renderer)
			if not l_fond.has_error then
				game_library.iteration_actions.extend (agent repeter_fenetre(?, l_fond, fenetre.renderer))
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

				-- Met à jour les modifications dans l'écran.
			l_renderer.present
		end

feature {ANY}

	fenetre: GAME_WINDOW_RENDERED

end
