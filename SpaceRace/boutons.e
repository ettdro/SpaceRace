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
		local
			l_bouton_quitter: IMG_IMAGE_FILE
		do
			create l_bouton_quitter.make ("bouton_quitter.png")
			if l_bouton_quitter.is_openable then
				l_bouton_quitter.open
				if l_bouton_quitter.is_open then
					make_from_image (a_renderer, l_bouton_quitter)
				else
					has_error := True
					print ("Le fichier ne peut se faire.")
				end
			else
				has_error := True
				print ("Le fichier n'est pas bon, pensez à regarder le type du fichier.")
			end
		end

	creer_bouton_options (a_renderer: GAME_RENDERER)
		local
			l_bouton_options: IMG_IMAGE_FILE
		do
			create l_bouton_options.make ("bouton_options.png")
			if l_bouton_options.is_openable then
				l_bouton_options.open
				if l_bouton_options.is_open then
					make_from_image (a_renderer, l_bouton_options)
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
		local
			l_bouton_jouer: IMG_IMAGE_FILE
		do
			create l_bouton_jouer.make ("bouton_jouer.png")
			if l_bouton_jouer.is_openable then
				l_bouton_jouer.open
				if l_bouton_jouer.is_open then
					make_from_image (a_renderer, l_bouton_jouer)
				else
					has_error := True
					print ("Le fichier ne peut se faire.")
				end
			else
				has_error := True
				print ("Le fichier n'est pas bon, pensez à regarder le type du fichier.")
			end
		end

		--	position_x (INTEGER)
		--	assign

		--	position_y (INTEGER)
		--	assign

end
