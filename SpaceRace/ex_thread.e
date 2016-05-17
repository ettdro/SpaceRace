note
	description: "Classe qui contient les m�thodes relatives aux threads."
	author: "Nicolas Bisson et �tienne Drolet"
	date: "2016-05-17"
	revision: "1.4"

class
	EX_THREAD

inherit

	THREAD
		rename
			make as make_thread
		end

create
	make

feature {NONE} -- Initialization

	make (a_socket: NETWORK_DATAGRAM_SOCKET)
			-- Cr�e `Current'.
		do
			make_thread
			doit_arreter := False
			socket := a_socket
		end

feature {ANY} -- Access

	execute
			-- Boucle du thread pour lire les commandes re�ues.
		do
			from
			until
				doit_arreter
			loop
				socket.read_integer
				print ("allo")
			end
		end

	arret_thread
			-- Mets "doit_arreter" � "True" pour quitter le thread.
		do
			doit_arreter := True
		end

feature {NONE} -- Implementation

	doit_arreter: BOOLEAN
			-- D�termine si le thread doit arr�ter.

	socket: NETWORK_DATAGRAM_SOCKET

end
