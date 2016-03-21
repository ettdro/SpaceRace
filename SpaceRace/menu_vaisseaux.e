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
			execution
		end

create
	make

feature {NONE} -- Initialization

	make (a_fenetre: FENETRE; a_musique: MUSIQUE; a_son_click: EFFETS_SONORES)
			-- Construit le menu pour choisir le vaisseaux.
		do
			fenetre := a_fenetre
			musique := a_musique
			son_click := a_son_click
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			create fond.make_image (fenetre.fenetre.renderer)
			create cadre.creer_affichable (fenetre.fenetre.renderer, "bordure_pistes.png")
			create bouton_suivant.creer_affichable (fenetre.fenetre.renderer, "bouton_suivant.png")
		end

feature -- Access

	execution
			-- Faire afficher le menu et ses images et lancer la gestion de la souris.
		do
			from
				is_quit_vaisseaux := False
			until
				is_quit_vaisseaux
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
					is_quit_vaisseaux := True
					is_quit_pistes := False
					game_library.stop
				elseif a_etat_souris.x > 759 and a_etat_souris.x < 917 and a_etat_souris.y > 519 and a_etat_souris.y < 577 then
					if not musique.est_muet then
						son_click.jouer (False)
					end
						-- LANCER LA FENETRE DE JEU_PRINCIPAL
				end
			end
		end

--	mouvements_souris (a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_MOTION_STATE; a_delta_x, a_delta_y: INTEGER_32; a_window: GAME_WINDOW_RENDERED)
--			-- When the mouse is moving, update the mouse information (from `a_mouse_state') on the `a_window' using
--			-- `a_font' to draw text.
--		do
--		end

feature {NONE}

	lancer_fenetre_vaisseaux
			-- Dessine les éléments de la fenêtre.
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			bouton_suivant.afficher (760, 520, fenetre.fenetre.renderer)
			cadre.afficher (200, 50, fenetre.fenetre.renderer)
			cadre.afficher (538, 50, fenetre.fenetre.renderer)
			cadre.afficher (375, 300, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

feature {ANY} -- Implementation

	cadre: BOUTONS

	bouton_retour: BOUTONS

	fond: FOND_ECRAN

	bouton_suivant: BOUTONS

end
