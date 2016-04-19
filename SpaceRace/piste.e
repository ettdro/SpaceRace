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
			x := 59
			y := 250
			create checkpoint_liste.make (3)
			checkpoint_liste.extend (checkpoint1)
			checkpoint_liste.extend (checkpoint2)
			checkpoint_liste.extend (checkpoint3)
			checkpoint_liste.start
		end

	make_jaune (a_fenetre: FENETRE)
			-- Construit la piste Jaune.
		do
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteJ.png")
			x := 59
			y := 330
			create checkpoint_liste.make (4)
			checkpoint_liste.extend (checkpoint1)
			checkpoint_liste.extend (checkpoint2)
			checkpoint_liste.extend (checkpoint3)
			checkpoint_liste.extend (checkpoint4)
			checkpoint_liste.start
		end

	make_mauve (a_fenetre: FENETRE)
			-- Construit la piste Mauve.
		do
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteM.png")
			x := 33
			y := 330
			create checkpoint_liste.make (7)
			checkpoint_liste.extend (checkpoint1)
			checkpoint_liste.extend (checkpoint2)
			checkpoint_liste.extend (checkpoint3)
			checkpoint_liste.extend (checkpoint4)
			checkpoint_liste.extend (checkpoint5)
			checkpoint_liste.extend (checkpoint6)
			checkpoint_liste.extend (checkpoint7)
			checkpoint_liste.start
		end

	make_bleu (a_fenetre: FENETRE)
			-- Construit la piste Bleue.
		do
			create piste.creer_affichable (a_fenetre.fenetre.renderer, "pisteB.png")
			x := 42
			y := 260
			create checkpoint_liste.make (4)
			checkpoint_liste.extend (checkpoint1)
			checkpoint_liste.extend (checkpoint2)
			checkpoint_liste.extend (checkpoint3)
			checkpoint_liste.extend (checkpoint4)
			checkpoint_liste.start
		end

feature {ANY} -- Implementation

	piste: AFFICHABLE -- L'image de la piste pour la partie.

	x: INTEGER -- La position de départ de la piste en X.

	y: INTEGER -- La position de départ de la piste en Y.

	checkpoint_liste: ARRAYED_LIST [BOOLEAN] -- Liste qui contient les variables Boolean des checkpoints.

	checkpoint1: BOOLEAN -- Permet de déterminer si le checkpoint 1 a été passé.

	checkpoint2: BOOLEAN -- Permet de déterminer si le checkpoint 2 a été passé.

	checkpoint3: BOOLEAN -- Permet de déterminer si le checkpoint 3 a été passé.

	checkpoint4: detachable BOOLEAN -- Permet de déterminer si le checkpoint 4 a été passé. "detachable", car une piste  peut ne pas avoir 4 checkpoint.

	checkpoint5: detachable BOOLEAN -- Permet de déterminer si le checkpoint 5 a été passé. "detachable", car une piste  peut ne pas avoir 5 checkpoint.

	checkpoint6: detachable BOOLEAN -- Permet de déterminer si le checkpoint 6 a été passé. "detachable", car une piste  peut ne pas avoir 6 checkpoint.

	checkpoint7: detachable BOOLEAN -- Permet de déterminer si le checkpoint 7 a été passé. "detachable", car une piste  peut ne pas avoir 7 checkpoint.

end
