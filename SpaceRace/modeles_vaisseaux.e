
	-- CLASSE NON TERMINÉE, ELLE N'A PAS D'IMPACT SUR LE PROGRAMME ET N'EST PAS UTILE POUR LA REMISE 1.

note
	description: "Crée les images des vaisseaux."
	author: "Nicolas Bisson et Étienne Drolet"
	date: "2016-03-01"
	revision: "1.0"

class
	MODELES_VAISSEAUX

inherit

	MENU
		redefine
			execution
		end

create
	make

feature {NONE} -- Initialization

	make (a_fenetre: FENETRE; a_musique: MUSIQUE; a_son_click: EFFETS_SONORES)
			-- Construit le menu pour choisir le vaisseaux.
		do
			fenetre := a_fenetre
			musique := a_musique
			son_click := a_son_click
			create musique.creer
		end

feature -- Access

	execution
		do
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris dans les menus.
		do
		end

		--		local
		--			l_image: IMG_IMAGE_FILE
		--		do
		--			contient_erreur := False
		--			create l_image.make_modele_vaisseau ("vaisseauTest.jpg")
		--			if l_image.is_openable then
		--				l_image.open
		--				if l_image.is_open then
		--					make_from_image (a_renderer, l_image)
		--					if not has_error then
		--						sub_image_largeur := largeur // 3
		--						sub_image_longueur := hauteur
		--					end
		--				else
		--					has_error := False
		--				end
		--			else
		--				has_error := False
		--			end
		--			initialisation_animation
		--		end

		--	initialisation_animation
		--			-- Crée les animations du vaisseau
		--		do
		--			create {ARRAYED_LIST [TUPLE [x, y: INTEGER]]} coordination_animation.make (4)
		--			coordination_animation.extend ([largeur // 3, 0]) -- S'assurer de positionner l'image dans la fenêtre.
		--			coordination_animation.extend ([0, 0])
		--			coordination_animation.extend ([(largeur // 3) * 2, 0])
		--			coordination_animation.extend ([0, 0])
		--			sub_image_x := coordination_animation.premier.x -- Positionne l'image en X.
		--			sub_image_y := coordination_animation.premier.y -- Positionne l'image en Y.
		--		end

		--feature

		--	sub_image_largeur: INTEGER

		--	sub_image_longueur: INTEGER
		--			-- Dimensions de l'image

		--	sub_image_x: INTEGER

		--	sub_image_y: INTEGER
		--			-- Position de l'image

		--feature {NONE}

		--	coordination_animation: LIST [TUPLE [x, y: INTEGER]]
		--			-- Les coordinations de l'image

end
