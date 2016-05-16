note
	description: "Classe qui g�re la connexion r�seau pour le tableau des temps."
	author: "�tienne Drolet et Nicolas Bisson"
	date: "2016-04-22"
	revision: "1.0"

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

feature {ANY}

	ecouter
		local
			l_socket: NETWORK_DATAGRAM_SOCKET
			l_longueur_message: INTEGER
			l_message: STRING
			l_nom_joueur: STRING
		do
			socket.read_integer
			l_longueur_message := socket.last_integer
			socket.read_stream (l_longueur_message)
			l_nom_joueur := socket.last_string
			print(l_nom_joueur)
		end

	inserer_record
		do
			create message.make_empty					--P-e � enlever
			message := "marc 3min42%N"
			socket.put_integer (message.count)
			socket.put_string (message)
			socket.close
		end

	lire_donnees
		do
			create message.make_empty					--P-e � enlever
			message := "lire"
			socket.put_integer (message.count)
			socket.put_string (message)
			socket.close
		end

feature {NONE}

	socket: NETWORK_DATAGRAM_SOCKET

	message: STRING

	joueurs: LIST[STRING]

end
