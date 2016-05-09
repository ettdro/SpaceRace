note
	description: "Classe qui lance la création de tous les effets sonores."
	author: "Nicolas Bisson et Étienne Drolet"
	date: "2016-04-03"
	revision: "1.1"

class
	EFFET_SONORE

inherit

	SON

create
	creer_son

feature {NONE} -- Initialization

	creer_son (a_nom_fichier: STRING)
			-- Lance la création du fichier audio (a_nom_fichier).
		require
			Bon_Format_Audio: a_nom_fichier.ends_with (".wav")
			Bonne_Taille_Audio: a_nom_fichier.count > 4
		do
			creer_audio (a_nom_fichier)
		end

end
