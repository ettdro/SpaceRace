note
	description: "Classe qui g�re le menu du classement."
	author: "�tienne Drolet et Nicolas Bisson"
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
			-- Construit le menu du classement (a_fenetre), ses sons (a_musique et a_son_click), ses images ainsi que la liste des coordonn�es des boutons.
		local
			l_ajouter_texture: INTEGER
		do
			Precursor (a_fenetre, a_musique, a_son_click)
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			liste_coordonnees.extend (Bouton_retour_coordonnees)
			liste_coordonnees.extend (Bouton_reinitialiser_coordonnees)
			create font.make ("impact.ttf", 30)
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
				game_library.launch
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- M�thode qui g�re les actions de la souris (a_etat_souris) dans les menus.
		do
			if a_etat_souris.is_left_button_pressed then
				valider_bouton_reinitialiser (a_etat_souris.x, a_etat_souris.y)
				valider_bouton_retour (a_etat_souris.x, a_etat_souris.y)
			end
		end

	valider_bouton_reinitialiser (a_x, a_y: INTEGER)
			-- M�thode v�rifiant si la souris (a_x, a_y) est sur le bouton RETOUR et ex�cute l'action en cons�quence.
		do
			if
				a_x > Bouton_reinitialiser_coordonnees.x1 and
				a_x < Bouton_reinitialiser_coordonnees.x2 and
				a_y > Bouton_reinitialiser_coordonnees.y1 and
				a_y < Bouton_reinitialiser_coordonnees.y2
			then
				verifier_son_click_muet
				curseur.reinitialiser_curseur
				create reseau.make
				reseau.lire_donnees
				reseau.ecouter
				across
					reseau.joueurs as la_liste_joueurs
				loop
					create text_surface_noms.make (la_liste_joueurs.item, font, couleur)
					create texture_noms.make_from_surface (fenetre.fenetre.renderer, text_surface_noms)
					liste_textures_noms.extend (texture_noms)
					lancer_fenetre_classement
				end
			end
		end

	lancer_fenetre_classement
			-- Affiche toutes les images du menu � l'endroit pr�cis�.
		local
			texture_y: INTEGER
		do
			texture_y := 100
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			across
				liste_textures_numeros as la_liste_textures_numeros
			loop
				create text_surface_numeros.make (la_liste_textures_numeros.cursor_index.out + ".", font, couleur)
				create texture_numeros.make_from_surface (fenetre.fenetre.renderer, text_surface_numeros)
				fenetre.fenetre.renderer.draw_texture (texture_numeros, 400, texture_y)
				fenetre.fenetre.renderer.draw_texture (texture_noms, 450, texture_y)
				texture_y := texture_y + 50
			end
			across
				liste_textures_noms as la_liste_textures_noms
			loop
				create text_surface_noms.make (la_liste_textures_noms.item.out, font, couleur)
				create texture_noms.make_from_surface (fenetre.fenetre.renderer, text_surface_noms)
			end
			fenetre.fenetre.renderer.present
		end

feature {ANY} -- Implementation

	bouton_retour: AFFICHABLE
			-- L'image du bouton "RETOUR"

	text_surface_numeros: TEXT_SURFACE_BLENDED
			-- Une surface pour les num�ros.

	texture_numeros: GAME_TEXTURE
			-- La texture pour les num�ros.

	text_surface_noms: TEXT_SURFACE_BLENDED

	texture_noms: GAME_TEXTURE

	liste_textures_numeros: LIST[GAME_TEXTURE]

	liste_textures_noms: LIST[GAME_TEXTURE]

	font: TEXT_FONT
			-- La police d'�criture du texte.

	couleur: GAME_COLOR
			-- La couleur du texte.

	reseau: RESEAU
			-- La connexion � la BD du serveur.


feature {ANY} -- Constantes

	Bouton_reinitialiser_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante repr�sentant les coordonn�es du bouton RETOUR.
		once
			Result := [0, 0, 30, 30]
		end

end
