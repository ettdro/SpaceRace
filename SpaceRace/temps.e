note
	description: "Classe abstraite {TEMPS} qui contient des m�thodes utilis�es dans {TEMPS} et dans les tests."
	author: "�tienne Drolet et Nicolas Bisson"
	date: "2016-04-25"
	revision: "1.3"

deferred class
	TEMPS

feature {ANY} -- Acces

	chronometre (a_temps: NATURAL)
			-- Incr�mente le temps du chronom�tre � l'aide de a_temps.
		do
			if not pause then
				pause := False
				temps_milliseconde := temps_milliseconde + a_temps - temps_debut_milliseconde
				temps_debut_milliseconde := a_temps
			end
		ensure
			Temps_Debut_Milliseconde_Assigne: temps_debut_milliseconde = a_temps
			Temps_Milliseconde_Assigne: temps_milliseconde = temps_milliseconde + a_temps - temps_debut_milliseconde
		end

	depart_chrono (a_debut_milliseconde: NATURAL)
			-- D�marre le chronom�tre au temps de a_debut_milliseconde.
		do
			temps_debut_milliseconde := a_debut_milliseconde
		ensure
			Temps_Debut_Assigne: temps_debut_milliseconde = a_debut_milliseconde
		end

	unpause (a_temps: NATURAL)
			-- Remets le chronom�tre en marche au bon temps � l'aide de a_temps.
		do
			temps_milliseconde := temps_milliseconde - (a_temps - temps_pause)
			pause := False
		ensure
			Est_Pas_Pause: pause = False
			Temps_Assigne: temps_milliseconde = temps_milliseconde - (a_temps - temps_pause)
		end

feature {ANY} -- Implementation

	pause: BOOLEAN
			-- D�termine si le jeu est en pause.

	temps_pause: NATURAL
		 	-- Le temps de la pause.

	temps_debut_milliseconde: NATURAL
			-- Le temps depuis la cr�ation du chronom�tre.

	temps_milliseconde: NATURAL
			-- Le temps en millisecondes.

end
