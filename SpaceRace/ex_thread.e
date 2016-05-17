note
	description: "Classe qui contient les méthodes relatives aux threads."
	author: "Nicolas Bisson et Étienne Drolet"
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
			-- Crée `Current'.
		do
			make_thread
			doit_arreter := False
			socket := a_socket
		end

feature {ANY} -- Access

	execute
			-- Boucle du thread pour lire les commandes reçues.
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
			-- Mets "doit_arreter" à "True" pour quitter le thread.
		do
			doit_arreter := True
		end

feature {NONE} -- Implementation

	doit_arreter: BOOLEAN
			-- Détermine si le thread doit arrêter.

	socket: NETWORK_DATAGRAM_SOCKET

end
