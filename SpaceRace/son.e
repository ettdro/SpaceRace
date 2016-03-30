note
	description: "Contient les méthodes générales liées aux sons, autant pour la musique que les effets sonores."
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
		require
			Bon_Format_Audio: a_nom_fichier.ends_with (".wav")
		local
			l_son: AUDIO_SOUND_FILE
		do
			audio_library.sources_add
			source := audio_library.last_source_added
			create l_son.make (a_nom_fichier)
			if l_son.is_openable then
				l_son.open
				if l_son.is_open then
					son_click := l_son
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
					source.set_gain (1)
					source.play
				end
			else
				if attached son_click as la_son then
					source.stop
					la_son.restart
					source.queue_sound (la_son)
					source.set_gain (1)
					source.play
				end
			end
		end

	mute
			-- Coupe le musique du jeu.
		do
			source.set_gain (0)
		end

	unmute
			-- Rouvre le son du jeu.
		do
			source.set_gain (1)
		end

	desactiver_son_click
			-- Désactive le son lorsqu'on click sur un bouton.
		do
			source.stop
		end

	est_muet: BOOLEAN
			-- Vérifie si c'est muet pour l'affichage du bon bouton dans le menu des options.
		do
			Result := source.gain = 0
		end

feature -- Implementation

	source: AUDIO_SOURCE

	son_click: detachable AUDIO_SOUND

end
