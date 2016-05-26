note
	description: "Classe qui gère le menu du classement."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-05-15"
	revision: "1.4"

class
	MENU_CLASSEMENT

inherit
	MENU
		redefine
			make,
			execution
		end

create
	make

feature {NONE} -- Initialization

	make (a_fenetre: FENETRE; a_musique: EFFET_SONORE; a_son_click: EFFET_SONORE)
			-- Construit le menu du classement (a_fenetre), ses sons (a_musique et a_son_click), ses images ainsi que la liste des coordonnées des boutons.
		local
			l_ajouter_texture: INTEGER
		do
			Precursor (a_fenetre, a_musique, a_son_click)
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "./images/bouton_retour.png")
			create image_classement.creer_affichable (fenetre.fenetre.renderer, "./images/classement.png")
			liste_coordonnees.extend (Bouton_retour_coordonnees)
			create font.make ("./font/impact.ttf", 30)
			font.open
			create couleur.make_rgb (255, 102, 0)
			create {LINKED_LIST[GAME_TEXTURE]}liste_textures_numeros.make
			create {LINKED_LIST[GAME_TEXTURE]}liste_textures_noms.make
			create text_surface_numeros.make ("1. ", font, couleur)
			create text_surface_noms.make ("NOM - 0:00", font, couleur)
			create texture_numeros.make_from_surface (a_fenetre.fenetre.renderer, text_surface_numeros)
			create texture_noms.make_from_surface (a_fenetre.fenetre.renderer, text_surface_noms)
			create reseau.make
			from
			until
				l_ajouter_texture = 5
			loop
				liste_textures_numeros.extend (texture_numeros)
				l_ajouter_texture := l_ajouter_texture + 1
			end
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
				lancer_fenetre_classement
				Precursor {MENU}
				if not sortir_menu then
					game_library.launch
				end
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris (a_etat_souris) dans les menus.
		do
			if a_etat_souris.is_left_button_pressed then
				valider_bouton_retour (a_etat_souris.x, a_etat_souris.y)
			end
		end

	creer_texture_noms
			-- Crée les textures de noms en allant chercher les données sur le réseau.
		do
			create reseau.make
			reseau.lire_donnees
			reseau.ecouter
			if reseau.a_erreur then
				sortir_menu := True
				io.put_string ("Acces au serveur impossible.%N")
				game_library.stop
				musique.jouer (True)
			else
				across
					reseau.joueurs as la_liste_joueurs
				loop
					if la_liste_joueurs.cursor_index < 6 then
						create text_surface_noms.make (la_liste_joueurs.item, font, couleur)
						create texture_noms.make_from_surface (fenetre.fenetre.renderer, text_surface_noms)
						liste_textures_noms.extend (texture_noms)
					end
				end
			end
		end

feature {ANY} -- Affichage

	lancer_fenetre_classement
			-- Affiche toutes les images du menu à l'endroit précisé.
		local
			texture_y: INTEGER
		do
			creer_texture_noms
			texture_y := 150
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			image_classement.afficher (310, 70, fenetre.fenetre.renderer)
			across
				liste_textures_numeros as la_liste_textures_numeros
			loop
				create text_surface_numeros.make (la_liste_textures_numeros.cursor_index.out + ".", font, couleur)
				create texture_numeros.make_from_surface (fenetre.fenetre.renderer, text_surface_numeros)
				fenetre.fenetre.renderer.draw_texture (texture_numeros, 400, texture_y)
				texture_y := texture_y + 50
			end
			texture_y := 150
			across
				liste_textures_noms as la_liste_textures_noms
			loop
				fenetre.fenetre.renderer.draw_texture (la_liste_textures_noms.item, 430, texture_y)
				texture_y := texture_y + 50
			end
			fenetre.fenetre.renderer.present
		end

feature {ANY} -- Implementation

	bouton_retour: AFFICHABLE
			-- L'image du bouton "RETOUR"

	text_surface_numeros: TEXT_SURFACE_BLENDED
			-- Une surface pour les numéros.

	texture_numeros: GAME_TEXTURE
			-- La texture pour les numéros.

	text_surface_noms: TEXT_SURFACE_BLENDED
			-- Texture pour les numéros.

	texture_noms: GAME_TEXTURE
			-- Texture pour les noms.

	liste_textures_numeros: LIST[GAME_TEXTURE]
			-- Liste de textures pour les noms.

	liste_textures_noms: LIST[GAME_TEXTURE]
			-- Liste de textures pour les noms.

	font: TEXT_FONT
			-- La police d'écriture du texte.

	couleur: GAME_COLOR
			-- La couleur du texte.

	reseau: RESEAU
			-- La connexion à la BD du serveur.

	image_classement: AFFICHABLE
			-- L'image représentant le titre du classement.

end
