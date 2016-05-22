note
	description: "Contient les méthodes générales liées aux sons, autant pour la musique que pour les effets sonores."
	author: "Nicolas Bisson & Étienne Drolet"
	date: "2016-05-15"
	revision: "1.4"

deferred class
	SON

inherit

	GAME_LIBRARY_SHARED

	AUDIO_LIBRARY_SHARED

feature {ANY} -- Initialization

	creer_audio (a_nom_fichier: STRING)
			-- Méthode qui crée le son (a_nom_fichier).
		require
			Bon_Format_Audio: a_nom_fichier.ends_with (".wav")
			Bonne_Taille_Audio: a_nom_fichier.count > 4
		local
			l_son: AUDIO_SOUND_FILE
		do
			audio_library.sources_add
			source := audio_library.last_source_added
			create l_son.make (a_nom_fichier)
			if l_son.is_openable then
				l_son.open
				if l_son.is_open then
					son := l_son
				else
					print ("L'audio ne peut s'ouvrir.")
				end
			else
				print ("L'audio n'est pas un fichier ouvrable.")
			end
		end

feature {ANY} -- Access

	jouer (a_boucle_infini: BOOLEAN)
			-- Vérifie si le son n'est pas NULL et fait jouer le son (à l'infini si a_boucle_infini = TRUE).
		do
			if a_boucle_infini = True then
				if attached son as la_son then
					source.queue_sound_infinite_loop (la_son)
					source.set_gain (1)
					source.play
				end
			else
				if attached son as la_son then
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
		ensure
			source.gain = 0
		end

	unmute
			-- Rouvre le son du jeu.
		do
			source.set_gain (1)
		ensure
			source.gain = 1
		end

feature {ANY} -- Implementation

	source: AUDIO_SOURCE
			-- La source de l'audio.

	son: detachable AUDIO_SOUND
			-- Le son créé.

feature {ANY} -- Constantes

	est_muet: BOOLEAN
			-- Sert à vérifier si c'est muet pour l'affichage du bon bouton dans le menu des options et dans le jeu principal.
		do
			Result := source.gain = 0
		end

end
