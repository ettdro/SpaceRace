note
	description: "Classe qui crée les boutons à afficher dans les menus."
	author: "Nicolas Bisson et Étienne Drolet"
	date: "2016-03-01"
	revision: "1.0"

class
	BOUTONS

inherit

	GAME_TEXTURE

create
	make_bouton

feature {NONE} -- Initialization

	make_bouton (a_renderer: GAME_RENDERER)
			-- Initialization de `Current'.
		do
			creer_bouton_quitter (a_renderer)
			creer_bouton_options (a_renderer)
			creer_bouton_jouer (a_renderer)
		end

	creer_bouton_quitter (a_renderer: GAME_RENDERER)
			-- Méthode pour créer et placer le bouton 'Quitter'
		local
			l_bouton_quitter: GAME_TEXTURE
			l_bouton_quitter_image: IMG_IMAGE_FILE
		do
			create l_bouton_quitter_image.make ("bouton_quitter.png")
			if l_bouton_quitter_image.is_openable then
				l_bouton_quitter_image.open
				if l_bouton_quitter_image.is_open then
					create l_bouton_quitter.make_from_image (a_renderer, l_bouton_quitter_image)
					a_renderer.draw_texture (l_bouton_quitter, 42, 420)
				else
					has_error := True
					print ("Le fichier ne peut se faire")
				end
			else
				has_error := True
				print ("Le fichier n'est pas bon, pensez à regarder le type du fichier.")
			end
		end

	creer_bouton_options (a_renderer: GAME_RENDERER)
			-- Méthode pour créer et placer le bouton 'Options'
		local
			l_bouton_options: GAME_TEXTURE
			l_bouton_options_image: IMG_IMAGE_FILE
		do
			create l_bouton_options_image.make ("bouton_options.png")
			if l_bouton_options_image.is_openable then
				l_bouton_options_image.open
				if l_bouton_options_image.is_open then
					create l_bouton_options.make_from_image (a_renderer, l_bouton_options_image)
					a_renderer.draw_texture (l_bouton_options, 42, 69)
				else
					has_error := True
					print ("Le fichier ne peut se faire.")
				end
			else
				has_error := True
				print ("Le fichier n'est pas bon, pensez à regarder le type du fichier.")
			end
		end

	creer_bouton_jouer (a_renderer: GAME_RENDERER)
			-- Méthode pour créer et placer le bouton 'Jouer'
		local
			l_bouton_jouer: GAME_TEXTURE
			l_bouton_jouer_image: IMG_IMAGE_FILE
		do
			create l_bouton_jouer_image.make ("bouton_jouer.png")
			if l_bouton_jouer_image.is_openable then
				l_bouton_jouer_image.open
				if l_bouton_jouer_image.is_open then
					create l_bouton_jouer.make_from_image (a_renderer, l_bouton_jouer_image)
					a_renderer.draw_texture (l_bouton_jouer, 42, 42)
				else
					has_error := True
					print ("Le fichier ne peut se faire.")
				end
			else
				has_error := True
				print ("Le fichier n'est pas bon, pensez à regarder le type du fichier.")
			end
		end

end
