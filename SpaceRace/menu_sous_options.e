note
	description: "Summary description for {MENU_SOUS_OPTIONS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MENU_SOUS_OPTIONS

inherit
	MENU
	redefine
		execution,
		action_souris,
		make
	end

feature

	make (a_fenetre: FENETRE; a_musique: EFFET_SONORE; a_son_click: EFFET_SONORE)
			-- Construit le menu qui explique comment jouer et ses images.
		do
			Precursor (a_fenetre, a_musique, a_son_click)
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			liste_coordonnees.extend (Bouton_retour_coordonnees)
		end

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
				lancer_fenetre
				Precursor {MENU}
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris dans les menus.
		do
			if a_etat_souris.is_left_button_pressed then
				valider_bouton_retour (a_etat_souris.x, a_etat_souris.y)
			end
		end

	lancer_fenetre
			-- Dessine les éléments de la fenêtre.
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			texte.afficher (0, 0, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

feature {ANY} -- Implementation

	bouton_retour: AFFICHABLE
			-- L'image du bouton "RETOUR".

	texte: AFFICHABLE
			-- L'image du texte.

end
