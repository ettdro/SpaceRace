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
			-- Construit la piste Verte.
		do
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteV.png")
			x := 53
			y := 245
			nombre_checkpoint := 3
		end

	make_jaune (a_fenetre: FENETRE)
			-- Construit la piste Jaune.
		do
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteJ.png")
			x := 59
			y := 330
			nombre_checkpoint := 4
		end

	make_mauve (a_fenetre: FENETRE)
			-- Construit la piste Mauve.
		do
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteM.png")
			x := 33
			y := 330
			nombre_checkpoint := 7
		end

	make_bleu (a_fenetre: FENETRE)
			-- Construit la piste Bleue.
		do
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteB.png")
			x := 42
			y := 260
			nombre_checkpoint := 4
		end

feature {ANY} -- Implementation

	piste: AFFICHABLE -- L'image de la piste pour la partie.

	x: INTEGER -- La position de départ de la piste en X.

	y: INTEGER -- La position de départ de la piste en Y.

	nombre_checkpoint: INTEGER -- Le nombre de checkpoint que la piste possède.

end
