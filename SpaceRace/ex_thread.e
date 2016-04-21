note
	description: "Summary description for {EX_THREAD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

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

	make (a_chaine:STRING)
			-- Initialization for `Current'.
		do
			make_thread
			must_stop := false
			chaine_affiche := a_chaine
		end

	execute
		do
			from
			until
				must_stop
			loop
				io.put_string ("Thread - ")
				io.output.flush
			end
		end

feature
	stop_thread
		do
			must_stop := true
		end

	must_stop: BOOLEAN

	chaine_affiche: STRING
end
