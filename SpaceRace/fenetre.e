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
			l_musique: MUSIQUE
		do
			create l_construction_fenetre
			l_construction_fenetre.set_dimension (1000, 600)
			l_construction_fenetre.set_title ("SpaceRace")
			fenetre := l_construction_fenetre.generate_window
			create l_musique.creer_son (fenetre.renderer)
			fenetre.renderer.clear
			create fond.make_image (fenetre.renderer)
			create bouton_quitter.creer_bouton_quitter (fenetre.renderer)
			create bouton_options.creer_bouton_options (fenetre.renderer)
			create bouton_jouer.creer_bouton_jouer (fenetre.renderer)
			create logo.creer_logo (fenetre.renderer)
			if not fond.has_error and not bouton_quitter.has_error and not bouton_options.has_error and not bouton_jouer.has_error and not logo.has_error then
				game_library.iteration_actions.extend (agent repeter_fenetre(?, fenetre.renderer))
			else
				print ("Ne peut ouvrir une ou des images.")
			end
		end

feature {NONE} -- Implementation

	repeter_fenetre (a_timestamp: NATURAL_32; l_renderer: GAME_RENDERER)
		do
			l_renderer.draw_texture (fond, 0, 0)
			l_renderer.draw_texture (bouton_quitter, 400, 450)
			l_renderer.draw_texture (bouton_options, 400, 350)
			l_renderer.draw_texture (bouton_jouer, 400, 250)
			l_renderer.draw_texture (logo, 275, 75)
			l_renderer.present
		end

feature {ANY}

	fenetre: GAME_WINDOW_RENDERED

	fond: FOND_ECRAN

	bouton_quitter: BOUTONS

	bouton_options: BOUTONS

	bouton_jouer: BOUTONS

	logo: BOUTONS -- Dans la classe "BOUTONS" même s'il n'en est pas un.

end
