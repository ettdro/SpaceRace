note
	description: "Classe qui g�re la connexion r�seau pour le tableau des temps."
	author: "�tienne Drolet et Nicolas Bisson"
	date: "2016-05-15"
	revision: "1.4"

class
	RESEAU

create
	make

feature {NONE} -- Initialization

	make
			-- Cr�e le socket.
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
			-- �coute sur le port pour interpr�ter les commandes.
		local
			l_socket: NETWORK_DATAGRAM_SOCKET
			l_longueur_message: INTEGER
			l_infos_joueur: STRING
			l_quit : INTEGER
		do
			create l_socket.make_bound (2768)
			l_socket.read_integer
			l_quit := l_socket.last_integer
			from
			until
				l_quit = 0
			loop
				l_socket.read_integer
				l_longueur_message := l_socket.last_integer
				l_socket.read_stream (l_longueur_message)
				l_infos_joueur := l_socket.last_string
				l_socket.read_integer
				l_quit := l_socket.last_integer
				joueurs.extend (l_infos_joueur)
				classer_joueurs
			end
			l_socket.close
		end

	inserer_record
			-- Enregistre le record dans la base de donn�es.
		do
			create message.make_empty					--P-e � enlever
			message := "sanic 0:30%N"
			socket.put_integer (message.count)
			socket.put_string (message)
			socket.close
		end

	lire_donnees
			-- Lis les donn�es pour les affich�es � l'�cran.
		do
			create message.make_empty					--P-e � enlever
			message := "lire"
			socket.put_integer (message.count)
			socket.put_string (message)
			socket.close
		end

	classer_joueurs
		do

		end

feature {NONE} -- Implementation

	socket: NETWORK_DATAGRAM_SOCKET
			-- Le socket du r�seau.

	message: STRING
			-- Le message a envoy� sur le port.

feature {ANY}

	joueurs: LIST[STRING]

end
