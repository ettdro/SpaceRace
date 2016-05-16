note
	description : "serveur_SpaceRace application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

create
	serveur

feature {NONE} -- Initialization

	serveur
			-- Run application.
		local
			l_socket: NETWORK_DATAGRAM_SOCKET
			l_port: INTEGER
			l_longueur_message: INTEGER
			l_nom_joueur: STRING
		do
			l_port := 2767
			create l_socket.make_bound (2767)
			create {ARRAYED_LIST[STRING]}liste_commande.make (0)
			create base_donnees.make
			l_socket.read_integer
			l_longueur_message := l_socket.last_integer
			l_socket.read_stream (l_longueur_message)
			l_nom_joueur := l_socket.last_string
			liste_commande := l_nom_joueur.split (' ')
			base_donnees.remplir_liste_classement
			if liste_commande.i_th (1).has_substring ("lire") then
				envoyer_classement
			else
				base_donnees.ajouter_joueur(liste_commande.i_th (1), liste_commande.i_th (2))
			end
			l_socket.close
		end

	envoyer_classement
		local
			l_socket: NETWORK_DATAGRAM_SOCKET
		do
			create l_socket.make_targeted ("localhost", 2768)
			across
				base_donnees.joueurs as la_liste_joueurs
			loop
				if la_liste_joueurs.item.nom_joueur.count > 0 then
					l_socket.put_integer (1)
				else
					l_socket.put_integer (0)
				end
				l_socket.put_integer (la_liste_joueurs.item.nom_joueur.count + la_liste_joueurs.item.temps_joueur.count + 3)
				l_socket.put_string (la_liste_joueurs.item.nom_joueur + " - " + la_liste_joueurs.item.temps_joueur)
			end
			l_socket.put_integer (0)
			l_socket.close
		end

feature -- Access

	base_donnees: BASE_DONNEES

	liste_commande: LIST[STRING]

end
