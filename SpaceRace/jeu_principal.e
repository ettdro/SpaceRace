note
	description: "Classe pour g�rer le JEU."
	author: "�tienne Drolet et Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

class
	JEU_PRINCIPAL

create
	make

feature {NONE} -- Initialization

	make
			-- Construit le Jeu.
		do
			make_affichage
		end

end
