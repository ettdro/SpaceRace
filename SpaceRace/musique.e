note
	description: "Joue la musique du jeu en boucle infini."
	author: "Nicolas Bisson & �tienne Drolet"
	date: "2016-03-01"
	revision: "1.0"

class
	MUSIQUE

inherit

	SON

create
	creer

feature {NONE} -- Initialisation

	creer
			-- Cr�e la musique principale du jeu.
		do
			creer_son ("MusiqueMenu.wav")
		end

feature -- Access

	suivante
		do
		end

end
