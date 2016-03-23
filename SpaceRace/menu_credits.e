note
	description: "G�re le menu des cr�dits."
	author: "Nicolas Bisson et �tienne Drolet"
	date: "2016-03-20"
	revision: "1.0"

class
	MENU_CREDITS

inherit

	MENU
		redefine
			execution, make
		end

create
	make

feature -- Initialization

	make (a_fenetre: FENETRE; a_musique: MUSIQUE; a_son_click: EFFETS_SONORES)
			-- Construit le menu des cr�dits et ses images.
		do
			Precursor(a_fenetre, a_musique, a_son_click)
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			create fond.make_image (fenetre.fenetre.renderer)
			liste_coordonnees.extend ([30,520,236,576])		-- Coordonn�es du bouton RETOUR.
		end

feature -- Access

	execution
			-- Faire afficher le menu et ses images et lancer la gestion de la souris.
		do
			from
				is_quit := False
			until
				is_quit
			loop
				game_library.clear_all_events
				lancer_fenetre_credits
				Precursor {MENU}
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- M�thode qui g�re les actions de la souris dans les menus.
		do
			if a_etat_souris.is_left_button_pressed then
				if a_etat_souris.x > 29 and a_etat_souris.x < 237 and a_etat_souris.y > 519 and a_etat_souris.y < 577 then
					if not musique.est_muet then
						son_click.jouer (False)
					end
					curseur.reinitialiser_curseur
					is_quit := True
					game_library.stop
				end
			end
		end

feature {NONE}

	lancer_fenetre_credits
			-- Dessine les �l�ments de la fen�tre.
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

feature {ANY} -- Implementation

	bouton_retour: AFFICHABLE

	fond: FOND_ECRAN

end
