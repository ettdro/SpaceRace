note
	description: "Classe abstraite {TEMPS} qui contient des méthodes utilisées dans {TEMPS} et dans les tests."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-04-25"
	revision: "1.0"

deferred class
	TEMPS

feature {ANY}

	chronometre (a_timestamp: NATURAL)
			-- Incrémente le temps du chronomètre.
		do
			if not pause then
				pause := False
				temps_milliseconde := temps_milliseconde + a_timestamp - temps_debut_milliseconde
				temps_debut_milliseconde := a_timestamp
			end
		ensure
			Temps_Debut_Milliseconde_Assigne: temps_debut_milliseconde = a_timestamp
			Temps_Milliseconde_Assigne: temps_milliseconde = temps_milliseconde + a_timestamp - temps_debut_milliseconde
		end

	depart_chrono (a_debut_milliseconde: NATURAL)
			-- Démarre le chronomètre.
		do
			temps_debut_milliseconde := a_debut_milliseconde
		end

	unpause(a_timestamp:NATURAL)
			-- Remets le chronomètre en marche. (Lors de plusieurs click consécutifs sur JOUER, le temps devient bizarre.)
		do
			temps_milliseconde := temps_milliseconde - (a_timestamp - temps_pause)
			pause := False
		end

feature {ANY}

	pause: BOOLEAN -- Détermine si le jeu est en pause.

	temps_pause: NATURAL -- Le temps de la pause.

	temps_debut_milliseconde: NATURAL -- Le temps depuis la création du chronomètre.

	temps_milliseconde: NATURAL -- Le temps en millisecondes.

end
