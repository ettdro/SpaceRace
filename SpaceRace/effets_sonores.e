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
		local
			l_son_click: AUDIO_SOUND_FILE
		do
			creer_son ("click_sound.wav")
		end

feature -- Access

	jouer
			-- Vérifie si le son n'est pas NULL et fait jouer le son.
		do
			if attached son_click as la_son then
				source.stop
				la_son.restart
				source.queue_sound (la_son)
				source.play
			end
		end

end
