note
	description: "Gère le menu qui inscrit le score dans la base de données."
	author: "Nicolas Bisson et Étienne Drolet"
	date: "2016-05-21"
	revision: "1.5"

class
	MENU_INSCRIPTION

inherit

	MENU
		redefine
			execution,
			make
		end

create
	make

feature {NONE} -- Initialization

	make (a_fenetre: FENETRE; a_musique: EFFET_SONORE; a_son_click: EFFET_SONORE)
			-- Construit le menu d'inscription (a_fenetre), ses sons (a_musique et a_son_click), ses images ainsi que la liste des coordonnées des boutons.
		do
			Precursor (a_fenetre, a_musique, a_son_click)
			create bouton_suivant.creer_affichable (fenetre.fenetre.renderer, "bouton_suivant.png")
			create titre_inscription.creer_affichable (fenetre.fenetre.renderer, "inscription2.png")
			liste_coordonnees.extend (Bouton_suivant_coordonnees)
		end

feature {ANY} -- Access

	execution
			-- Faire afficher le menu et ses images et lancer la gestion de la souris.
		do
			from
				quitter := False
				sortir_menu := False
			until
				quitter or sortir_menu
			loop
				game_library.clear_all_events
				lancer_fenetre_inscription
				Precursor {MENU}
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions (a_etat_souris) de la souris dans le menu.
		do
			if a_etat_souris.is_left_button_pressed then
				valider_bouton_suivant (a_etat_souris.x, a_etat_souris.y)
			end
		end

	valider_bouton_suivant (a_x, a_y: INTEGER)
			-- Méthode vérifiant si la souris (a_x, a_y) est sur le bouton SUIVANT et exécute l'action en conséquence.
		do
			if
				a_x > Bouton_suivant_coordonnees.x1 and
				a_x < Bouton_suivant_coordonnees.x2 and
				a_y > Bouton_suivant_coordonnees.y1 and
				a_y < Bouton_suivant_coordonnees.y2
			then
				verifier_son_click_muet
				curseur.reinitialiser_curseur
				lancer_fenetre_classement
				sortir_menu := True
			end
		end

feature {ANY} -- Affichage

	lancer_fenetre_inscription
			-- Affiche toutes les images du menu à l'endroit précisé.
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			titre_inscription.afficher (310, 70, fenetre.fenetre.renderer)
			bouton_suivant.afficher (760, 520, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

	lancer_fenetre_classement
			-- Lance le classement du jeu.
		local
			l_menu_classement: MENU_CLASSEMENT
		do
			create l_menu_classement.make (fenetre, musique, son_click)
			l_menu_classement.execution
			quitter := l_menu_classement.quitter
		end

feature {NONE} -- Implementation

	bouton_suivant: AFFICHABLE
			-- L'image du bouton "RETOUR".

	titre_inscription: AFFICHABLE
			-- L'image du titre "INSCRIPTION".

feature {ANY} -- Constantes

	Bouton_suivant_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du bouton SUIVANT.
		once
			Result := [759, 519, 917, 577]
		end

end
