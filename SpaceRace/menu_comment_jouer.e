note
	description: "Classe qui g�re le menu qui explique comment jouer au jeu SpaceRace."
	author: "Nicolas Bisson et �tienne Drolet"
	date: "2016-04-03"
	revision: "1.1"

class
	MENU_COMMENT_JOUER

inherit

	MENU
		redefine
			execution,
			make
		end

create
	make

feature -- Initialization

	make (a_fenetre: FENETRE; a_musique: MUSIQUE; a_son_click: EFFETS_SONORES)
			-- Construit le menu qui explique comment jouer et ses images.
		do
			Precursor (a_fenetre, a_musique, a_son_click)
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			create texte.creer_affichable (fenetre.fenetre.renderer, "texte_instructions.png")
			liste_coordonnees.extend ([30, 520, 236, 576]) -- Coordonn�es du bouton RETOUR.
		end

feature {ANY} -- Access

	execution
			-- Faire afficher le menu et ses images et lancer la gestion de la souris.
		do
			from
				quitter := False
				retour_comment_jouer := False
			until
				quitter or retour_comment_jouer
			loop
				game_library.clear_all_events
				lancer_fenetre_comment_jouer
				Precursor {MENU}
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- M�thode qui g�re les actions de la souris dans les menus.
		do
			if a_etat_souris.is_left_button_pressed then
				valider_bouton_retour (a_etat_souris.x, a_etat_souris.y)
			end
		end

	valider_bouton_retour (a_x, a_y: INTEGER)
			-- M�thode v�rifiant si la souris est sur le bouton RETOUR et ex�cute l'action en cons�quence.
		do
			if
				a_x > Bouton_retour_coordonnees.x1 and
				a_x < Bouton_retour_coordonnees.x2 and
				a_y > Bouton_retour_coordonnees.y1 and
				a_y < Bouton_retour_coordonnees.y2
			then
				verifier_si_muet
				curseur.reinitialiser_curseur
				retour_comment_jouer := True
				quitter := False
				game_library.stop
			end
		end

feature {NONE}

	lancer_fenetre_comment_jouer
			-- Dessine les �l�ments de la fen�tre.
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			texte.afficher (0, 0, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

feature {ANY} -- Implementation

	bouton_retour: AFFICHABLE -- L'image du bouton "RETOUR".

	texte: AFFICHABLE -- L'image du texte.

feature {NONE} -- Constantes

	Bouton_retour_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER] -- Constante repr�sentant les coordonn�es du bouton RETOUR.
		once
			Result := [29, 519, 237, 577]
		end

end
