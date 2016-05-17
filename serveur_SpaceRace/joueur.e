note
	description: "Summary description for {JOUEUR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JOUEUR

inherit
	COMPARABLE

create
	make

feature {NONE} -- Initialization

	make(a_nom:STRING; a_temps:STRING)
			-- Initialization for `Current'.
		do
			nom_joueur := a_nom
			temps_joueur := a_temps
			nom_joueur.prune_all_trailing ('%N')
			temps_joueur.prune_all_trailing ('%N')
		end

feature -- Access

	is_less alias "<" (a_other: like Current): BOOLEAN
			-- Classe les temps des joueurs (du plus petit au plus grand).
		local
			liste_string: LIST[STRING]
			minutes, secondes: INTEGER
			minutes_other, secondes_other: INTEGER
		do
			liste_string := temps_joueur.split (':')
			minutes := liste_string[1].to_integer
			secondes := liste_string[2].to_integer

			liste_string := a_other.temps_joueur.split (':')
			minutes_other := liste_string[1].to_integer
			secondes_other := liste_string[2].to_integer

			if minutes = minutes_other then
				Result := secondes < secondes_other
			else
				Result := minutes < minutes_other
			end
		end

feature {ANY} -- Access

	nom_joueur: STRING
			-- Le nom du joueur en STRING.

	temps_joueur: STRING
			-- Le temps du joueur en STRING.
end
