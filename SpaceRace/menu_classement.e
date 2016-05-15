note
	description: "Summary description for {MENU_CLASSEMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MENU_CLASSEMENT

inherit
	MENU
		redefine
			make,
			execution
		end

create
	make

feature {NONE} -- Initialization

	make (a_fenetre: FENETRE; a_musique: EFFET_SONORE; a_son_click: EFFET_SONORE)
			-- Initialization for `Current'.
		do
			Precursor (a_fenetre, a_musique, a_son_click)
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			liste_coordonnees.extend (Bouton_retour_coordonnees)
			liste_coordonnees.extend (Bouton_reinitialiser_coordonnees)
			create font.make ("impact.ttf", 30)
			font.open
			create couleur.make_rgb (255, 102, 0)
			create text_surface_numeros.make ("1. ", font, couleur)
			create texture_numeros.make_from_surface (a_fenetre.fenetre.renderer, text_surface_numeros)
			create reseau.make
		end

feature {ANY}

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
				lancer_fenetre_classement
				Precursor {MENU}
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris (a_etat_souris) dans les menus.
		do
			if a_etat_souris.is_left_button_pressed then
				valider_bouton_reinitialiser (a_etat_souris.x, a_etat_souris.y)
				valider_bouton_retour (a_etat_souris.x, a_etat_souris.y)
			end
		end

	valider_bouton_reinitialiser (a_x, a_y: INTEGER)
			-- Méthode vérifiant si la souris (a_x, a_y) est sur le bouton RETOUR et exécute l'action en conséquence.
		do
			if
				a_x > Bouton_reinitialiser_coordonnees.x1 and
				a_x < Bouton_reinitialiser_coordonnees.x2 and
				a_y > Bouton_reinitialiser_coordonnees.y1 and
				a_y < Bouton_reinitialiser_coordonnees.y2
			then
				verifier_si_muet
				curseur.reinitialiser_curseur
				create reseau.make
				reseau.lire_donnees
				reseau.ecouter
			end
		end

	lancer_fenetre_classement
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.draw_texture (texture_numeros, 300, 200)
			fenetre.fenetre.renderer.present
		end

feature {ANY} -- Access

	bouton_retour: AFFICHABLE

	text_surface_numeros: TEXT_SURFACE_BLENDED
			-- Une surface pour les numéros.

	texture_numeros: GAME_TEXTURE
			-- La texture pour les numéros.

	font: TEXT_FONT

	couleur: GAME_COLOR

	reseau: RESEAU

feature {ANY} -- Constantes

	Bouton_reinitialiser_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du bouton RETOUR.
		once
			Result := [0, 0, 30, 30]
		end


end
