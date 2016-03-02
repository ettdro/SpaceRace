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

feature

	creer
			-- Crée le son du click
		local
			l_son_click: AUDIO_SOUND_FILE
		do
			creer_son ("click_sound.wav")
		end

feature

	jouer
		do
			if attached son_click as la_son then
				source.queue_sound (la_son)
				source.play
			end
		end

end
