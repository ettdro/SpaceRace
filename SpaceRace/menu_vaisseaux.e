note
	description: "Gère le menu où l'on choisi le modèle du vaisseau avec lequel courser."
	author: "Nicolas Bisson et Étienne Drolet"
	date: "2016-03-01"
	revision: "1.0"

class
	MENU_VAISSEAUX

inherit

	MENU
		redefine
			execution, make
		end

create
	make

feature {NONE} -- Initialization

	make (a_fenetre: FENETRE; a_musique: MUSIQUE; a_son_click: EFFETS_SONORES)
			-- Construit le menu pour choisir le vaisseaux.
		do
			Precursor(a_fenetre, a_musique, a_son_click)
			create fond.make_image (fenetre.fenetre.renderer)
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			create bouton_suivant.creer_affichable (fenetre.fenetre.renderer, "bouton_suivant.png")
			create titre.creer_affichable (fenetre.fenetre.renderer, "choisir_vaisseau.png")
			create cadre.creer_affichable (fenetre.fenetre.renderer, "bordure_vaisseaux.png")
			create vaisseau1.creer_affichable (fenetre.fenetre.renderer, "vaisseau1_cadre.png")
			create vaisseau2.creer_affichable (fenetre.fenetre.renderer, "vaisseau2_cadre.png")
			create vaisseau3.creer_affichable (fenetre.fenetre.renderer, "vaisseau3_cadre.png")
			liste_coordonnees.extend ([30,520,236,576])			-- Coordonnées du bouton RETOUR.
			liste_coordonnees.extend ([760,520,966,576])		-- Coordonnées du bouton SUIVANT.
			liste_coordonnees.extend ([200,200,380,380])		-- Coordonnées du bouton CADRE_1.
			liste_coordonnees.extend ([430,200,610,380])		-- Coordonnées du bouton CADRE_2.
			liste_coordonnees.extend ([660,200,840,380])		-- Coordonnées du bouton CADRE_3.
		end

feature -- Access

	execution
			-- Faire afficher le menu et ses images et lancer la gestion de la souris.
		do
			from
				quitter := False
				retour_vaisseaux := False
			until
				quitter or retour_vaisseaux
			loop
				game_library.clear_all_events
				lancer_fenetre_vaisseaux
				Precursor {MENU}
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris dans le menu.
		do
			if a_etat_souris.is_left_button_pressed then
				if a_etat_souris.x > 29 and a_etat_souris.x < 237 and a_etat_souris.y > 519 and a_etat_souris.y < 577 then
					if not musique.est_muet then
						son_click.jouer (False)
					end
					curseur.reinitialiser_curseur
					retour_vaisseaux := True
					quitter := False
					game_library.stop
				elseif a_etat_souris.x > 759 and a_etat_souris.x < 917 and a_etat_souris.y > 519 and a_etat_souris.y < 577 then
					if not musique.est_muet then
						son_click.jouer (False)
					end
					curseur.reinitialiser_curseur
						-- LANCER LA FENETRE DE JEU_PRINCIPAL
				end
			end
		end

feature {NONE}

	lancer_fenetre_vaisseaux
			-- Dessine les éléments de la fenêtre.
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			titre.afficher (180, 30, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			bouton_suivant.afficher (760, 520, fenetre.fenetre.renderer)
			cadre.afficher (200, 200, fenetre.fenetre.renderer)
			vaisseau1.afficher (240, 230, fenetre.fenetre.renderer)
			cadre.afficher (430, 200, fenetre.fenetre.renderer)
			vaisseau2.afficher (470, 230, fenetre.fenetre.renderer)
			cadre.afficher (660, 200, fenetre.fenetre.renderer)
			vaisseau3.afficher (700, 230, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

feature {ANY} -- Implementation

	titre: AFFICHABLE

	vaisseau1: AFFICHABLE

	vaisseau2: AFFICHABLE

	vaisseau3: AFFICHABLE

	cadre: AFFICHABLE

	bouton_retour: AFFICHABLE

	fond: FOND_ECRAN

	bouton_suivant: AFFICHABLE

end
