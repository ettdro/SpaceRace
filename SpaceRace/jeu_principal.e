note
	description: "Classe pour gérer le jeu, la partie qui consiste à faire une course pour enregistrer le meilleur temps."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

class
	JEU_PRINCIPAL

inherit

	MENU
		redefine
			execution,
			make
		end

create
	make

feature {NONE} -- Initialization

	make (a_fenetre: FENETRE; a_musique: MUSIQUE; a_son_click: EFFETS_SONORES)
			-- Construit le menu pour choisir le vaisseaux.
		do
			Precursor (a_fenetre, a_musique, a_son_click)
			create fond.make_image (fenetre.fenetre.renderer)
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			liste_coordonnees.extend ([760, 520, 966, 576]) -- Coordonnées du bouton RETOUR.
		end

feature -- Access

	execution
			-- Faire afficher le menu et ses images et lancer la gestion de la souris.
		do
			from
				quitter := False
				retour_jeu_principal := False
			until
				quitter or retour_jeu_principal
			loop
				game_library.clear_all_events
				lancer_fenetre_jeu_principal
				Precursor {MENU}
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris dans le menu.
		do
			if a_etat_souris.is_left_button_pressed then
				if a_etat_souris.x > 759 and a_etat_souris.x < 917 and a_etat_souris.y > 519 and a_etat_souris.y < 577 then
					if not musique.est_muet then
						son_click.jouer (False)
					end
					curseur.reinitialiser_curseur
					retour_jeu_principal := True
					quitter := False
					game_library.stop
				end
			end
		end

feature {NONE}

	lancer_fenetre_jeu_principal
			-- Dessine les éléments de la fenêtre.
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			bouton_retour.afficher (760, 520, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

feature {ANY} -- Implementation

	bouton_retour: AFFICHABLE

	fond: FOND_ECRAN

end
