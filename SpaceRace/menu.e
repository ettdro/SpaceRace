note
	description: "Contient les m�thodes que tous les menus se doivent d'avoir."
	author: "�tienne Drolet & Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

deferred class
	MENU

inherit
	AFFICHAGE

feature

	quitter_jeu (a: NATURAL_32)
		deferred
		end

	navigation (a_choix: INTEGER)
		deferred
		end

	execution
		deferred
		end

end
