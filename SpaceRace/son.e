note
	description: "Contient les m�thodes g�n�rales li�es aux sons, autant pour la musique que les bruits de vaisseaux."
	author: "Nicolas Bisson & �tienne Drolet"
	date: "2016-03-01"
	revision: "1.0"

deferred class
	SON

feature

	creer_son (a_fenetre: GAME_WINDOW)
			-- M�thode qui cr�e le son.
		deferred
		end

	repeter_son (a_temps: NATURAl; a_fenetre: GAME_WINDOW)
			-- M�thode qui fait r�p�ter le son.
		deferred
		end

end
