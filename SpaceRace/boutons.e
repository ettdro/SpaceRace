note
	description: "Classe qui crée les boutons à afficher dans les menus et le logo SpaceRace."
	author: "Nicolas Bisson et Étienne Drolet"
	date: "2016-03-01"
	revision: "1.0"

class
	BOUTONS

inherit

	IMAGES

create
	creer_affichable
	--	creer_bouton_quitter, creer_bouton_options, creer_bouton_jouer, creer_logo

feature {NONE} -- Initialization

	creer_affichable (a_renderer: GAME_RENDERER; a_nom_fichier: STRING)
			-- Méthode pour créer un fichier affichable
		do
			creer_image (a_renderer, a_nom_fichier)
		end
end
