note
	description: "Classe qui va cr�er tous les effets sonores."
	author: "Nicolas Bisson et �tienne Drolet"
	date: "2016-03-01"
	revision: "1.0"

class
	EFFETS_SONORES

inherit

	SON

create
	creer_son_click

feature {NONE} -- Initialization

	creer_son_click
			-- Cr�e le son du click
		do
			creer_son ("click_sound.wav")
		end

end
