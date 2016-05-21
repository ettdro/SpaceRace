note
	description: "Classe qui gère la connexion réseau pour le tableau des temps."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-05-15"
	revision: "1.4"

class
	RESEAU

inherit
	GAME_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialization

	make
			-- Crée le socket.
		local
			l_port: INTEGER
			l_host: STRING
		do
			l_port := 2767
			l_host := "localhost"
			create socket.make_targeted (l_host, l_port)
			create message.make_empty
			create {LINKED_LIST[STRING]}joueurs.make
		end

feature {ANY} -- Access

	ecouter
			-- Écoute sur le port pour interpréter les commandes.
		local
			l_socket: NETWORK_DATAGRAM_SOCKET
			l_infos_joueur: STRING
			l_thread: EX_THREAD
			l_temps: NATURAL_32
		do
			create l_socket.make_bound (2768)
			l_infos_joueur := ""
			create l_thread.make (l_socket, l_infos_joueur)
			l_thread.launch
			from
				l_temps := game_library.time_since_create
			until
				l_thread.est_termine or
				game_library.time_since_create > l_temps + 2000
			loop
				game_library.delay (10)
			end
			l_socket.close
			l_thread.join
			if not l_thread.est_termine then
				a_erreur := True
			end
			joueurs := l_thread.joueurs
		end

	inserer_record
			-- Enregistre le record dans la base de données.
		do
			create message.make_empty
			message := "abcdefghijklm 0:30%N"
			socket.put_integer (message.count)
			socket.put_string (message)
			socket.close
		end

	lire_donnees
			-- Lis les données pour les affichées à l'écran.
		do
			create message.make_empty
			message := "lire"
			socket.put_integer (message.count)
			socket.put_string (message)
			socket.close
		end

feature {ANY} -- Implementation

	socket: NETWORK_DATAGRAM_SOCKET
			-- Le socket du réseau.

	message: STRING
			-- Le message a envoyé sur le port.

	joueurs: LIST[STRING]
			-- Liste des joueurs avec leurs informations.

	a_erreur: BOOLEAN
			-- Détermine si une erreur a eu lieu, si le thread n'a pas quitté par lui-même.

end
