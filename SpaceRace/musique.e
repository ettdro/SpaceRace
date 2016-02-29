note
	description: "Joue la musique du jeu en boucle infini."
	author: "Nicolas Bisson & Étienne Drolet"
	date: "2016-03-01"
	revision: "1.0"

class
	MUSIQUE

inherit

	AUDIO_SOUND_FILE

	AUDIO_SOURCE

	SON

create
	creer_son

feature

	creer_son (a_fenetre: GAME_RENDERER)
			-- Crée la musique principale du jeu.
		local
			l_son_musique: AUDIO_SOUND_FILE
			l_source: AUDIO_SOURCE
		do
			create l_son_musique.make ("MusiqueMenu.wav")
			if l_son_musique.is_openable then
				l_son_musique.open
				if l_son_musique.is_open then
					audio_library.sources_add
					l_source := audio_library.last_source_added
					l_source.queue_sound (l_son_musique)
					game_library.iteration_actions.extend (agent repeter_son(?, a_fenetre))
					l_source.play
				end
			end
		end

	repeter_son (a_temps: NATURAL; a_fenetre: GAME_RENDERER)
			-- Méthode qui fait en sorte que la musique se répète à l'infini.
		do
			audio_library.update
		end

end
