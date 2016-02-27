note
	description: "Contient les méthodes générales liées aux sons, autant pour la musique que les bruits de vaisseaux."
	author: "Nicolas Bisson & Étienne Drolet"
	date: "2016-03-01"
	revision: "1.0"

deferred class
	SON

feature

	creer_son (a_fenetre: GAME_WINDOW)
			-- Méthode qui crée le son.
		deferred
		end

	repeter_son (a_temps: NATURAl; a_fenetre: GAME_WINDOW)
			-- Méthode qui fait répéter le son.
		deferred
		end

end
