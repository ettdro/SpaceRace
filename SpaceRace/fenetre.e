note
	description: "Classe pour générer la fenêtre de l'application et pour la rafraichir."
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
			-- Construit la fenêtre pour l'application.
		local
			l_construction_fenetre: GAME_WINDOW_RENDERED_BUILDER
		do
			create l_construction_fenetre
			l_construction_fenetre.set_dimension (1000, 600)
			l_construction_fenetre.set_title ("SpaceRace")
			fenetre := l_construction_fenetre.generate_window
			create fond.make_image (fenetre.renderer)
			if not fond.has_error then
				repeter_fenetre
			else
				print ("Ne peut ouvrir une ou plusieurs images.")
			end
		end

feature -- Access

	repeter_fenetre
			-- Affiche le fond d'écran et rafraichie la fenêtre.
		do
			fond.afficher (0, 0, fenetre.renderer)
			fenetre.renderer.present
		end

feature {ANY}

	fenetre: GAME_WINDOW_RENDERED

	fond: FOND_ECRAN

end
