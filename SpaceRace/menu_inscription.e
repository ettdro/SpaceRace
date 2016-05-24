note
	description: "Gère le menu qui inscrit le score dans la base de données."
	author: "Nicolas Bisson et Étienne Drolet"
	date: "2016-05-21"
	revision: "1.5"

class
	MENU_INSCRIPTION

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

	make (a_fenetre: FENETRE; a_musique: EFFET_SONORE; a_son_click: EFFET_SONORE; a_chronometre: TEMPS_CHRONOMETRE)
			-- Construit le menu d'inscription (a_fenetre), ses sons (a_musique et a_son_click), ses images ainsi que la liste des coordonnées des boutons.
		do
			make_menu (a_fenetre, a_musique, a_son_click)
			chronometre := a_chronometre
			create bouton_suivant.creer_affichable (fenetre.fenetre.renderer, "bouton_suivant.png")
			create titre_inscription.creer_affichable (fenetre.fenetre.renderer, "inscription2.png")
			create font.make ("impact.ttf", 35)
			font.open
			create couleur.make_rgb (255, 255, 255)
			create reseau.make
			create text_surface_titre_temps.make ("Temps :", font, couleur)
			create text_surface_temps.make ((chronometre.temps_minutes).out + ":" + (chronometre.temps_secondes).out, font, couleur)
			create text_surface_titre_nom.make ("Nom : ", font, couleur)
			create text_surface_nom.make (" ", font, couleur)
			create texture_titre_temps.make_from_surface (fenetre.fenetre.renderer, text_surface_titre_temps)
			create texture_temps.make_from_surface (fenetre.fenetre.renderer, text_surface_temps)
			create texture_titre_nom.make_from_surface (fenetre.fenetre.renderer, text_surface_titre_nom)
			create texture_nom.make_from_surface (fenetre.fenetre.renderer, text_surface_nom)
			liste_coordonnees.extend (Bouton_suivant_coordonnees)
		ensure
			Chronometre_Assigne: chronometre = a_chronometre
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
				lancer_fenetre_inscription
				Precursor {MENU}
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions (a_etat_souris) de la souris dans le menu.
		do
			if a_etat_souris.is_left_button_pressed then
				valider_bouton_suivant (a_etat_souris.x, a_etat_souris.y)
			end
		end

	valider_bouton_suivant (a_x, a_y: INTEGER)
			-- Méthode vérifiant si la souris (a_x, a_y) est sur le bouton SUIVANT et exécute l'action en conséquence.
		local
			l_nom_string: STRING
			l_temps_string: STRING
		do
			if
				a_x > Bouton_suivant_coordonnees.x1 and
				a_x < Bouton_suivant_coordonnees.x2 and
				a_y > Bouton_suivant_coordonnees.y1 and
				a_y < Bouton_suivant_coordonnees.y2
			then
				verifier_son_click_muet
				curseur.reinitialiser_curseur
				l_nom_string := text_surface_nom.text.as_string_32
				l_temps_string := text_surface_temps.text.as_string_32
				reseau.inserer_record (l_nom_string, l_temps_string)
				lancer_fenetre_classement
				sortir_menu := True
			end
		end

feature {ANY} -- Affichage

	lancer_fenetre_inscription
			-- Affiche toutes les images du menu à l'endroit précisé.
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			titre_inscription.afficher (310, 70, fenetre.fenetre.renderer)
			bouton_suivant.afficher (760, 520, fenetre.fenetre.renderer)
			afficher_texte
			fenetre.fenetre.renderer.present
		end

	lancer_fenetre_classement
			-- Lance le classement du jeu.
		local
			l_menu_classement: MENU_CLASSEMENT
		do
			create l_menu_classement.make (fenetre, musique, son_click)
			l_menu_classement.execution
			quitter := l_menu_classement.quitter
		end

	afficher_texte
			-- Affiche le texte à l'écran
		do
			fenetre.fenetre.renderer.draw_texture (texture_titre_temps, 150, 225)
			if chronometre.temps_secondes < 10 then
				create text_surface_temps.make ((chronometre.temps_minutes).out + ":" + "0" + (chronometre.temps_secondes).out, font, couleur)
				create texture_temps.make_from_surface (fenetre.fenetre.renderer, text_surface_temps)
			end
			fenetre.fenetre.renderer.draw_texture (texture_temps, 275, 225)
			fenetre.fenetre.renderer.draw_texture (texture_titre_nom, 150, 325)
			fenetre.fenetre.renderer.draw_texture (texture_nom, 275, 325)
		end

feature {NONE} -- Implementation

	reseau: RESEAU
			-- La connexion à la BD du serveur.

	bouton_suivant: AFFICHABLE
			-- L'image du bouton "RETOUR".

	titre_inscription: AFFICHABLE
			-- L'image du titre "INSCRIPTION".

	font: TEXT_FONT
			-- Police d'écriture du texte.

	couleur: GAME_COLOR
			-- Couleur de l'écriture.

	chronometre: TEMPS_CHRONOMETRE
			-- Le chronomètre du jeu.

	text_surface_titre_temps: TEXT_SURFACE_BLENDED
			-- Une surface pour le titre "TEMPS".

	text_surface_temps: TEXT_SURFACE_BLENDED
			-- Une surface pour le temps réalisés.

	text_surface_titre_nom: TEXT_SURFACE_BLENDED
			-- Une surface pour le titre "NOM".

	text_surface_nom: TEXT_SURFACE_BLENDED
			-- Une surface pour le nom du joueur.

	texture_titre_temps: GAME_TEXTURE
			-- Une texture pour le titre "TEMPS".

	texture_temps: GAME_TEXTURE
			-- Une texture pour le temps réalisés.

	texture_titre_nom: GAME_TEXTURE
			-- Une texture pour le titre "NOM".

	texture_nom: GAME_TEXTURE
			-- Une texture pour le nom du joueur.

feature {ANY} -- Constantes

	Bouton_suivant_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante représentant les coordonnées du bouton SUIVANT.
		once
			Result := [759, 519, 917, 577]
		end

end
