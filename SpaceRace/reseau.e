note
	description: "Classe qui gère la connexion réseau pour le tableau des temps."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-04-22"
	revision: "1.0"

class
	RESEAU -- PAS FINI

create
	serveur

feature {NONE} -- Initialization

	serveur
			-- Crée le socket.
		local
			l_socket: NETWORK_DATAGRAM_SOCKET
			l_port: INTEGER
		do
			l_port := 2767
			create l_socket.make_bound (l_port)
			l_socket.read_integer
		end

end
