note
	description: "Contient les méthodes générales liées aux sons, autant pour la musique que les bruits de vaisseaux."
	author: "Nicolas Bisson & Étienne Drolet"
	date: "2016-03-01"
	revision: "1.0"

deferred class
	SON

feature

	ajuster_son (a_fenetre: GAME_WINDOW)
		deferred
		end

	mise_a_jour_son (a_temps: NATURAl; a_fenetre: GAME_WINDOW)
		deferred
		end

end
