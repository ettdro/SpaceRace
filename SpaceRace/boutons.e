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
	creer_bouton_quitter, creer_bouton_options, creer_bouton_jouer, creer_logo

feature {NONE} -- Initialization

	creer_bouton_quitter (a_renderer: GAME_RENDERER)
			-- Méthode pour créer le bouton 'Quitter'.
		local
			l_bouton_quitter_image: IMG_IMAGE_FILE
		do
			create l_bouton_quitter_image.make ("bouton_quitter.png")
			if l_bouton_quitter_image.is_openable then
				l_bouton_quitter_image.open
				if l_bouton_quitter_image.is_open then
					make_from_image (a_renderer, l_bouton_quitter_image)
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
			-- Méthode pour créer le bouton 'Options'.
		local
			l_bouton_options_image: IMG_IMAGE_FILE
		do
			create l_bouton_options_image.make ("bouton_options.png")
			if l_bouton_options_image.is_openable then
				l_bouton_options_image.open
				if l_bouton_options_image.is_open then
					make_from_image (a_renderer, l_bouton_options_image)
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
			-- Méthode pour créer le bouton 'Jouer'.
		local
			l_bouton_jouer_image: IMG_IMAGE_FILE
		do
			create l_bouton_jouer_image.make ("bouton_jouer.png")
			if l_bouton_jouer_image.is_openable then
				l_bouton_jouer_image.open
				if l_bouton_jouer_image.is_open then
					make_from_image (a_renderer, l_bouton_jouer_image)
				else
					has_error := True
					print ("Le fichier ne peut se faire.")
				end
			else
				has_error := True
				print ("Le fichier n'est pas bon, pensez à regarder le type du fichier.")
			end
		end

	creer_logo (a_renderer: GAME_RENDERER)
			-- Méthode pour créer le logo. (N'EST PAS UN BOUTON, NE JOUE PAS LE RÔLE D'UN BOUTON)
		local
			l_logo_image: IMG_IMAGE_FILE
		do
			create l_logo_image.make ("logo.png")
			if l_logo_image.is_openable then
				l_logo_image.open
				if l_logo_image.is_open then
					make_from_image (a_renderer, l_logo_image)
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
