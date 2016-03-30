note
	description: "Classe qui cr�e les boutons � afficher dans les menus et le logo SpaceRace."
	author: "Nicolas Bisson et �tienne Drolet"
	date: "2016-03-01"
	revision: "1.0"

class
	AFFICHABLE

inherit

	IMAGES

create
	creer_affichable

feature {NONE} -- Initialization

	creer_affichable (a_renderer: GAME_RENDERER; a_nom_fichier: STRING)
			-- M�thode pour cr�er un fichier affichable (une image quelconque, ex.: les boutons, le logo, etc.)
		require
			Bon_Format_Image: a_nom_fichier.ends_with (".png")
		do
			creer_image (a_renderer, a_nom_fichier)
		end

end
