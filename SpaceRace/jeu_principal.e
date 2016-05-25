note
	description: "Classe pour gérer le jeu qui consiste à faire une course pour enregistrer le meilleur temps."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-05-15"
	revision: "1.4"

class
	JEU_PRINCIPAL

inherit

	MECANIQUE

	MENU
		rename
			make as make_menu
		redefine
			execution,
			valider_bouton_retour
		end

create
	make

feature {NONE} -- Initialization

	make (a_fenetre: FENETRE; a_musique: EFFET_SONORE; a_son_click: EFFET_SONORE; a_piste_selectionne: PISTE; a_vaisseau_selectionne: VAISSEAU)
			-- Construit le menu du jeu (a_piste_selectionne et a_vaisseau_selectionne), ses effets sonores (a_musique et a_son_click) dans la fenêtre (a_fenetre).
		do
			piste_selectionne := a_piste_selectionne
			vaisseau_selectionne := a_vaisseau_selectionne
			vaisseau_y := piste_selectionne.y
			vaisseau_x := piste_selectionne.x
			make_menu (a_fenetre, a_musique, a_son_click)
			if not musique.est_muet then
				doit_afficher_bouton_muet := False
			end
			if musique.est_muet then
				doit_afficher_bouton_muet := True
			end
			create font.make ("impact.ttf", 72)
			font.open
			create couleur.make_rgb (255, 102, 0)
			create bouton_muet.creer_affichable (fenetre.fenetre.renderer, "bouton_muet_jeu.png")
			create bouton_non_muet.creer_affichable (fenetre.fenetre.renderer, "bouton_non_muet_jeu.png")
			create titre_tours.creer_affichable (fenetre.fenetre.renderer, "titre_tours.png")
			create titre_chrono.creer_affichable (fenetre.fenetre.renderer, "titre_chrono.png")
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			create bouton_pause.creer_affichable (fenetre.fenetre.renderer, "bouton_pause.png")
			create bouton_jouer.creer_affichable (fenetre.fenetre.renderer, "bouton_jouer2.png")
			create image_pause.creer_affichable (fenetre.fenetre.renderer, "popup_pause.png")
			create image_cliquez_jouer.creer_affichable (fenetre.fenetre.renderer, "cliquez_jouer.png")
			create son_vaisseau.creer_son ("Vaisseau.wav")
			create son_vaisseau_fin.creer_son ("Vaisseau_Fin.wav")
			create chronometre.make (fenetre.fenetre.renderer, font, couleur)
			liste_coordonnees.extend (Bouton_retour_jeu_coordonnees)
			liste_coordonnees.extend (Bouton_pause_coordonnees)
			liste_coordonnees.extend (Bouton_jouer_coordonnees)
			liste_coordonnees.extend (Bouton_muet_coordonnees)
		ensure
			Piste_Assigne: piste_selectionne = a_piste_selectionne
			Vaisseau_Assigne: vaisseau_selectionne = a_vaisseau_selectionne
			Position_Vaisseau_Y: vaisseau_y = piste_selectionne.y
			Position_Vaisseau_X: vaisseau_x = piste_selectionne.x
		end

feature {ANY} -- Access

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
				Precursor {MENU}
				est_debut := True
				deja_afficher := False
				lancer_fenetre_jeu_principal
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris (a_etat_souris) dans le menu et a_temps sert pour le chronomètre.
		do
			if a_etat_souris.is_left_button_pressed then
				valider_bouton_muet (a_etat_souris.x, a_etat_souris.y)
				valider_bouton_jouer (a_temps, a_etat_souris.x, a_etat_souris.y)
				valider_bouton_pause (a_temps, a_etat_souris.x, a_etat_souris.y)
				valider_bouton_retour (a_etat_souris.x, a_etat_souris.y)
			end
		end

	valider_bouton_muet (a_x, a_y: INTEGER)
			-- Méthode vérifiant si la souris (a_x, a_y) est sur le bouton MUET et exécute l'action en conséquence.
		do
			if
				a_x > Bouton_muet_coordonnees.x1 and
				a_x < Bouton_muet_coordonnees.x2 and
				a_y > Bouton_muet_coordonnees.y1 and
				a_y < Bouton_muet_coordonnees.y2
			then
				doit_afficher_bouton_muet := not doit_afficher_bouton_muet
				afficher_bouton_son
				son_vaisseau.mute
				son_vaisseau_fin.mute
				lancer_fenetre_jeu_principal
			end
		end

	valider_bouton_jouer (a_temps: NATURAL_32; a_x, a_y: INTEGER)
			-- Méthode vérifiant si la souris (a_x, a_y) est sur le bouton JOUER et exécute l'action en conséquence et a_temps sert pour le chronomètre.
		do
			if
				a_x > Bouton_jouer_coordonnees.x1 and
				a_x < Bouton_jouer_coordonnees.x2 and
				a_y > Bouton_jouer_coordonnees.y1 and
				a_y < Bouton_jouer_coordonnees.y2
			then
				verifier_son_click_muet
				if est_debut then
					chronometre.depart_chrono (a_temps)
					fenetre.fenetre.key_pressed_actions.extend (agent action_clavier(?, ?))
					fenetre.fenetre.key_released_actions.extend (agent action_clavier_relache(?, ?))
					fenetre.game_library.iteration_actions.extend (agent sur_iteration(?, fenetre.fenetre.renderer))
					est_debut := False
				end
				if etait_pause then
					chronometre.unpause (a_temps)
					etait_pause := False
				end
				curseur.reinitialiser_curseur
			end
		end

	valider_bouton_pause (a_temps: NATURAL_32; a_x, a_y: INTEGER)
			-- Méthode vérifiant si la souris (a_x, a_y) est sur le bouton PAUSE et exécute l'action en conséquence et a_temps sert pour le chronomètre.
		do
			if
				a_x > Bouton_pause_coordonnees.x1 and
				a_x < Bouton_pause_coordonnees.x2 and
				a_y > Bouton_pause_coordonnees.y1 and
				a_y < Bouton_pause_coordonnees.y2
			then
				verifier_son_click_muet
				if not etait_pause and not est_debut then
					etait_pause := True
					chronometre.pause_chrono (a_temps)
				end
				curseur.reinitialiser_curseur
			end
		end

	valider_bouton_retour (a_x, a_y: INTEGER)
			-- Méthode vérifiant si la souris (a_x, a_y) est sur le bouton RETOUR et exécute l'action en conséquence.
		do
			if
				a_x > Bouton_retour_jeu_coordonnees.x1 and
				a_x < Bouton_retour_jeu_coordonnees.x2 and
				a_y > Bouton_retour_jeu_coordonnees.y1 and
				a_y < Bouton_retour_jeu_coordonnees.y2
			then
				verifier_son_click_muet
				curseur.reinitialiser_curseur
				sortir_menu := True
				quitter := False
				game_library.stop
			end
		end

	action_clavier (a_temps: NATURAL_32; a_etat_clavier: GAME_KEY_STATE)
			-- Vérifie quelle touche (a_etat_clavier) est pressée pour pouvoir exécuter la bonne action (déplacement ou rotation).
		do
			if not chronometre.pause then
				if not a_etat_clavier.is_repeat then
					touche_repetee := False
					if a_etat_clavier.is_w then
						accelerer := True
						decelerer := False
						verifier_son_vaisseau_muet
					end
					if a_etat_clavier.is_s then
						decelerer := False
						accelerer := False
						freiner := True
						verifier_son_vaisseau_muet
					end
					if a_etat_clavier.is_a then
						tourne_gauche := True
						tourne_droite := False
						verifier_son_vaisseau_muet
					end
					if a_etat_clavier.is_d then
						tourne_gauche := False
						tourne_droite := True
						verifier_son_vaisseau_muet
					end
				end
			end
		end

	action_clavier_relache (a_temps: NATURAL_32; a_etat_clavier: GAME_KEY_STATE)
			-- Vérifie que l'accélération (a_etat_clavier) est relâchée pour décélérer.
		do
			if a_etat_clavier.is_w then
				touche_repetee := False
				decelerer := True
				accelerer := False
				verifier_son_vaisseau_muet
			end
			if a_etat_clavier.is_s then
				freiner := False
				if not accelerer then
					decelerer := True
				end
				verifier_son_vaisseau_muet
			end
			if a_etat_clavier.is_a then
				tourne_gauche := False
				verifier_son_vaisseau_muet
			end
			if a_etat_clavier.is_d then
				tourne_droite := False
				verifier_son_vaisseau_muet
			end
		end

	verifier_son_vaisseau_muet
			-- Vérifie si le son est muet pour jouer ou non le son du vaisseau.
		do
			if not musique.est_muet then
				if accelerer then
					son_vaisseau.jouer (True)
				end
				if not accelerer then
					son_vaisseau.source.stop
					son_vaisseau_fin.jouer (False)
				end
				if tourne_droite or tourne_gauche and not accelerer then
					son_vaisseau.jouer (True)
				end
			else
				son_vaisseau.mute
			end
		end

	sur_iteration (a_temps: NATURAL_32; a_fenetre: GAME_RENDERER)
			-- Rafraichit la fenêtre (a_fenetre) du jeu principal à chaque itération et a_timestamp sert au chronomètre.
		do
			if not chronometre.pause then
				chronometre.chronometre (a_temps)
			end
			verification_position_vaisseau
			lancer_fenetre_jeu_principal
			if not etait_pause then
				if accelerer then
					acceleration_vaisseau
				end
				if decelerer then
					deceleration_vaisseau
				end
				if freiner then
					freiner_vaisseau
				end
				if tourne_gauche then
					rotation_gauche
				end
				if tourne_droite then
					rotation_droite
				end
				avancer
			end
		end

feature {NONE} -- Affichage

	lancer_fenetre_jeu_principal
			-- Dessine les éléments de la fenêtre.
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			bouton_retour.afficher (760, 520, fenetre.fenetre.renderer)
			bouton_pause.afficher (760, 420, fenetre.fenetre.renderer)
			bouton_jouer.afficher (760, 320, fenetre.fenetre.renderer)
			titre_tours.afficher (760, 160, fenetre.fenetre.renderer)
			titre_chrono.afficher (760, 40, fenetre.fenetre.renderer)
			piste_selectionne.piste.afficher (0, 0, fenetre.fenetre.renderer)
			piste_selectionne.valider_checkpoint(vaisseau_x.rounded, vaisseau_y.rounded, fenetre.fenetre.renderer)
			piste_selectionne.allumer_lumiere(fenetre.fenetre.renderer)
			afficher_bouton_son
			chronometre.afficher_temps
			if est_debut then
				image_cliquez_jouer.afficher (100, 250, fenetre.fenetre.renderer)
				vaisseau_selectionne.vaisseau.afficher (vaisseau_x.rounded, vaisseau_y.rounded, fenetre.fenetre.renderer)
			else
				vaisseau_selectionne.vaisseau.afficher_rotation (rotation_vaisseau, vaisseau_x.rounded, vaisseau_y.rounded, fenetre.fenetre.renderer)
			end
			if chronometre.pause then
				image_pause.afficher (380, 250, fenetre.fenetre.renderer)
			end
			if piste_selectionne.tours.nombre_tour = 3 then
				lancer_fenetre_inscription
			end
			fenetre.fenetre.renderer.present
		end

	lancer_fenetre_inscription
			-- Lance le menu d'inscription pour la base de données.
		local
			l_menu_inscription: MENU_INSCRIPTION
		do
			son_vaisseau.source.stop
			son_vaisseau_fin.source.stop
			create l_menu_inscription.make (fenetre, musique, son_click, chronometre)
			l_menu_inscription.execution
			quitter := l_menu_inscription.quitter
			sortir_menu := l_menu_inscription.sortir_menu
		end

	afficher_bouton_son
			-- Affiche le bon bouton "MUET" selon l'état du son (s'il avait été changé ou non dans le menu "OPTIONS" ou celui-ci).
		do
			if doit_afficher_bouton_muet then
				bouton_muet.afficher (935, 0, fenetre.fenetre.renderer)
				musique.mute
			else
				bouton_non_muet.afficher (935, 0, fenetre.fenetre.renderer)
				musique.unmute
			end
		end

feature {ANY} -- Implementation

	etait_pause: BOOLEAN
			-- Attribut qui donne True si le temps était sur pause. False sinon.

	image_pause: AFFICHABLE
			-- L'image du « popup » de pause.

	image_cliquez_jouer: AFFICHABLE
			-- L'image du « popup » pour jouer.

	bouton_retour: AFFICHABLE
			-- L'image du bouton "RETOUR"

	bouton_pause: AFFICHABLE
			-- L'image du bouton "PAUSE"

	bouton_jouer: AFFICHABLE
			-- L'image du bouton "JOUER"

	titre_tours: AFFICHABLE
			-- L'image du titre "TOURS"

	titre_chrono: AFFICHABLE
			-- L'image du titre "CHRONO"

	piste_selectionne: PISTE
			-- La piste qui a été choisie.

	vaisseau_selectionne: VAISSEAU
			-- Le vaisseau qui a été sélectionné.

	bouton_muet: AFFICHABLE
			-- L'image du bouton "MUET" lorsque le son est muet.

	bouton_non_muet: AFFICHABLE
			-- L'image du bouton "MUET" lorsque le son est actif.

	doit_afficher_bouton_muet: BOOLEAN
			-- Détermine lequel des boutons "MUET" sera affiché.

	deja_afficher: BOOLEAN
			-- Détermine si le vaisseau est déjà affiché.

	chronometre: TEMPS_CHRONOMETRE
			-- Le chronomètre du jeu.

	font: TEXT_FONT
			-- La police d'écriture du texte (chornomètre et tours).

	couleur: GAME_COLOR
			-- La couleur du texte (chronomètre et tours).

	est_debut: BOOLEAN
			-- Détermine s'il s'agit du début de la partie pour afficher le bon temps du chronomètre.

	tour_complete: BOOLEAN
			-- Détermine si le nombre de tours completés doit changer.

	son_vaisseau: EFFET_SONORE
			-- Le son du vaisseau qui accélère.

	son_vaisseau_fin: EFFET_SONORE
			-- Le son du vaisseau qui décélère.

	accelerer: BOOLEAN
			-- Détermine si le vaisseau est en train d'accélérer.

	decelerer: BOOLEAN
			-- Détermine si le vaisseau est en train de décélérer.

	freiner: BOOLEAN
			-- Détermine si le vaisseau est en train de ralentir.

	touche_repetee: BOOLEAN
			-- Détermine si une touche est maintenue enfoncée.

	tourne_gauche: BOOLEAN
			-- Détermine si le vaisseau tourne à gauche.

	tourne_droite: BOOLEAN
			-- Détermine si le vaisseau tourne à droite.

feature {NONE} -- Constantes

	Bouton_retour_jeu_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du bouton RETOUR.
		once
			Result := [759, 519, 965, 577]
		end

	Bouton_pause_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du bouton PAUSE.
		once
			Result := [759, 419, 965, 477]
		end

	Bouton_jouer_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du bouton JOUER.
		once
			Result := [759, 319, 965, 377]
		end

	Bouton_muet_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du bouton MUET.
		once
			Result := [930, 0, 999, 48]
		end

end
