note
	description: "Classe qui gère la base de données contenant les meilleurs temps."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-05-17"
	revision: "1.4"

class
	BASE_DONNEES

create
	make

feature {NONE} -- Initialization

	make
			-- Crée la base de données contenant les informations des meilleurs scores.
		local
			l_fabrique: PS_SQLITE_REPOSITORY_FACTORY
		do
			create l_fabrique.make
			l_fabrique.set_database ("classement.db")
			base_donnee := l_fabrique.new_repository
			create {SORTED_TWO_WAY_LIST [JOUEUR]} joueurs.make
		end

feature {ANY} -- Access

	remplir_liste_joueurs
			-- Mets tous les joueurs qui ont un score dans la base de données dans une liste.
		local
			l_requete: PS_QUERY [JOUEUR]
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
			-- Ajout d'un joueur (a_nom et a_temps) dans la base de données.
		local
			l_un_joueur: JOUEUR
			l_transaction: PS_TRANSACTION
		do
			create l_un_joueur.make (a_nom, a_temps)
			l_transaction := base_donnee.new_transaction
			if not l_transaction.has_error then
				l_transaction.insert (l_un_joueur)
				print (l_un_joueur.nom_joueur.out + " - " + l_un_joueur.temps_joueur.out + " a ete ajoute a la BD!")
				if not l_transaction.has_error then
					l_transaction.commit
				end
			end
		end

feature {ANY} -- Implementation

	base_donnee: PS_REPOSITORY
			-- La base de données qui contient les champs pour les meilleurs temps.

	joueurs: LIST [JOUEUR]
			-- La liste des joueurs dont leurs données sont inscrits dans la BD.

end
