note
	description: "Classe qui gère le menu des crédits."
	author: "Nicolas Bisson et Étienne Drolet"
	date: "2016-05-09"
	revision: "1.3"

class
	MENU_CREDITS

inherit

	MENU_SOUS_OPTIONS
		redefine
			make
		end

create
	make

feature -- Initialization

	make (a_fenetre: FENETRE; a_musique: EFFET_SONORE; a_son_click: EFFET_SONORE)
			-- Construit le menu des crédits (a_fenetre), ses sons (a_musique et a_son_click) et ses images.
		do
			Precursor (a_fenetre, a_musique, a_son_click)
			create texte.creer_affichable (fenetre.fenetre.renderer, "./images/texte_credits.png")
		end

end
