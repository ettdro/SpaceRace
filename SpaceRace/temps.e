note
	description: "Classe abstraite {TEMPS} qui contient des m�thodes utilis�es dans {TEMPS} et dans les tests."
	author: "�tienne Drolet et Nicolas Bisson"
	date: "2016-04-25"
	revision: "1.0"

deferred class
	TEMPS

feature {ANY}

	chronometre (a_timestamp: NATURAL)
			-- Incr�mente le temps du chronom�tre.
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
			-- D�marre le chronom�tre.
		do
			temps_debut_milliseconde := a_debut_milliseconde
		end

	unpause(a_timestamp:NATURAL)
			-- Remets le chronom�tre en marche. (Lors de plusieurs click cons�cutifs sur JOUER, le temps devient bizarre.)
		do
			temps_milliseconde := temps_milliseconde - (a_timestamp - temps_pause)
			pause := False
		end

feature {ANY}

	pause: BOOLEAN -- D�termine si le jeu est en pause.

	temps_pause: NATURAL -- Le temps de la pause.

	temps_debut_milliseconde: NATURAL -- Le temps depuis la cr�ation du chronom�tre.

	temps_milliseconde: NATURAL -- Le temps en millisecondes.

end
