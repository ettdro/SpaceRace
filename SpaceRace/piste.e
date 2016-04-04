note
	description: "Summary description for {PISTE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PISTE

create
	make_vert,
	make_bleu,
	make_jaune,
	make_mauve

feature {NONE} -- Initialization

	make_vert (a_fenetre: FENETRE)
			-- Initialization for `Current'.
		do
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteV.png")
			x := 53
			y := 245
		end

	make_jaune (a_fenetre: FENETRE)
			-- Initialization for `Current'.
		do
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteJ.png")
			x := 59
			y := 330
		end

	make_mauve (a_fenetre: FENETRE)
			-- Initialization for `Current'.
		do
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteM.png")
			x := 33
			y := 330
		end

	make_bleu (a_fenetre: FENETRE)
			-- Initialization for `Current'.
		do
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteB.png")
			x := 42
			y := 260
		end

feature {ANY}

	piste: AFFICHABLE

	x: INTEGER

	y: INTEGER

end
