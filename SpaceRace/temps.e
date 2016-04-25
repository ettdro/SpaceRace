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
			pause := False
			temps_milliseconde := temps_milliseconde + a_timestamp - temps_debut_milliseconde
			temps_debut_milliseconde := a_timestamp
		end

	depart_chrono (a_debut_millisecond: NATURAL)
			-- Démarre le chronomètre.
		do
			temps_debut_milliseconde := a_debut_millisecond
		end

feature {ANY}

	pause: BOOLEAN -- Détermine si le jeu est en pause.

	temps_debut_milliseconde: NATURAL -- Le temps depuis la création du chronomètre.

	temps_milliseconde: NATURAL -- Le temps en millisecondes.

end
