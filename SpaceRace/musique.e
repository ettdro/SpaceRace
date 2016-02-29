note
	description: "Joue la musique du jeu en boucle infini."
	author: "Nicolas Bisson & Étienne Drolet"
	date: "2016-03-01"
	revision: "1.0"

class
	MUSIQUE

inherit

	GAME_LIBRARY_SHARED

	AUDIO_LIBRARY_SHARED

	SON

create
	creer_son

feature

	creer_son (a_fenetre: GAME_RENDERER)
			-- Crée la musique principale du jeu.
		local
			l_son_musique: AUDIO_SOUND_FILE
		do
			audio_library.sources_add
			source := audio_library.last_source_added
			create l_son_musique.make ("MusiqueMenu.wav")
			if l_son_musique.is_openable then
				l_son_musique.open
				if l_son_musique.is_open then
					source.queue_sound (l_son_musique)
					game_library.iteration_actions.extend (agent repeter_son(?, a_fenetre))
					source.play
				end
			end
		end

	repeter_son (a_temps: NATURAL; a_fenetre: GAME_RENDERER)
			-- Méthode qui fait en sorte que la musique se répète à l'infini.
		do
			audio_library.update
		end

feature {NONE} -- Implementation

	source: AUDIO_SOURCE

end
