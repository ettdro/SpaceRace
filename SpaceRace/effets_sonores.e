note
	description: "Classe qui va regrouper tous les effets sonores."
	author: "Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

class
	EFFETS_SONORES

inherit

	SON

create
	creer

feature {NONE} -- Initialisation

	creer
			-- Créer le son du click
		do
			creer_son ("click_sound.wav")
		end

end
