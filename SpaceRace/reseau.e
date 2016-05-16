note
	description: "Classe qui gère la connexion réseau pour le tableau des temps."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-05-15"
	revision: "1.4"

class
	RESEAU

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
		end

feature {ANY} -- Access

	inserer_record
			-- Enregistre le record dans la base de données.
		do
			create message.make_empty					-- P-e à enlever
			message := "nicbiss 1min12%N"
			socket.put_integer (message.count)
			socket.put_string (message)
			socket.close
		end

	supprimer_donnees
			-- Supprime les données de la base de données.
		do
			create message.make_empty					-- P-e à enlever
			message := "supprimer"
			socket.put_integer (message.count)
			socket.put_string (message)
			socket.close
		end

feature {NONE} -- Implementation

	socket: NETWORK_DATAGRAM_SOCKET
			-- Le socket du réseau.

	message: STRING
			-- Le message a envoyé sur le port.

end
