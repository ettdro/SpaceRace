note
	description: "Classe qui gére le menu des options de l'application."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

class
	MENU_OPTIONS

inherit

	MENU
		redefine
			execution, make
		end

create
	make

feature -- Initialization

	make (a_fenetre: FENETRE; a_musique: MUSIQUE; a_son_click: EFFETS_SONORES)
			-- Construit le menu des options, ses images ainsi que la liste des coordonnées des boutons.
		do
			Precursor(a_fenetre, a_musique, a_son_click)
			if not musique.est_muet then
				doit_afficher_bouton_muet := False
			end
			if musique.est_muet then
				doit_afficher_bouton_muet := True
			end
			create bouton_muet.creer_affichable (fenetre.fenetre.renderer, "bouton_muet.png")
			create bouton_non_muet.creer_affichable (fenetre.fenetre.renderer, "bouton_non_muet.png")
			create bouton_credits.creer_affichable (fenetre.fenetre.renderer, "bouton_credits.png")
			create bouton_comment_jouer.creer_affichable (fenetre.fenetre.renderer, "bouton_comment_jouer.png")
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			create fond.make_image (fenetre.fenetre.renderer)
			liste_coordonnees.extend ([400,100,606,156])	-- Coordonnées des boutons MUET/NON_MUET.
			liste_coordonnees.extend ([400,200,606,256])	-- Coordonnées du bouton CREDITS.
			liste_coordonnees.extend ([310,300,695,356])	-- Coordonnées du bouton COMMENT_JOUER.
			liste_coordonnees.extend ([30,520,236,576])		-- Coordonnées du bouton RETOUR.
		end

feature -- Access

	execution
			-- Méthode d'exécution de MENU_OPTIONS qui génère la fenêtre d'options.
		do
			from
				quitter := False
				retour_options := False
			until
				quitter or retour_options
			loop
				game_library.clear_all_events
				lancer_fenetre_options
				Precursor {MENU}
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris dans le menu.
		do
			if a_etat_souris.is_left_button_pressed then
				if a_etat_souris.x > 399 and a_etat_souris.x < 607 and a_etat_souris.y > 99 and a_etat_souris.y < 157 then
					doit_afficher_bouton_muet := not doit_afficher_bouton_muet
					lancer_fenetre_options
				elseif a_etat_souris.x > 399 and a_etat_souris.x < 607 and a_etat_souris.y > 199 and a_etat_souris.y < 257 then
					if not musique.est_muet then
						son_click.jouer (False)
					end
					curseur.reinitialiser_curseur
					lancer_fenetre_credits
				elseif a_etat_souris.x > 309 and a_etat_souris.x < 695 and a_etat_souris.y > 299 and a_etat_souris.y < 357 then
					if not musique.est_muet then
						son_click.jouer (False)
					end
					curseur.reinitialiser_curseur
					lancer_fenetre_comment_jouer
				elseif a_etat_souris.x > 29 and a_etat_souris.x < 237 and a_etat_souris.y > 519 and a_etat_souris.y < 577 then
					if not musique.est_muet then
						son_click.jouer (False)
					end
					curseur.reinitialiser_curseur
					retour_options := True
					quitter := False
					game_library.stop
				end
			end
		end

	lancer_fenetre_options
			-- Affiche toutes les images du menu à l'endroit précisé.
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			if doit_afficher_bouton_muet = True then
				bouton_muet.afficher (400, 100, fenetre.fenetre.renderer)
				musique.mute
			else
				bouton_non_muet.afficher (400, 100, fenetre.fenetre.renderer)
				musique.unmute
			end
			bouton_credits.afficher (400, 200, fenetre.fenetre.renderer)
			bouton_comment_jouer.afficher (310, 300, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

	lancer_fenetre_credits
			-- Lance le menu des crédits.
		local
			l_menu_credits: MENU_CREDITS
		do
			create l_menu_credits.make (fenetre, musique, son_click)
			l_menu_credits.execution
			quitter := l_menu_credits.quitter
		end

	lancer_fenetre_comment_jouer
			-- Lance le menu qui explique comment jouer.
		local
			l_menu_comment_jouer: MENU_COMMENT_JOUER
		do
			create l_menu_comment_jouer.make (fenetre, musique, son_click)
			l_menu_comment_jouer.execution
			quitter := l_menu_comment_jouer.quitter
		end

feature {ANY} -- Implementation

	fond: FOND_ECRAN

	doit_afficher_bouton_muet: BOOLEAN

	bouton_muet: AFFICHABLE

	bouton_non_muet: AFFICHABLE

	bouton_credits: AFFICHABLE

	bouton_comment_jouer: AFFICHABLE

	bouton_retour: AFFICHABLE

end
