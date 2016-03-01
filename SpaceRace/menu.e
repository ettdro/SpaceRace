note
	description: "Contient les méthodes que tous les menus se doivent d'avoir."
	author: "Étienne Drolet & Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

deferred class
	MENU

inherit

	AFFICHAGE

feature

	quitter_jeu (a: NATURAL_32)
			-- Méthode pour fermer le programme.
		deferred
		end

	navigation
			-- Méthode pour changer de menu.
		deferred
		end

	execution
			-- Faire afficher le menu.
		deferred
		end

end
