note
	description: "Classe qui gère le menu qui explique comment jouer au jeu."
	author: "Nicolas Bisson et Étienne Drolet"
	date: "2016-03-20"
	revision: "1.0"


class
	MENU_COMMENT_JOUER

inherit

	MENU
		redefine
			execution
		end

create
	make

feature -- Initialization

	make (a_fenetre: FENETRE; a_musique: MUSIQUE; a_son_click: EFFETS_SONORES)
			-- Construit le menu qui explique comment jouer et ses images.
		do
			fenetre := a_fenetre
			musique := a_musique
			son_click := a_son_click
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			create fond.make_image (fenetre.fenetre.renderer)
			create curseur.make
			create {ARRAYED_LIST[TUPLE[x1, y1, x2, y2:INTEGER]]}liste_coordonnees.make (1)
			liste_coordonnees.extend ([30,520,236,576])		-- Coordonnées du bouton RETOUR.
		end

feature -- Access

	execution
			-- Faire afficher le menu et ses images et lancer la gestion de la souris.
		do
			from
				is_quit_comment_jouer := False
			until
				is_quit_comment_jouer
			loop
				game_library.clear_all_events
				lancer_fenetre_comment_jouer
				Precursor {MENU}
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris dans les menus.
		do
			if a_etat_souris.is_left_button_pressed then
				if a_etat_souris.x > 29 and a_etat_souris.x < 237 and a_etat_souris.y > 519 and a_etat_souris.y < 577 then
					if not musique.est_muet then
						son_click.jouer (False)
					end
					is_quit_options := False
					is_quit_comment_jouer := True
					game_library.stop
				end
			end
		end

feature {NONE}

	lancer_fenetre_comment_jouer
			-- Dessine les éléments de la fenêtre.
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

feature {ANY} -- Implementation

	bouton_retour: AFFICHABLE

	fond: FOND_ECRAN

end
