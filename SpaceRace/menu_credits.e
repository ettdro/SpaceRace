note
	description: "Classe qui gère le menu des crédits."
	author: "Nicolas Bisson et Étienne Drolet"
	date: "2016-04-03"
	revision: "1.1"

class
	MENU_CREDITS

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
			-- Construit le menu des crédits et ses images.
		do
			Precursor (a_fenetre, a_musique, a_son_click)
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			create texte.creer_affichable (fenetre.fenetre.renderer, "texte_credits.png")
			liste_coordonnees.extend ([30, 520, 236, 576]) -- Coordonnées du bouton RETOUR.
		end

feature -- Access

	execution
			-- Faire afficher le menu et ses images et lancer la gestion de la souris.
		do
			from
				quitter := False
				retour_credits := False
			until
				quitter or retour_credits
			loop
				game_library.clear_all_events
				lancer_fenetre_credits
				Precursor {MENU}
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris dans les menus.
		do
			if a_etat_souris.is_left_button_pressed then
				if a_etat_souris.x > 29 and a_etat_souris.x < 237 and a_etat_souris.y > 519 and a_etat_souris.y < 577 then
						-- Bouton RETOUR
					verifier_si_muet
					curseur.reinitialiser_curseur
					retour_credits := True
					quitter := False
					game_library.stop
				end
			end
		end

feature {NONE}

	lancer_fenetre_credits
			-- Dessine les éléments de la fenêtre.
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			texte.afficher (0,0, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

feature {ANY} -- Implementation

	bouton_retour: AFFICHABLE

	texte: AFFICHABLE

end
