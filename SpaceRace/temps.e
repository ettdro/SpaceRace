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
			pause := False
			temps_milliseconde := temps_milliseconde + a_timestamp - temps_debut_milliseconde
			temps_debut_milliseconde := a_timestamp
		end

	depart_chrono (a_debut_millisecond: NATURAL)
			-- D�marre le chronom�tre.
		do
			temps_debut_milliseconde := a_debut_millisecond
		end

feature {ANY}

	pause: BOOLEAN -- D�termine si le jeu est en pause.

	temps_debut_milliseconde: NATURAL -- Le temps depuis la cr�ation du chronom�tre.

	temps_milliseconde: NATURAL -- Le temps en millisecondes.

end
