note
	description: "Classe qui va créer tous les effets sonores."
	author: "Nicolas Bisson et Étienne Drolet"
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
			-- Crée le son du click
		do
			creer_son ("click_sound.wav")
		end

end
