note
	description: "G�re le menu o� l'on choisi le mod�le du vaisseau avec lequel courser."
	author: "Nicolas Bisson et �tienne Drolet"
	date: "2016-04-03"
	revision: "1.2"

class
	MENU_VAISSEAUX

inherit

	MENU_SELECTION
		rename
			make as make_menu
		redefine
			execution
		end

create
	make

feature {NONE} -- Initialization

	make (a_fenetre: FENETRE; a_musique: EFFET_SONORE; a_son_click: EFFET_SONORE; a_piste_selectionnee: PISTE)
			-- Construit le menu pour choisir le vaisseaux `a_fenetre', ses sons `a_musique' et `a_son_click' et ses images. `a_piste_selectionnee' sert � �tre pass� au menu de jeu.
		do
			make_menu (a_fenetre, a_musique, a_son_click)
			piste_selectionnee := a_piste_selectionnee
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "./images/bouton_retour.png")
			create bouton_suivant.creer_affichable (fenetre.fenetre.renderer, "./images/bouton_suivant.png")
			create titre.creer_affichable (fenetre.fenetre.renderer, "./images/choisir_vaisseau.png")
			create cadre.creer_affichable (fenetre.fenetre.renderer, "./images/bordure_vaisseaux.png")
			create cadre_selectionne.creer_affichable (fenetre.fenetre.renderer, "./images/bordure_vaisseaux_selectionne.png")
			create vaisseau1.creer_affichable (fenetre.fenetre.renderer, "./images/vaisseau1_cadre.png")
			create vaisseau2.creer_affichable (fenetre.fenetre.renderer, "./images/vaisseau2_cadre.png")
			create vaisseau3.creer_affichable (fenetre.fenetre.renderer, "./images/vaisseau3_cadre.png")
			liste_coordonnees.extend (Bouton_retour_coordonnees)
			liste_coordonnees.extend (Bouton_suivant_coordonnees)
			liste_coordonnees.extend (Bouton_cadre_gauche_coordonnees)
			liste_coordonnees.extend (Bouton_cadre_milieu_coordonnees)
			liste_coordonnees.extend (Bouton_cadre_droite_coordonnees)
			liste_coordonnees.start
		ensure
			Piste_Assigne: piste_selectionnee = a_piste_selectionnee
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
				lancer_fenetre_vaisseaux
				Precursor {MENU_SELECTION}
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- M�thode qui g�re les actions de la souris `a_etat_souris' dans le menu.
		do
			if a_etat_souris.is_left_button_pressed then
				valider_bouton_retour (a_etat_souris.x, a_etat_souris.y)
				valider_bouton_suivant (a_etat_souris.x, a_etat_souris.y)
				valider_cadre_gauche (a_etat_souris.x, a_etat_souris.y)
				valider_cadre_milieu (a_etat_souris.x, a_etat_souris.y)
				valider_cadre_droite (a_etat_souris.x, a_etat_souris.y)
			end
		end

	lancer_menu_suivant
			-- Lance le menu du jeu principal.
		do
			lancer_fenetre_jeu_principal
		end

	valider_cadre_gauche(a_x, a_y:INTEGER)
			-- M�thode v�rifiant si les coordonn�es de la souris `a_x' et `a_y' sont �gales aux coordonn�es du bouton
			-- `Bouton_cadre_gauche_coordonnees' et ex�cute l'action en cons�quence.
		do
			if
				a_x > Bouton_cadre_gauche_coordonnees.x1 and
				a_x < Bouton_cadre_gauche_coordonnees.x2 and
				a_y > Bouton_cadre_gauche_coordonnees.y1 and
				a_y < Bouton_cadre_gauche_coordonnees.y2
			then
				create vaisseau_selectionne.make_1 (fenetre)
				verifier_son_click_muet
				liste_coordonnees.go_i_th (3)
				actualiser_cadre (liste_coordonnees.item)
				deselectionner_cadre
			end
		end

	valider_cadre_milieu(a_x, a_y:INTEGER)
			-- M�thode v�rifiant si les coordonn�es de la souris `a_x' et `a_y' sont �gales aux coordonn�es du bouton
			-- `Bouton_cadre_milieu_coordonnees' et ex�cute l'action en cons�quence.
		do
			if
				a_x > Bouton_cadre_milieu_coordonnees.x1 and
				a_x < Bouton_cadre_milieu_coordonnees.x2 and
				a_y > Bouton_cadre_milieu_coordonnees.y1 and
				a_y < Bouton_cadre_milieu_coordonnees.y2
			then
				create vaisseau_selectionne.make_2 (fenetre)
				verifier_son_click_muet
				liste_coordonnees.go_i_th (4)
				actualiser_cadre (liste_coordonnees.item)
				deselectionner_cadre
			end
		end

	valider_cadre_droite(a_x, a_y:INTEGER)
			-- M�thode v�rifiant si les coordonn�es de la souris `a_x' et `a_y' sont �gales aux coordonn�es du bouton
			-- `Bouton_cadre_droite_coordonnees' et ex�cute l'action en cons�quence.
		do
			if
				a_x > Bouton_cadre_droite_coordonnees.x1 and
				a_x < Bouton_cadre_droite_coordonnees.x2 and
				a_y > Bouton_cadre_droite_coordonnees.y1 and
				a_y < Bouton_cadre_droite_coordonnees.y2
			then
				create vaisseau_selectionne.make_3 (fenetre)
				verifier_son_click_muet
				liste_coordonnees.go_i_th (5)
				actualiser_cadre (liste_coordonnees.item)
				deselectionner_cadre
			end
		end

feature {NONE} -- Affichage

	actualiser_cadre (a_liste_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER])
			-- Affiche le cadre en jaune `a_liste_coordonnes' puisqu'il est celui s�lectionn� et affiche le bouton SUIVANT.
		require
			Liste_Vide: not a_liste_coordonnees.is_empty
			Position_X1_Valide: a_liste_coordonnees.x1 >= 0 and a_liste_coordonnees.x1 <= 1000
			Position_Y1_Valide: a_liste_coordonnees.y1 >= 0 and a_liste_coordonnees.y1 <= 600
			Position_X2_Valide: a_liste_coordonnees.x2 >= 0 and a_liste_coordonnees.x2 <= 1000
			Position_Y2_Valide: a_liste_coordonnees.y2 >= 0 and a_liste_coordonnees.y2 <= 600
		do
			cadre_selectionne.afficher (a_liste_coordonnees.x1, a_liste_coordonnees.y1, fenetre.fenetre.renderer)
			bouton_suivant.afficher (760, 520, fenetre.fenetre.renderer)
			suivant_est_visible := True
			fenetre.fenetre.renderer.present
		ensure
			Bouton_Suivant_Affiche: suivant_est_visible
		end

	deselectionner_cadre
			-- R�affiche le cadre mauve puisque ce cadre n'est pas s�lectionn�.
		do
			across
				liste_coordonnees as la_liste_coordonnees
			loop
				if liste_coordonnees.readable then
					cadre.afficher (liste_coordonnees.item.x1, liste_coordonnees.item.y1, fenetre.fenetre.renderer)
					liste_coordonnees.move (1)
				end
			end
		end

	lancer_fenetre_vaisseaux
			-- Dessine les �l�ments de la fen�tre.
		do
			suivant_est_visible := False
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			titre.afficher (180, 30, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			cadre.afficher (200, 200, fenetre.fenetre.renderer)
			vaisseau1.afficher (240, 230, fenetre.fenetre.renderer)
			cadre.afficher (430, 200, fenetre.fenetre.renderer)
			vaisseau2.afficher (470, 230, fenetre.fenetre.renderer)
			cadre.afficher (660, 200, fenetre.fenetre.renderer)
			vaisseau3.afficher (700, 230, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
			ensure
				Suivant_Visible: suivant_est_visible = False
		end

	lancer_fenetre_jeu_principal
			-- Lance le menu du jeu principal
		require
			Vaisseau_Selectionne: attached vaisseau_selectionne
		local
			l_menu_jeu_principal: JEU_PRINCIPAL
		do
			if attached vaisseau_selectionne as la_vaisseau_selectionne then
				create l_menu_jeu_principal.make (fenetre, musique, son_click, piste_selectionnee, la_vaisseau_selectionne)
				l_menu_jeu_principal.execution
				quitter := l_menu_jeu_principal.quitter
				sortir_menu := l_menu_jeu_principal.sortir_menu
			end
		end

feature {ANY} -- Implementation

	titre: AFFICHABLE
			-- L'image du titre du menu.

	vaisseau1: AFFICHABLE
			-- L'image du vaisseau 1.

	vaisseau2: AFFICHABLE
			-- L'image du vaisseau 2.

	vaisseau3: AFFICHABLE
			-- L'image du vaisseau 3.

	piste_selectionnee: PISTE
			-- La piste qui a �t� choisie.

	vaisseau_selectionne: detachable VAISSEAU
			-- Le vaisseau qui est choisi au final. "detachable" parce qu'au d�part, il n'y a pas de vaisseau.

	cadre: AFFICHABLE
			-- L'image d'un cadre non-s�lectionn�.

	bouton_retour: AFFICHABLE
			-- L'image du bouton "RETOUR"

	bouton_suivant: AFFICHABLE
			-- L'image du bouton "SUIVANT"

	cadre_selectionne: AFFICHABLE
			-- L'image d'un cadre s�lectionn�.

feature {NONE}  -- Constantes

	Bouton_cadre_gauche_coordonnees:TUPLE[x1, y1, x2, y2:INTEGER]
			-- Constante repr�sentant les coordonn�es du cadre de gauche.
		once
			Result := [200, 200, 380, 380]
		end

	Bouton_cadre_milieu_coordonnees:TUPLE[x1, y1, x2, y2:INTEGER]
			-- Constante repr�sentant les coordonn�es du cadre du milieu.
		once
			Result := [430, 200, 610, 380]
		end

	Bouton_cadre_droite_coordonnees:TUPLE[x1, y1, x2, y2:INTEGER]
			-- Constante repr�sentant les coordonn�es du cadre de droite.
		once
			Result := [660, 200, 840, 380]
		end

end
