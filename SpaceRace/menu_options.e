note
	description: "Classe qui gére le menu des options du jeu."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-04-03"
	revision: "1.1"

class
	MENU_OPTIONS

inherit

	MENU
		redefine
			execution,
			make
		end

create
	make

feature -- Initialization

	make (a_fenetre: FENETRE; a_musique: EFFET_SONORE; a_son_click: EFFET_SONORE)
			-- Construit le menu des options, ses images ainsi que la liste des coordonnées des boutons.
		do
			Precursor (a_fenetre, a_musique, a_son_click)
			if not musique.est_muet then
				doit_afficher_bouton_muet := False
			end
			if musique.est_muet then
				doit_afficher_bouton_muet := True
			end
			create bouton_muet.creer_affichable (fenetre.fenetre.renderer, "bouton_muet.png")
			create bouton_non_muet.creer_affichable (fenetre.fenetre.renderer, "bouton_non_muet.png")
			create bouton_credits.creer_affichable (fenetre.fenetre.renderer, "bouton_credits.png")
			create bouton_comment_jouer.creer_affichable (fenetre.fenetre.renderer, "bouton_comment_jouer.png")
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			liste_coordonnees.extend ([400, 100, 606, 156]) -- Coordonnées des boutons MUET/NON_MUET.
			liste_coordonnees.extend ([400, 200, 606, 256]) -- Coordonnées du bouton CREDITS.
			liste_coordonnees.extend ([310, 300, 695, 356]) -- Coordonnées du bouton COMMENT_JOUER.
			liste_coordonnees.extend ([30, 520, 236, 576]) -- Coordonnées du bouton RETOUR.
		end

feature {ANY} -- Access

	execution
			-- Faire afficher le menu et ses images et lancer la gestion de la souris.
		do
			from
				quitter := False
				retour_options := False
			until
				quitter or retour_options
			loop
				game_library.clear_all_events
				lancer_fenetre_options
				Precursor {MENU}
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris dans le menu.
		do
			if a_etat_souris.is_left_button_pressed then
				valider_bouton_muet (a_etat_souris.x, a_etat_souris.y)
				valider_bouton_credits (a_etat_souris.x, a_etat_souris.y)
				valider_bouton_comment_jouer (a_etat_souris.x, a_etat_souris.y)
				valider_bouton_retour (a_etat_souris.x, a_etat_souris.y)
			end
		end

	valider_bouton_muet (a_x, a_y: INTEGER)
			-- Méthode vérifiant si la souris est sur le bouton MUET et exécute l'action en conséquence.
		do
			if
				a_x > Bouton_muet_coordonnees.x1 and
				a_x < Bouton_muet_coordonnees.x2 and
				a_y > Bouton_muet_coordonnees.y1 and
				a_y < Bouton_muet_coordonnees.y2
			then
				doit_afficher_bouton_muet := not doit_afficher_bouton_muet
				lancer_fenetre_options
			end
		end

	valider_bouton_credits (a_x, a_y: INTEGER)
			-- Méthode vérifiant si la souris est sur le bouton RETOUR et exécute l'action en conséquence.
		do
			if
				a_x > Bouton_credits_coordonnees.x1 and
				a_x < Bouton_credits_coordonnees.x2 and
				a_y > Bouton_credits_coordonnees.y1 and
				a_y < Bouton_credits_coordonnees.y2
			then
				verifier_si_muet
				curseur.reinitialiser_curseur
				lancer_fenetre_credits
			end
		end

	valider_bouton_comment_jouer (a_x, a_y: INTEGER)
			-- Méthode vérifiant si la souris est sur le bouton RETOUR et exécute l'action en conséquence.
		do
			if
				a_x > Bouton_comment_jouer_coordonnees.x1 and
				a_x < Bouton_comment_jouer_coordonnees.x2 and
				a_y > Bouton_comment_jouer_coordonnees.y1 and
				a_y < Bouton_comment_jouer_coordonnees.y2
			then
				verifier_si_muet
				curseur.reinitialiser_curseur
				lancer_fenetre_comment_jouer
			end
		end

	valider_bouton_retour (a_x, a_y: INTEGER)
			-- Méthode vérifiant si la souris est sur le bouton RETOUR et exécute l'action en conséquence.
		do
			if
				a_x > Bouton_retour_coordonnees.x1 and
				a_x < Bouton_retour_coordonnees.x2 and
				a_y > Bouton_retour_coordonnees.y1 and
				a_y < Bouton_retour_coordonnees.y2
			then
				verifier_si_muet
				curseur.reinitialiser_curseur
				retour_options := True
				quitter := False
				game_library.stop
			end
		end

feature {NONE} -- Affichage

	lancer_fenetre_options
			-- Affiche toutes les images du menu à l'endroit précisé.
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			if doit_afficher_bouton_muet = True then
				bouton_muet.afficher (400, 100, fenetre.fenetre.renderer)
				musique.mute
			else
				bouton_non_muet.afficher (400, 100, fenetre.fenetre.renderer)
				musique.unmute
			end
			bouton_credits.afficher (400, 200, fenetre.fenetre.renderer)
			bouton_comment_jouer.afficher (310, 300, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

	lancer_fenetre_credits
			-- Lance le menu des crédits.
		local
			l_menu_credits: MENU_CREDITS
		do
			create l_menu_credits.make (fenetre, musique, son_click)
			l_menu_credits.execution
			quitter := l_menu_credits.quitter
		end

	lancer_fenetre_comment_jouer
			-- Lance le menu qui explique comment jouer.
		local
			l_menu_comment_jouer: MENU_COMMENT_JOUER
		do
			create l_menu_comment_jouer.make (fenetre, musique, son_click)
			l_menu_comment_jouer.execution
			quitter := l_menu_comment_jouer.quitter
		end

feature {ANY} -- Implementation

	doit_afficher_bouton_muet: BOOLEAN
			-- Détermine lequel des boutons "MUET" sera affiché.

	bouton_muet: AFFICHABLE
			-- L'image du bouton "MUET" lorsque le son est muet.

	bouton_non_muet: AFFICHABLE
			-- L'image du bouton "MUET" lorsque le son est actif.

	bouton_credits: AFFICHABLE
			-- L'image du bouton "CREDITS".

	bouton_comment_jouer: AFFICHABLE
			-- L'image du bouton "COMMENT JOUER".

	bouton_retour: AFFICHABLE
			-- L'image du bouton "RETOUR".

feature {NONE} -- Constantes

	Bouton_muet_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du bouton MUET.
		once
			Result := [399, 99, 607, 157]
		end

	Bouton_credits_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du bouton CREDITS.
		once
			Result := [399, 199, 607, 257]
		end

	Bouton_comment_jouer_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du bouton COMMENT JOUER.
		once
			Result := [309, 299, 695, 357]
		end

	Bouton_retour_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du bouton RETOUR.
		once
			Result := [29, 519, 237, 577]
		end

end
