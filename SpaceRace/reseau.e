note
	description: "Classe qui g�re la connexion r�seau pour le tableau des temps."
	author: "�tienne Drolet et Nicolas Bisson"
	date: "2016-04-22"
	revision: "1.0"

class
	RESEAU -- PAS FINI

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
		end

feature {ANY}

	inserer_record
		do
			create message.make_empty					--P-e � enlever
			message := "nicbiss 1min12%N"
			socket.put_integer (message.count)
			socket.put_string (message)
			socket.close
		end

	supprimer_donnees
		do
			create message.make_empty					--P-e � enlever
			message := "supprimer"
			socket.put_integer (message.count)
			socket.put_string (message)
			socket.close
		end

feature {NONE}

	socket: NETWORK_DATAGRAM_SOCKET

	message: STRING

end
