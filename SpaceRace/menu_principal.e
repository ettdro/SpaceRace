note
	description: "Affiche le menu de d�marrage o� l'on peut choisir de jouer ou d'aller dans les options."
	author: "�tienne Drolet & Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

class
	MENU_PRINCIPAL

inherit

	MENU
		redefine
			execution
		end

	GAME_LIBRARY_SHARED

	IMG_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialization

	make
			-- Construit le menu principal et ses images.
		do
			create fenetre.make
			create son_click.creer_son_click
			create musique.creer
			create bouton_jouer.creer_affichable (fenetre.fenetre.renderer, "bouton_jouer2.png")
			create bouton_options.creer_affichable (fenetre.fenetre.renderer, "bouton_options2.png")
			create bouton_quitter.creer_affichable (fenetre.fenetre.renderer, "bouton_quitter2.png")
			create logo.creer_affichable (fenetre.fenetre.renderer, "logo2.png")
			create curseur.make
			create {ARRAYED_LIST[TUPLE[x1, y1, x2, y2:INTEGER]]}liste_coordonnees.make (3)
			liste_coordonnees.extend ([400,250,606,306])	-- Coordonn�es du bouton JOUER.
			liste_coordonnees.extend ([400,350,606,406])	-- Coordonn�es du bouton OPTIONS.
			liste_coordonnees.extend ([400,450,606,506])	-- Coordonn�es du bouton QUITTER.
		end

feature -- Access

	execution
			-- G�re le menu principal et le bouton "X" rouge de la fen�tre pour tous les menus.
		do
			musique.jouer (True)
			from
				is_quit_principal := False
			until
				is_quit_principal
			loop
				game_library.clear_all_events
				lancer_fenetre_principal
				Precursor {MENU}
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- M�thode qui g�re les clicks de souris pour permettre la navigation � partir de ce menu.
		do
			if a_etat_souris.is_left_button_pressed then
				if a_etat_souris.x > 399 and a_etat_souris.x < 607 and a_etat_souris.y > 449 and a_etat_souris.y < 507 then
					quitter_jeu (1)
				elseif a_etat_souris.x > 399 and a_etat_souris.x < 607 and a_etat_souris.y > 349 and a_etat_souris.y < 407 then
					if not musique.est_muet then
						son_click.jouer (False)
					end
					curseur.reinitialiser_curseur
					is_quit_options := False
					is_quit_principal := True
					lancer_fenetre_options
				elseif a_etat_souris.x > 399 and a_etat_souris.x < 607 and a_etat_souris.y > 249 and a_etat_souris.y < 307 then
					if not musique.est_muet then
						son_click.jouer (False)
					end
					curseur.reinitialiser_curseur
					is_quit_principal := True
					is_quit_pistes := False
					lancer_fenetre_jouer
				end
			end
		end

feature {NONE}

	lancer_fenetre_principal
			-- Dessine les �l�ments de la fen�tre.
		do
			fenetre.repeter_fenetre
			bouton_jouer.afficher (400, 250, fenetre.fenetre.renderer)
			bouton_options.afficher (400, 350, fenetre.fenetre.renderer)
			bouton_quitter.afficher (400, 450, fenetre.fenetre.renderer)
			logo.afficher (250, 75, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

	lancer_fenetre_options
			-- Lance le menu des options.
		local
			l_menu_options: MENU_OPTIONS
		do
			create l_menu_options.make (fenetre, musique, son_click)
			l_menu_options.execution
			is_quit_principal := l_menu_options.is_quit_principal
		end

	lancer_fenetre_jouer
			-- Lance le menu de s�lection de la piste.
		local
			l_menu_piste: MENU_PISTES
		do
			create l_menu_piste.make (fenetre, musique, son_click)
			l_menu_piste.execution
			is_quit_principal := l_menu_piste.is_quit_principal
		end

feature {ANY} -- Implementation

	bouton_jouer: AFFICHABLE

	bouton_options: AFFICHABLE

	bouton_quitter: AFFICHABLE

	logo: AFFICHABLE

end
