note
	description: "Summary description for {RESEAU}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RESEAU

create
	serveur

feature {NONE} -- Initialization

	serveur
			-- Initialization for `Current'.
		local
			l_socket: NETWORK_DATAGRAM_SOCKET
			l_port: INTEGER
		do
			l_port := 2767
			create l_socket.make_bound (l_port)
			l_socket.read_integer
		end

end
