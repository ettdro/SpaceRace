note
	description: "Contient les m�thodes de gestion que tous les menus se doivent d'avoir."
	author: "�tienne Drolet & Nicolas Bisson"
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
			-- Constructeur de la classe abstraite MENU qui cr�er une liste de coordonn�es,
			-- la fen�tre, la musique et le son lors d'un click.
		do
			fenetre := a_fenetre
			musique := a_musique
			son_click := a_son_click
			create curseur.make
			create fond.make_image (fenetre.fenetre.renderer, "background_space.png")
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
			-- M�thode qui g�re les actions de la souris dans les menus.
		deferred
		end

	mouvements_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_MOTION_STATE; a_x, a_y: INTEGER_32; a_fenetre: GAME_WINDOW_RENDERED)
			-- D�tecte la position du curseur en positions 'a_x' et 'a_y'.
		do
			curseur.change_curseur (a_temps, a_etat_souris, a_x, a_y, a_fenetre, liste_coordonnees)
		end

	execution
			-- M�thode d'ex�cution des menus qui g�re la boucle du menu.
		do
			fenetre.fenetre.mouse_motion_actions.extend (agent mouvements_souris(?, ?, ?, ?, fenetre.fenetre))
			game_library.iteration_actions.extend (agent  (a_timestamp: NATURAL)
				do
					audio_library.update
				end)
			fenetre.fenetre.mouse_button_pressed_actions.extend (agent action_souris(?, ?, ?))
			game_library.quit_signal_actions.extend (agent quitter_jeu)
		end

	verifier_si_muet
			-- V�rifie si le son du jeu est muet ou non pour le faire jouer si n�cessaire.
		do
			if not musique.est_muet then
				son_click.jouer (False)
			end
		end

feature {ANY} -- Implementation

	quitter: BOOLEAN -- Permet de quitter le programme.

	retour_options: BOOLEAN -- Permet de quitter le menu "OPTIONS".

	retour_credits: BOOLEAN -- Permet de quitter le menu "CREDITS".

	retour_comment_jouer: BOOLEAN -- Permet de quitter le menu "COMMENT JOUER".

	retour_pistes: BOOLEAN -- Permet de quitter le menu "PISTES".

	retour_vaisseaux: BOOLEAN -- Permet de quitter le menu "VAISSEAUX".

	retour_jeu_principal: BOOLEAN -- Permet de quitter le menu "JEU PRINCIPAL".

	fenetre: FENETRE -- La fen�tre de l'application.

	musique: MUSIQUE -- La musique principale du jeu.

	son_click: EFFETS_SONORES -- Le son qui est ex�cut� lors d'un click.

	curseur: CURSEUR -- Le curseur de la souris.

	fond: FOND_ECRAN -- L'image de fond.

	liste_coordonnees: LIST [TUPLE [x1, y1, x2, y2: INTEGER]] -- Liste de coordonn�es des boutons dans les menus.

end
