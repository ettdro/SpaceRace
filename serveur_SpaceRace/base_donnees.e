note
	description: "Summary description for {BASE_DONNEES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BASE_DONNEES

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		local
			l_fabrique: PS_SQLITE_REPOSITORY_FACTORY
		do
			create l_fabrique.make
			l_fabrique.set_database ("classement.db")
			base_donnee := l_fabrique.new_repository
			create {LINKED_LIST[JOUEUR]}joueurs.make
		end

feature {ANY}

	remplir_liste_classement
		local
			l_requete: PS_QUERY[JOUEUR]
		do
			create l_requete.make
			base_donnee.execute_query (l_requete)
			across
				l_requete as la_requete
			loop
				joueurs.extend (la_requete.item)
			end
			l_requete.close
		end

	ajouter_joueur (a_nom: STRING; a_temps: STRING)
		local
			l_un_joueur: JOUEUR
			l_transaction: PS_TRANSACTION
		do
			create l_un_joueur.make (a_nom, a_temps)
			l_transaction := base_donnee.new_transaction
			if not l_transaction.has_error then
				l_transaction.insert (l_un_joueur)
				if not l_transaction.has_error then
					l_transaction.commit
				end
			end
		end

feature -- Access

	base_donnee: PS_REPOSITORY

	joueurs: LIST[JOUEUR]
end
