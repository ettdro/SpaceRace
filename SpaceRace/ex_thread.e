note
	description: "Classe qui contient les méthodes pour gérer le threads."
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

	make (a_socket: NETWORK_DATAGRAM_SOCKET; a_infos_joueur: STRING)
			-- Crée `Current' avec le socket (a_socket) et les informations du joueur (a_infos_joueur) reçues.
		do
			make_thread
			socket := a_socket
			infos_joueur := a_infos_joueur
			create {LINKED_LIST[STRING]}joueurs.make
			est_termine := False
		ensure
			Socket_Assigne: socket = a_socket
			Informations_Joueur_Assigne: infos_joueur = a_infos_joueur
		end

feature {ANY} -- Access

	execute
			-- Boucle du thread pour lire les commandes reçues.
		local
			l_quitter: INTEGER
			l_longueur_message: INTEGER
			l_reessaye: BOOLEAN
		do
			if not l_reessaye then
				socket.read_integer
				l_quitter := socket.last_integer
				from
				until
					l_quitter = 0
				loop
					socket.read_integer
					l_longueur_message := socket.last_integer
					socket.read_stream (l_longueur_message)
					infos_joueur := socket.last_string
					socket.read_integer
					l_quitter := socket.last_integer
					joueurs.extend (infos_joueur)
				end
				est_termine := True
			end
		rescue
			l_reessaye := True
			retry
		end

	arret_thread
			-- Mets "doit_arreter" à "True" pour quitter le thread.
		do
			doit_arreter := True
		end

feature {ANY} -- Implementation

	doit_arreter: BOOLEAN
			-- Détermine si le thread doit arrêter.

	socket: NETWORK_DATAGRAM_SOCKET
			-- Le socket du client.

	infos_joueur: STRING
			-- Les informations du joueur (nom et temps).

	joueurs: LIST[STRING]
			-- Liste des joueurs avec leurs informations.

	est_termine:BOOLEAN
			-- Détermine si le thread a quitté par lui-même.

end
