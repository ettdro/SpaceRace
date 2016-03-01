note
	description: "Classe pour g�rer la fenetre {FENETRE}."
	author: "�tienne Drolet et Nicolas Bisson"
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
			create boutons.creer_bouton_quitter (fenetre.renderer)
			if not fond.has_error and not boutons.has_error then
				game_library.iteration_actions.extend (agent repeter_fenetre(?,fenetre.renderer))
			else
				print ("Ne peut ouvrir le fond d'ecran")
			end
--			if not l_boutons.has_error then
--				game_library.iteration_actions.extend (agent repeter_fenetre(?, l_boutons, fenetre.renderer))
--			else
--				print ("Ne peut ouvrir le bouton quitter.")
--			end
		end

feature {NONE} -- Implementation

	repeter_fenetre (a_timestamp: NATURAL_32; l_renderer: GAME_RENDERER)
		do
			l_renderer.draw_texture (fond, 0, 0)
			l_renderer.draw_texture (boutons, 400, 300)
			l_renderer.present
		end


feature {ANY}

	fenetre: GAME_WINDOW_RENDERED

	fond: FOND_ECRAN

	boutons: BOUTONS

end
