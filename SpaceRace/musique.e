note
	description: "Joue la musique du jeu en boucle infini."
	author: "Nicolas Bisson & Étienne Drolet"
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
			-- Crée la musique principale du jeu.
		local
			l_son_musique: AUDIO_SOUND_FILE
		do
			creer_son ("MusiqueMenu.wav")
		end

feature -- Access

	jouer
		do
			if attached son_click as la_son then
				source.queue_sound_infinite_loop (la_son)
				source.play
			end
		end

end
