note
	description: "Summary description for {JOUEUR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JOUEUR

inherit
	ANY

create
	make

feature {NONE} -- Initialization

	make(a_nom:STRING; a_temps:STRING)
			-- Initialization for `Current'.
		do
			nom_joueur := a_nom
			temps_joueur := a_temps
		end

feature {ANY} -- Access

	nom_joueur: STRING

	temps_joueur: STRING
end
