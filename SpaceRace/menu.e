note
	description: "Contient les m�thodes de gestion que tous les menus se doivent d'avoir."
	author: "�tienne Drolet & Nicolas Bisson"
	date: "2016-05-15"
	revision: "1.4"

deferred class
	MENU

inherit

	AUDIO_LIBRARY_SHARED

	GAME_LIBRARY_SHARED

	IMG_LIBRARY_SHARED

feature -- Initialization

	make (a_fenetre: FENETRE; a_musique: EFFET_SONORE; a_son_click: EFFET_SONORE)
			-- Constructeur de la classe abstraite MENU qui cr�e une liste de coordonn�es, la fen�tre (a_fenetre), la musique (a_musique) et le son lors d'un click (a_son_click).
		do
			fenetre := a_fenetre
			musique := a_musique
			son_click := a_son_click
			create curseur.make
			create fond.creer_affichable (fenetre.fenetre.renderer, "background_space.png")
			create {LINKED_LIST [TUPLE [x1, y1, x2, y2: INTEGER]]} liste_coordonnees.make
		ensure
			Fenetre_Assigne: fenetre = a_fenetre
			Musique_Assigne: musique = a_musique
			Son_Click_Assigne: son_click = a_son_click
		end

feature {ANY} -- Access

	quitter_jeu (a_temps: NATURAL_32)
			-- M�thode qui ferme l'application.
		do
			quitter := True
			game_library.stop
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- M�thode qui g�re les actions de la souris (a_etat_souris) dans les menus.
		deferred
		end

	mouvements_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_MOTION_STATE; a_x, a_y: INTEGER_32; a_fenetre: GAME_WINDOW_RENDERED)
			-- D�tecte la position du curseur (a_x, a_y et a_etat_souris) .
		do
			curseur.change_curseur (a_temps, a_etat_souris, a_x, a_y, a_fenetre, liste_coordonnees)
		end

	execution
			-- M�thode d'ex�cution des menus qui g�re la boucle du menu.
		do
			fenetre.fenetre.mouse_motion_actions.extend (agent mouvements_souris(?, ?, ?, ?, fenetre.fenetre))
			game_library.iteration_actions.extend (agent  (a_temps: NATURAL)
				do
					audio_library.update
				end)
			fenetre.fenetre.mouse_button_pressed_actions.extend (agent action_souris(?, ?, ?))
			game_library.quit_signal_actions.extend (agent quitter_jeu)
		end

	verifier_son_click_muet
			-- V�rifie si le son du jeu est muet ou non pour faire jouer le son d'un click si n�cessaire.
		do
			if not musique.est_muet then
				son_click.jouer (False)
			end
		end

	valider_bouton_retour (a_x, a_y: INTEGER)
			-- M�thode v�rifiant si la souris (a_x, a_y) est sur le bouton RETOUR et ex�cute l'action en cons�quence.
		do
			if
				a_x > Bouton_retour_coordonnees.x1 and
				a_x < Bouton_retour_coordonnees.x2 and
				a_y > Bouton_retour_coordonnees.y1 and
				a_y < Bouton_retour_coordonnees.y2
			then
				verifier_son_click_muet
				curseur.reinitialiser_curseur
				sortir_menu := True
				quitter := False
				game_library.stop
			end
		end

feature {ANY} -- Implementation

	quitter: BOOLEAN
			-- Permet de quitter le programme.

	sortir_menu: BOOLEAN
			-- Permet de sortir du menu actif.

	fenetre: FENETRE
			-- La fen�tre de l'application.

	musique: EFFET_SONORE
			-- La musique principale du jeu.

	son_click: EFFET_SONORE
			-- Le son qui est ex�cut� lors d'un click.

	curseur: CURSEUR
			-- Le curseur de la souris.

	fond: AFFICHABLE
			-- L'image de fond.

	liste_coordonnees: LIST [TUPLE [x1, y1, x2, y2: INTEGER]]
			-- Liste de coordonn�es des boutons dans les menus.


feature {ANY} -- Constantes

	Bouton_retour_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante repr�sentant les coordonn�es du bouton RETOUR.
		once
			Result := [29, 519, 237, 577]
		end

end
