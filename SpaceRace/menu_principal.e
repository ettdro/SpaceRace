note
	description: "Affiche le menu de d�marrage o� l'on peut choisir de jouer, d'aller dans les options ou quitter."
	author: "�tienne Drolet & Nicolas Bisson"
	date: "2016-05-15"
	revision: "1.4"

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
			-- Construit le menu principal, ses images ainsi que la liste des coordonn�es des boutons.
		local
			l_fenetre: FENETRE
			l_musique: EFFET_SONORE
			l_son_click: EFFET_SONORE
		do
			create l_fenetre.make
			create l_son_click.creer_son ("./sons/click_sound.wav")
			create l_musique.creer_son ("./sons/MusiqueMenu.wav")
			make_menu (l_fenetre, l_musique, l_son_click)
			create bouton_classement.creer_affichable (fenetre.fenetre.renderer, "./images/bouton_classement.png")
			create bouton_jouer.creer_affichable (fenetre.fenetre.renderer, "./images/bouton_jouer2.png")
			create bouton_options.creer_affichable (fenetre.fenetre.renderer, "./images/bouton_options2.png")
			create bouton_quitter.creer_affichable (fenetre.fenetre.renderer, "./images/bouton_quitter2.png")
			create logo.creer_affichable (fenetre.fenetre.renderer, "./images/logo.png")
			liste_coordonnees.extend (Bouton_jouer_coordonnees)
			liste_coordonnees.extend (Bouton_options_coordonnees)
			liste_coordonnees.extend (Bouton_quitter_coordonnees)
			liste_coordonnees.extend (Bouton_classement_coordonnees)
		end

feature {ANY} -- Access

	execution
			-- Faire afficher le menu et ses images et lancer la gestion de la souris et du bouton "X" rouge de la fen�tre pour tous les menus.
		do
			musique.jouer (True)
			from
				quitter := False
			until
				quitter
			loop
				game_library.clear_all_events
				lancer_fenetre_principal
				Precursor {MENU}
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- M�thode qui g�re les clicks de souris `a_etat_souris' pour permettre la navigation � partir de ce menu.
		do
			if a_etat_souris.is_left_button_pressed then
				valider_bouton_classement(a_etat_souris.x, a_etat_souris.y)
				valider_bouton_jouer(a_etat_souris.x, a_etat_souris.y)
				valider_bouton_options(a_etat_souris.x, a_etat_souris.y)
				valider_bouton_quitter(a_etat_souris.x, a_etat_souris.y)
			end
		end

	valider_bouton_classement(a_x, a_y:INTEGER)
			-- M�thode v�rifiant si les coordonn�es de la souris `a_x' et `a_y' sont �gales aux coordonn�es du bouton
			-- `Bouton_classement_coordonnees' et ex�cute l'action en cons�quence.
		do
			if
				a_x > Bouton_classement_coordonnees.x1 and
				a_x < Bouton_classement_coordonnees.x2 and
				a_y > Bouton_classement_coordonnees.y1 and
				a_y < Bouton_classement_coordonnees.y2
			then
				verifier_son_click_muet
				curseur.reinitialiser_curseur
				lancer_fenetre_classement
			end
		end

	valider_bouton_jouer(a_x, a_y:INTEGER)
			-- M�thode v�rifiant si les coordonn�es de la souris `a_x' et `a_y' sont �gales aux coordonn�es du bouton
			-- `Bouton_jouer_coordonnees' et ex�cute l'action en cons�quence.
		do
			if
				a_x > Bouton_jouer_coordonnees.x1 and
				a_x < Bouton_jouer_coordonnees.x2 and
				a_y > Bouton_jouer_coordonnees.y1 and
				a_y < Bouton_jouer_coordonnees.y2
			then
				verifier_son_click_muet
				curseur.reinitialiser_curseur
				lancer_fenetre_jouer
			end
		end

	valider_bouton_options(a_x, a_y:INTEGER)
			-- M�thode v�rifiant si les coordonn�es de la souris `a_x' et `a_y' sont �gales aux coordonn�es du bouton
			-- `Bouton_options_coordonnees' et ex�cute l'action en cons�quence.
		do
			if
				a_x > Bouton_options_coordonnees.x1 and
				a_x < Bouton_options_coordonnees.x2 and
				a_y > Bouton_options_coordonnees.y1 and
				a_y < Bouton_options_coordonnees.y2
			then
				verifier_son_click_muet
				curseur.reinitialiser_curseur
				lancer_fenetre_options
			end
		end

	valider_bouton_quitter(a_x, a_y:INTEGER)
			-- M�thode v�rifiant si les coordonn�es de la souris `a_x' et `a_y' sont �gales aux coordonn�es du bouton
			-- `Bouton_quitter_coordonnees' et ex�cute l'action en cons�quence.
		do
			if
				a_x > Bouton_quitter_coordonnees.x1 and
				a_x < Bouton_quitter_coordonnees.x2 and
				a_y > Bouton_quitter_coordonnees.y1 and
				a_y < Bouton_quitter_coordonnees.y2
			then
				quitter_jeu (1)
			end
		end

feature {NONE} -- Affichage

	lancer_fenetre_principal
			-- Dessine les �l�ments de la fen�tre du MENU_PRINCIPAL.
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			bouton_classement.afficher (20, 10, fenetre.fenetre.renderer)
			bouton_jouer.afficher (400, 250, fenetre.fenetre.renderer)
			bouton_options.afficher (400, 350, fenetre.fenetre.renderer)
			bouton_quitter.afficher (400, 450, fenetre.fenetre.renderer)
			logo.afficher (250, 75, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

	lancer_fenetre_options
			-- Lance le menu d'options.
		local
			l_menu_options: MENU_OPTIONS
		do
			create l_menu_options.make (fenetre, musique, son_click)
			l_menu_options.execution
			quitter := l_menu_options.quitter
		end

	lancer_fenetre_jouer
			-- Lance le menu de s�lection de la piste.
		local
			l_menu_piste: MENU_PISTES
		do
			create l_menu_piste.make (fenetre, musique, son_click)
			l_menu_piste.execution
			quitter := l_menu_piste.quitter
			sortir_menu := not l_menu_piste.sortir_menu
		end

	lancer_fenetre_classement
			-- Lance le classement du jeu.
		local
			l_menu_classement: MENU_CLASSEMENT
		do
			create l_menu_classement.make (fenetre, musique, son_click)
			l_menu_classement.execution
			quitter := l_menu_classement.quitter
			sortir_menu := l_menu_classement.sortir_menu
		end


feature {ANY} -- Implementation

	bouton_classement: AFFICHABLE
			-- L'image du bouton "CLASSEMENT"

	bouton_jouer: AFFICHABLE
			-- L'image du bouton "JOUER"

	bouton_options: AFFICHABLE
			-- L'image du bouton "OPTIONS"

	bouton_quitter: AFFICHABLE
			-- L'image du bouton "QUITTER"

	logo: AFFICHABLE
			-- L'image du titre principal.

feature {NONE}  -- Constantes

	Bouton_classement_coordonnees:TUPLE[x1, y1, x2, y2:INTEGER]
			-- Constante repr�sentant les coordonn�es du bouton CLASSEMENT.
		once
			Result := [20, 10, 60, 60]
		end

	Bouton_jouer_coordonnees:TUPLE[x1, y1, x2, y2:INTEGER]
			-- Constante repr�sentant les coordonn�es du bouton JOUER.
		once
			Result := [399, 249, 607, 307]
		end

	Bouton_options_coordonnees:TUPLE[x1, y1, x2, y2:INTEGER]
			-- Constante repr�sentant les coordonn�es du bouton OPTIONS.
		once
			Result := [399, 349, 607, 407]
		end

	Bouton_quitter_coordonnees:TUPLE[x1, y1, x2, y2:INTEGER]
			-- Constante repr�sentant les coordonn�es du bouton QUITTER.
		once
			Result := [399, 449, 607, 507]
		end

end
