note
	description: "Lance la cr�ation de la musique principale."
	author: "Nicolas Bisson & �tienne Drolet"
	date: "2016-04-03"
	revision: "1.1"

class
	MUSIQUE

inherit

	SON

create
	creer

feature {NONE} -- Initialisation

	creer (a_nom_fichier: STRING)
			-- Cr�e la musique principale du jeu.
		require
			Bon_Format_Audio: a_nom_fichier.ends_with (".wav")
			Bonne_Taille_Audio: a_nom_fichier.count > 4
		do
			creer_audio (a_nom_fichier)
		end

end
