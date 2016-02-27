note
	description: "Crée les images des vaisseaux."
	author: "Nicolas Bisson et Étienne Drolet"
	date: "2016-03-01"
	revision: "1.0"

class
	MODELS_VAISSEAUX

inherit

	GAME_TEXTURE

create
	make_modele_vaisseau

feature {NONE} -- Initialization

	make_modele_vaisseau (a_renderer: GAME_RENDERER)
			-- Initialization for `Current'.
		local
			l_image: IMG_IMAGE_FILE
		do
			contient_erreur := False
			create l_image.make_modele_vaisseau ("vaisseauTest.jpg")
			if l_image.is_openable then
				l_image.open
				if l_image.is_open then
					make_from_image (a_renderer, l_image)
					if not contient_erreur then
						sub_image_largeur := largeur // 3
						sub_image_longueur := hauteur
					end
				else
					contient_erreur := False
				end
			else
				contient_erreur := False
			end
			initialisation_animation
		end

	initialisation_animation
			-- Crée les animations du vaisseau
		do
			create {ARRAYED_LIST [TUPLE [x, y: INTEGER]]} coordination_animation.make (4)
			coordination_animation.extend ([largeur // 3, 0]) -- S'assurer de positionner l'image dans la fenêtre.
			coordination_animation.extend ([0, 0])
			coordination_animation.extend ([(largeur // 3) * 2, 0])
			coordination_animation.extend ([0, 0])
			sub_image_x := coordination_animation.premier.x -- Positionne l'image en X.
			sub_image_y := coordination_animation.premier.y -- Positionne l'image en Y.
		end

feature

	sub_image_largeur: INTEGER

	sub_image_longueur: INTEGER
			-- Dimensions de l'image

	sub_image_x: INTEGER

	sub_image_y: INTEGER
			-- Position de l'image

feature {NONE}

	coordination_animation: LIST [TUPLE [x, y: INTEGER]]
			-- Les coordinations de l'image

end
