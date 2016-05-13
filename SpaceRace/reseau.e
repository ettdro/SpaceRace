note
	description: "Classe qui gère la connexion réseau pour le tableau des temps."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-04-22"
	revision: "1.0"

class
	RESEAU -- PAS FINI

create
	make

feature {NONE} -- Initialization

	make
			-- Crée le socket.
		local
			l_socket: NETWORK_DATAGRAM_SOCKET
			l_port: INTEGER
			l_host: STRING
			l_message: STRING
		do
			l_port := 2767
			l_host := "localhost"
			l_message := "ettbelette 2min45%N"
			create l_socket.make_targeted (l_host, l_port)
			l_socket.put_integer (l_message.count)
			l_socket.put_string (l_message)
			l_socket.close

		end

feature -- Access



end
