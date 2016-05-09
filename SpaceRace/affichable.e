note
	description: "Classe qui lance la cr�ation de toutes les images du jeux."
	author: "Nicolas Bisson et �tienne Drolet"
	date: "2016-04-03"
	revision: "1.1"

class
	AFFICHABLE

inherit

	IMAGES

create
	creer_affichable

feature {NONE} -- Initialization

	creer_affichable (a_renderer: GAME_RENDERER; a_nom_fichier: STRING)
			-- M�thode qui lance la cr�ation d'un fichier affichable (a_nom_fichier).
		require
			Bon_Format_Image: a_nom_fichier.ends_with (".png")
			Bonne_Taille_String: a_nom_fichier.count > 4
		do
			creer_image (a_renderer, a_nom_fichier)
		end

end
