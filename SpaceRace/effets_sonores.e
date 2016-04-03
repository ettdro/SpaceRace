note
	description: "Classe qui lance la création de tous les effets sonores."
	author: "Nicolas Bisson et Étienne Drolet"
	date: "2016-04-03"
	revision: "1.1"

class
	EFFETS_SONORES

inherit

	SON

create
	creer_son

feature {NONE} -- Initialization

	creer_son (a_nom_fichier: STRING)
			-- Lance la création d'un effet sonore.
		require
			Bon_Format_Audio: a_nom_fichier.ends_with (".wav")
		do
			creer_audio (a_nom_fichier)
		end

end
