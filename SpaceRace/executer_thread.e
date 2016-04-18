note
	description: "Summary description for {EXECUTER_THREAD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXECUTER_THREAD

inherit
	THREAD
		rename
			make as make_thread
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			make_thread
		end

	execute
		do
			
		end

end
