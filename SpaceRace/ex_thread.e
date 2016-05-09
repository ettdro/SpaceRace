note
	description: "Classe qui contient les méthodes relatives aux threads."
	author: "Nicolas Bisson et Étienne Drolet"
	date: "2016-04-22"
	revision: "1.0"

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

	make (a_message: STRING)
			-- Crée `Current' avec le message (a_message) qu'il affichera.
		do
			make_thread
			doit_arreter := False
			message := a_message
		end

feature {ANY} -- Access

	execute
			-- Boucle du thread pour afficher le message.
		do
			from
			until
				doit_arreter
			loop
				io.put_string (message)
				io.output.flush
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

	message: STRING
			-- Le message qui sera affiché.

end
