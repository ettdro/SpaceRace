note
	description: "Affiche le menu de démarrage où l'on peut choisir de jouer ou d'aller dans les options."
	author: "Étienne Drolet & Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

class
	MENU_PRINCIPAL

inherit

	MENU
		rename
			make as make_menu
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
		local
			l_fenetre:FENETRE
			l_musique:MUSIQUE
			l_son_click: EFFETS_SONORES
		do
			create l_fenetre.make
			create l_son_click.creer_son_click
			create l_musique.creer
			make_menu(l_fenetre, l_musique, l_son_click)
			create bouton_jouer.creer_affichable (fenetre.fenetre.renderer, "bouton_jouer2.png")
			create bouton_options.creer_affichable (fenetre.fenetre.renderer, "bouton_options2.png")
			create bouton_quitter.creer_affichable (fenetre.fenetre.renderer, "bouton_quitter2.png")
			create logo.creer_affichable (fenetre.fenetre.renderer, "logo2.png")
			liste_coordonnees.extend ([400,250,606,306])	-- Coordonnées du bouton JOUER.
			liste_coordonnees.extend ([400,350,606,406])	-- Coordonnées du bouton OPTIONS.
			liste_coordonnees.extend ([400,450,606,506])	-- Coordonnées du bouton QUITTER.
		end

feature -- Access

	execution
			-- Gère le menu principal et le bouton "X" rouge de la fenêtre pour tous les menus.
		do
			musique.jouer (True)
			from
				quitter := False
				retour_principal := False
			until
				quitter or retour_principal
			loop
				game_library.clear_all_events
				lancer_fenetre_principal
				Precursor {MENU}
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les clicks de souris pour permettre la navigation à partir de ce menu.
		do
			if a_etat_souris.is_left_button_pressed then
				if a_etat_souris.x > 399 and a_etat_souris.x < 607 and a_etat_souris.y > 449 and a_etat_souris.y < 507 then
					quitter_jeu(1)
				elseif a_etat_souris.x > 399 and a_etat_souris.x < 607 and a_etat_souris.y > 349 and a_etat_souris.y < 407 then
					if not musique.est_muet then
						son_click.jouer (False)
					end
					curseur.reinitialiser_curseur
					lancer_fenetre_options
				elseif a_etat_souris.x > 399 and a_etat_souris.x < 607 and a_etat_souris.y > 249 and a_etat_souris.y < 307 then
					if not musique.est_muet then
						son_click.jouer (False)
					end
					curseur.reinitialiser_curseur
					lancer_fenetre_jouer
				end
			end
		end

feature {NONE}

	lancer_fenetre_principal
			-- Dessine les éléments de la fenêtre.
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
			quitter := l_menu_options.quitter
		end

	lancer_fenetre_jouer
			-- Lance le menu de sélection de la piste.
		local
			l_menu_piste: MENU_PISTES
		do
			create l_menu_piste.make (fenetre, musique, son_click)
			l_menu_piste.execution
			quitter := l_menu_piste.quitter
		end

feature {ANY} -- Implementation

	bouton_jouer: AFFICHABLE

	bouton_options: AFFICHABLE

	bouton_quitter: AFFICHABLE

	logo: AFFICHABLE

end
