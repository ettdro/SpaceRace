note
	description: "Classe qui cr�e les boutons � afficher dans les menus et le logo SpaceRace."
	author: "Nicolas Bisson et �tienne Drolet"
	date: "2016-03-01"
	revision: "1.0"

class
	BOUTONS

inherit

	IMAGES

create
	creer_bouton_quitter,
	creer_bouton_options,
	creer_bouton_jouer,
	creer_logo

feature {NONE} -- Initialization

	creer_bouton_quitter (a_renderer: GAME_RENDERER)
			-- M�thode pour cr�er le bouton 'Quitter'.
		do
			creer_image (a_renderer, "bouton_quitter2.png")
		end

	creer_bouton_options (a_renderer: GAME_RENDERER)
			-- M�thode pour cr�er le bouton 'Options'.
		do
			creer_image (a_renderer, "bouton_options2.png")
		end

	creer_bouton_jouer (a_renderer: GAME_RENDERER)
			-- M�thode pour cr�er le bouton 'Jouer'.
		do
			creer_image (a_renderer, "bouton_jouer2.png")
		end

	creer_logo (a_renderer: GAME_RENDERER)
			-- M�thode pour cr�er le logo. (N'EST PAS UN BOUTON, NE JOUE PAS LE R�LE D'UN BOUTON, MAIS EST L� POUR L'INSTANT)
		do
			creer_image (a_renderer, "logo2.png")
		end

end
