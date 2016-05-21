note
	description: "Classe qui gère les joueurs qui ont un score dans la BD pour pouvoir les trier du plus petit temps au plus gros."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-05-17"
	revision: "1.4"

class
	JOUEUR

inherit

	COMPARABLE

create
	make

feature {NONE} -- Initialization

	make (a_nom: STRING; a_temps: STRING)
			-- Création d'un joueur (a_nom et a_temps) dont les données sont dans la base de données.
		do
			a_nom.keep_head (10)
			a_nom.append ("...")
			nom_joueur := a_nom
			temps_joueur := a_temps
			nom_joueur.prune_all_trailing ('%N')
			temps_joueur.prune_all_trailing ('%N')
		ensure
			Nom_Assigne: nom_joueur = a_nom
			Temps_Assigne: temps_joueur = a_temps
		end

feature {ANY} -- Access

	is_less alias "<" (a_autre: like Current): BOOLEAN
			-- Classe les temps des joueurs (du plus petit au plus grand).
		local
			liste_string: LIST [STRING]
			minutes, secondes: INTEGER
			minutes_autre, secondes_autre: INTEGER
		do
			liste_string := temps_joueur.split (':')
			minutes := liste_string [1].to_integer
			secondes := liste_string [2].to_integer
			liste_string := a_autre.temps_joueur.split (':')
			minutes_autre := liste_string [1].to_integer
			secondes_autre := liste_string [2].to_integer
			if minutes = minutes_autre then
				Result := secondes < secondes_autre
			else
				Result := minutes < minutes_autre
			end
		end

feature {ANY} -- Implementation

	nom_joueur: STRING
			-- Le nom du joueur en STRING.

	temps_joueur: STRING
			-- Le temps du joueur en STRING.

end
