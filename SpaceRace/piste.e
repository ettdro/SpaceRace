note
	description: "Classe qui crée les pistes."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-04-04"
	revision: "1.0"

class
	PISTE

create
	make_vert,
	make_bleu,
	make_jaune,
	make_mauve

feature {NONE} -- Initialization

	make_vert (a_fenetre: FENETRE)
			-- Construit la piste Verte).
		do
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteV.png")
		end

	make_bleu (a_fenetre: FENETRE)
			-- Construit la piste Bleue.
		do
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteB.png")
		end

	make_jaune (a_fenetre: FENETRE)
			-- Construit la piste Jaune.
		do
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteJ.png")
		end

	make_mauve (a_fenetre: FENETRE)
			-- Construit la piste Mauve.
		do
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteM.png")
		end

feature {ANY} -- Implementation

	piste: AFFICHABLE

end
