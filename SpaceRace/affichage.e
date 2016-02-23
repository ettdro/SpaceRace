note
	description: "Summary description for {AFFICHAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AFFICHAGE

create
	make_affichage

feature {NONE} -- Initialization

	make_affichage
			-- Initialization for `Current'.
		do
			print("Allo")
		end

end
