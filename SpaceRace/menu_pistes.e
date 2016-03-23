note
	description: "Gère le menu où l'on choisi la piste sur laquelle courser."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

class
	MENU_PISTES

inherit

	MENU
		redefine
			execution
		end

create
	make

feature {NONE} -- Initialization

	make (a_fenetre: FENETRE; a_musique: MUSIQUE; a_son_click: EFFETS_SONORES)
			-- Construit le menu pour choisir la piste.
		do
			fenetre := a_fenetre
			musique := a_musique
			son_click := a_son_click
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			create fond.make_image (fenetre.fenetre.renderer)
			create titre.creer_affichable (fenetre.fenetre.renderer, "choisir_piste.png")
			create cadre.creer_affichable (fenetre.fenetre.renderer, "bordure_pistes.png")
			create bouton_suivant.creer_affichable (fenetre.fenetre.renderer, "bouton_suivant.png")
			create curseur.make
			create {ARRAYED_LIST[TUPLE[x1, y1, x2, y2:INTEGER]]}liste_coordonnees.make (6)
			liste_coordonnees.extend ([30,520,236,576])			-- Coordonnées du bouton RETOUR.
			liste_coordonnees.extend ([760,520,966,576])		-- Coordonnées du bouton SUIVANT.
			liste_coordonnees.extend ([200,120,450,270])		-- Coordonnées du bouton CADRE_1.
			liste_coordonnees.extend ([550,120,800,270])		-- Coordonnées du bouton CADRE_2.
			liste_coordonnees.extend ([200,300,450,450])		-- Coordonnées du bouton CADRE_3.
			liste_coordonnees.extend ([550,300,800,450])		-- Coordonnées du bouton CADRE_4.
		end

feature -- Access

	execution
			-- Faire afficher le menu et ses images et lancer la gestion de la souris.
		do
			from
				is_quit_pistes := False
			until
				is_quit_pistes
			loop
				game_library.clear_all_events
				lancer_fenetre_pistes
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
					curseur.reinitialiser_curseur
					is_quit_pistes := True
					is_quit_principal := False
					game_library.stop
				elseif a_etat_souris.x > 759 and a_etat_souris.x < 917 and a_etat_souris.y > 519 and a_etat_souris.y < 577 then
					if not musique.est_muet then
						son_click.jouer (False)
					end
					curseur.reinitialiser_curseur
					is_quit_vaisseaux := False
					is_quit_pistes := True
					lancer_fenetre_vaisseaux
				end
			end
		end

feature {NONE}

	lancer_fenetre_pistes
			-- Dessine les éléments de la fenêtre.
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			titre.afficher (230, 30, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			bouton_suivant.afficher (760, 520, fenetre.fenetre.renderer)
			cadre.afficher (200, 120, fenetre.fenetre.renderer)
			cadre.afficher (550, 120, fenetre.fenetre.renderer)
			cadre.afficher (200, 300, fenetre.fenetre.renderer)
			cadre.afficher (550, 300, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

	lancer_fenetre_vaisseaux
			-- Lance le menu de sélection d'un vaisseau.
		local
			l_menu_vaisseaux: MENU_VAISSEAUX
		do
			create l_menu_vaisseaux.make (fenetre, musique, son_click)
			l_menu_vaisseaux.execution
			is_quit_pistes := l_menu_vaisseaux.is_quit_pistes
		end

feature {ANY} -- Implementation

	cadre: AFFICHABLE

	titre: AFFICHABLE

	bouton_retour: AFFICHABLE

	fond: FOND_ECRAN

	bouton_suivant: AFFICHABLE

end
