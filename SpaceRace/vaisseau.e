note
	description: "Classe qui crée et gère les mouvements du vaisseau."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-04-04"
	revision: "1.2"

class
	VAISSEAU

create
	make_1,
	make_2,
	make_3

feature {NONE} -- Initialization

	make_1 (a_fenetre: FENETRE)
			-- Construit le vaisseau 1 (Rouge) dans la fenêtre (a_fenetre).
		do
			create vaisseau.creer_affichable (a_fenetre.fenetre.renderer, "vaisseau1.png")
		end

	make_2 (a_fenetre: FENETRE)
			-- Construit le vaisseau 2 (Gris) dans la fenêtre (a_fenetre).
		do
			create vaisseau.creer_affichable (a_fenetre.fenetre.renderer, "vaisseau2.png")
		end

	make_3 (a_fenetre: FENETRE)
			-- Construit le vaisseau 3 (Turquoise) dans la fenêtre (a_fenetre).
		do
			create vaisseau.creer_affichable (a_fenetre.fenetre.renderer, "vaisseau3.png")
		end

feature {ANY} -- Implementation

	vaisseau: AFFICHABLE
			-- L'image du vaisseau pour la partie.

end
