note
	description: "Classe pour g�rer le jeu qui consiste � faire une course pour enregistrer le meilleur temps."
	author: "�tienne Drolet et Nicolas Bisson"
	date: "2016-04-03"
	revision: "1.1"

class
	JEU_PRINCIPAL

inherit

	MENU
		rename
			make as make_menu
		redefine
			execution
		end

create
	make

feature {NONE} -- Initialization

	make (a_fenetre: FENETRE; a_musique: MUSIQUE; a_son_click: EFFETS_SONORES; a_piste_selectionne: PISTE; a_vaisseau_selectionne: VAISSEAU)
			-- Construit le menu du jeu et ses images.
		do
			piste_selectionne := a_piste_selectionne
			vaisseau_selectionne := a_vaisseau_selectionne
			make_menu (a_fenetre, a_musique, a_son_click)
			if not musique.est_muet then
				doit_afficher_bouton_muet := False
			end
			if musique.est_muet then
				doit_afficher_bouton_muet := True
			end
			create bouton_muet.creer_affichable (fenetre.fenetre.renderer, "bouton_muet_jeu.png")
			create bouton_non_muet.creer_affichable (fenetre.fenetre.renderer, "bouton_non_muet_jeu.png")
			create titre_tours.creer_affichable (fenetre.fenetre.renderer, "titre_tours.png")
			create titre_chrono.creer_affichable (fenetre.fenetre.renderer, "titre_chrono.png")
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			create bouton_pause.creer_affichable (fenetre.fenetre.renderer, "bouton_pause.png")
			create bouton_jouer.creer_affichable (fenetre.fenetre.renderer, "bouton_jouer2.png")
			liste_coordonnees.extend ([760, 520, 966, 576]) -- Coordonn�es du bouton RETOUR.
			liste_coordonnees.extend ([760, 420, 966, 476]) -- Coordonn�es du bouton PAUSE.
			liste_coordonnees.extend ([760, 320, 966, 376]) -- Coordonn�es du bouton JOUER.
			liste_coordonnees.extend ([930, 0, 999, 48])	-- Coordonn�es du bouton MUET.
		end

feature -- Access

	execution
			-- Faire afficher le menu et ses images et lancer la gestion de la souris.
		do
			from
				quitter := False
				retour_jeu_principal := False
			until
				quitter or retour_jeu_principal
			loop
				game_library.clear_all_events
				lancer_fenetre_jeu_principal
				Precursor {MENU}
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- M�thode qui g�re les actions de la souris dans le menu.
		do
			if a_etat_souris.is_left_button_pressed then
				if a_etat_souris.x > 759 and a_etat_souris.x < 917 and a_etat_souris.y > 519 and a_etat_souris.y < 577 then
					-- BOUTON RETOUR
					verifier_si_muet
					curseur.reinitialiser_curseur
					retour_jeu_principal := True
					quitter := False
					game_library.stop
				elseif a_etat_souris.x > 759 and a_etat_souris.x < 917 and a_etat_souris.y > 419 and a_etat_souris.y < 477 then
					-- BOUTON PAUSE
					verifier_si_muet
					curseur.reinitialiser_curseur
						-- STOP LE CHRONO ET LES MOUVEMENTS DU VAISSEAU
				elseif a_etat_souris.x > 759 and a_etat_souris.x < 917 and a_etat_souris.y > 319 and a_etat_souris.y < 377 then
					-- BOUTON JOUER
					verifier_si_muet
					curseur.reinitialiser_curseur
						-- D�MARRE LA PARTIE (LE CHRONO, LE VAISSEAU PEUT BOUGER, REPREND LA PARTIE SI PAUSE IL Y A)
				elseif a_etat_souris.x > 930 and a_etat_souris.x < 999 and a_etat_souris.y > 0 and a_etat_souris.y < 48 then
					doit_afficher_bouton_muet := not doit_afficher_bouton_muet
					lancer_fenetre_jeu_principal
				end
			end
		end

feature {NONE}

	lancer_fenetre_jeu_principal
			-- Dessine les �l�ments de la fen�tre.
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			bouton_retour.afficher (760, 520, fenetre.fenetre.renderer)
			bouton_pause.afficher (760, 420, fenetre.fenetre.renderer)
			bouton_jouer.afficher (760, 320, fenetre.fenetre.renderer)
			titre_tours.afficher (760, 160, fenetre.fenetre.renderer)
			titre_chrono.afficher (760, 40, fenetre.fenetre.renderer)
			if doit_afficher_bouton_muet = True then
				bouton_muet.afficher (935, 0, fenetre.fenetre.renderer)
				musique.mute
			else
				bouton_non_muet.afficher (935, 0, fenetre.fenetre.renderer)
				musique.unmute
			end
			piste_selectionne.piste.afficher (0, 0, fenetre.fenetre.renderer)
			vaisseau_selectionne.vaisseau.afficher (piste_selectionne.x, piste_selectionne.y, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

	definir_depart
		do
		end

feature {ANY} -- Implementation

	bouton_retour: AFFICHABLE

	bouton_pause: AFFICHABLE

	bouton_jouer: AFFICHABLE

	titre_tours: AFFICHABLE

	titre_chrono: AFFICHABLE

	piste_selectionne: PISTE

	vaisseau_selectionne: VAISSEAU

	bouton_muet: AFFICHABLE

	bouton_non_muet: AFFICHABLE

	doit_afficher_bouton_muet: BOOLEAN

end
