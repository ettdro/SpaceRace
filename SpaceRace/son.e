note
	description: "Contient les méthodes générales liées aux sons, autant pour la musique que les bruits de vaisseaux."
	author: "Nicolas Bisson & Étienne Drolet"
	date: "2016-03-01"
	revision: "1.0"

deferred class
	SON

inherit

	GAME_LIBRARY_SHARED

	AUDIO_LIBRARY_SHARED

feature -- Access

	creer_son (a_nom_fichier: STRING)
			-- Méthode qui crée le son.
		local
			l_son_click: AUDIO_SOUND_FILE
		do
			audio_library.sources_add
			source := audio_library.last_source_added
			create l_son_click.make (a_nom_fichier)
			if l_son_click.is_openable then
				l_son_click.open
				if l_son_click.is_open then
					son_click := l_son_click
					game_library.iteration_actions.extend (agent repeter_son)
				end
			end
		end

	repeter_son (a_temps: NATURAL)
			-- Fais jouer le son lorsque voulu.
		do
			audio_library.update
		end

	jouer (a_boucle_infini: BOOLEAN)
			-- Vérifie si le son n'est pas NULL et fait jouer le son.
		do
			if a_boucle_infini = True then
				if attached son_click as la_son then
					source.queue_sound_infinite_loop (la_son)
					source.play
				end
			else
				if attached son_click as la_son then
					source.stop
					la_son.restart
					source.queue_sound (la_son)
					source.play
				end
			end
		end

feature {NONE} -- Implementation

	source: AUDIO_SOURCE

	son_click: detachable AUDIO_SOUND

end
