note
	description: "Contient les méthodes de gestion que tous les menus se doivent d'avoir."
	author: "Étienne Drolet & Nicolas Bisson"
	date: "2016-04-03"
	revision: "1.1"

deferred class
	MENU

inherit

	AUDIO_LIBRARY_SHARED

	GAME_LIBRARY_SHARED

	IMG_LIBRARY_SHARED

feature -- Initialization

	make (a_fenetre: FENETRE; a_musique: MUSIQUE; a_son_click: EFFETS_SONORES)
			-- Constructeur de la classe abstraite MENU qui créer une liste de coordonnées,
			-- la fenêtre, la musique et le son lors d'un click.
		do
			fenetre := a_fenetre
			musique := a_musique
			son_click := a_son_click
			create curseur.make
			create fond.make_image (fenetre.fenetre.renderer, "background_space.png")
			create {LINKED_LIST [TUPLE [x1, y1, x2, y2: INTEGER]]} liste_coordonnees.make
		end

feature -- Access

	quitter_jeu (a_temps: NATURAL_32)
			-- Méthode qui ferme l'application.
		do
			quitter := True
			game_library.stop
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris dans les menus.
		deferred
		end

	mouvements_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_MOTION_STATE; a_x, a_y: INTEGER_32; a_fenetre: GAME_WINDOW_RENDERED)
			-- Détecte la position du curseur en positions 'a_x' et 'a_y'.
		do
			curseur.est_sur_bouton (a_temps, a_etat_souris, a_x, a_y, a_fenetre, liste_coordonnees)
		end

	execution
			-- Méthode d'exécution des menus qui gère la boucle du menu.
		do
			fenetre.fenetre.mouse_motion_actions.extend (agent mouvements_souris(?, ?, ?, ?, fenetre.fenetre))
			game_library.iteration_actions.extend (agent  (a_timestamp: NATURAL)
				do
					audio_library.update
				end)
			fenetre.fenetre.mouse_button_pressed_actions.extend (agent action_souris(?, ?, ?))
			game_library.quit_signal_actions.extend (agent quitter_jeu)
		end

feature {ANY} -- Implementation

	quitter: BOOLEAN

	retour_principal: BOOLEAN

	retour_options: BOOLEAN

	retour_credits: BOOLEAN

	retour_comment_jouer: BOOLEAN

	retour_pistes: BOOLEAN

	retour_vaisseaux: BOOLEAN

	retour_jeu_principal: BOOLEAN

	fenetre: FENETRE

	musique: MUSIQUE

	son_click: EFFETS_SONORES

	curseur: CURSEUR

	fond: FOND_ECRAN

	liste_coordonnees: LIST [TUPLE [x1, y1, x2, y2: INTEGER]] -- Liste de coordonnées des boutons dans les menus.

end
