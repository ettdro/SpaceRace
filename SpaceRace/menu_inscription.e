note
	description: "G�re le menu qui inscrit le score dans la base de donn�es."
	author: "Nicolas Bisson et �tienne Drolet"
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
			-- Construit le menu d'inscription `a_fenetre', ses sons (`a_musique' et `a_son_click'), ses images ainsi que la liste des coordonn�es des boutons.
		local
			l_text_surface_titre_temps: TEXT_SURFACE_BLENDED
			l_text_surface_titre_nom: TEXT_SURFACE_BLENDED
		do
			make_menu (a_fenetre, a_musique, a_son_click)
			chronometre := a_chronometre
			create bouton_suivant.creer_affichable (fenetre.fenetre.renderer, "./images/bouton_suivant.png")
			create titre_inscription.creer_affichable (fenetre.fenetre.renderer, "./images/inscription.png")
			create font.make ("./font/impact.ttf", 35)
			font.open
			create couleur.make_rgb (255, 255, 255)
			create couleur_temps_nom.make_rgb (51, 204, 51)
			create reseau.make
			create {LINKED_LIST [TUPLE [lettre: STRING_32]]} nom.make
			create l_text_surface_titre_temps.make ("Temps :", font, couleur)
			create text_surface_temps.make ((chronometre.temps_minutes).out + ":" + (chronometre.temps_secondes).out, font, couleur_temps_nom)
			create l_text_surface_titre_nom.make ("Nom : ", font, couleur)
			create text_surface_nom.make ("�crivez votre nom!", font, couleur)
			create texture_titre_temps.make_from_surface (fenetre.fenetre.renderer, l_text_surface_titre_temps)
			create texture_temps.make_from_surface (fenetre.fenetre.renderer, text_surface_temps)
			create texture_titre_nom.make_from_surface (fenetre.fenetre.renderer, l_text_surface_titre_nom)
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
				fenetre.fenetre.start_text_input
				fenetre.fenetre.text_input_actions.extend (agent ecriture (?, ?))
				game_library.iteration_actions.extend (agent sur_iteration (?))
				fenetre.fenetre.key_pressed_actions.extend (agent effacer (?, ?))
				game_library.launch
				nom.wipe_out
			end
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- M�thode qui g�re les actions `a_etat_souris' de la souris dans le menu.
		do
			if a_etat_souris.is_left_button_pressed then
				valider_bouton_suivant (a_etat_souris.x, a_etat_souris.y)
			end
		end

	valider_bouton_suivant (a_x, a_y: INTEGER)
			-- M�thode v�rifiant si les coordonn�es de la souris `a_x' et `a_y' sont �gales aux coordonn�es du bouton SUIVANT
			-- et ex�cute l'action en cons�quence.
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
			end
		end

	effacer (a_temps: NATURAL_32; a_etat_clavier: GAME_KEY_STATE)
			-- Efface la derni�re lettre du nom entr�.
		do
			if a_etat_clavier.is_backspace and not nom.last.lettre.is_empty then
				nom.last.lettre := nom.last.lettre.substring (1, nom.last.lettre.count - 1)
			end
		end

	ecriture (a_temps: NATURAL_32; a_lettre: STRING_32)
			-- Prend la lettre �crite `a_lettre' et la mets dans une liste.
		do
			if not nom.is_empty then
				if nom.last.lettre.count < 15 then
					nom.last.lettre := nom.last.lettre + a_lettre
					nom.extend (nom.last.lettre)
				end
			else
				nom.extend (a_lettre)
			end
		end

	sur_iteration (a_temps: NATURAL_32)
			-- Boucle pour recr�er une texture avec la nouvelle lettre ajout�e.
		do
			across
				nom as la_nom
			loop
				create text_surface_nom.make (la_nom.item.lettre, font, couleur_temps_nom)
				create texture_nom.make_from_surface (fenetre.fenetre.renderer, text_surface_nom)
			end
			lancer_fenetre_inscription
		end

feature {ANY} -- Affichage

	lancer_fenetre_inscription
			-- Affiche toutes les images du menu � l'endroit pr�cis�.
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			titre_inscription.afficher (310, 70, fenetre.fenetre.renderer)
			bouton_suivant.afficher (760, 520, fenetre.fenetre.renderer)
			afficher_texte
			fenetre.fenetre.renderer.present
		end

	lancer_fenetre_classement
			-- Lance le menu du classement du jeu.
		local
			l_menu_classement: MENU_CLASSEMENT
		do
			create l_menu_classement.make (fenetre, musique, son_click)
			l_menu_classement.execution
			quitter := l_menu_classement.quitter
			sortir_menu := l_menu_classement.sortir_menu
		end

	afficher_texte
			-- Affiche les textures � l'�cran.
		do
			fenetre.fenetre.renderer.draw_texture (texture_titre_temps, 150, 225)
			if chronometre.temps_secondes < 10 then
				create text_surface_temps.make ((chronometre.temps_minutes).out + ":" + "0" + (chronometre.temps_secondes).out, font, couleur_temps_nom)
				create texture_temps.make_from_surface (fenetre.fenetre.renderer, text_surface_temps)
			end
			fenetre.fenetre.renderer.draw_texture (texture_temps, 275, 225)
			fenetre.fenetre.renderer.draw_texture (texture_titre_nom, 150, 325)
			fenetre.fenetre.renderer.draw_texture (texture_nom, 250, 325)
			fenetre.fenetre.renderer.present
		end

feature {NONE} -- Implementation

	reseau: RESEAU
			-- La connexion � la BD du serveur.

	bouton_suivant: AFFICHABLE
			-- L'image du bouton "RETOUR".

	titre_inscription: AFFICHABLE
			-- L'image du titre "INSCRIPTION".

	font: TEXT_FONT
			-- Police d'�criture du texte.

	couleur: GAME_COLOR
			-- Couleur de l'�criture des titres.

	couleur_temps_nom: GAME_COLOR
			-- Couleur de l'�criture du temps et du nom du joueur.

	chronometre: TEMPS_CHRONOMETRE
			-- Le chronom�tre du jeu.

	text_surface_nom: TEXT_SURFACE_BLENDED
			-- Une surface pour le nom.

	text_surface_temps: TEXT_SURFACE_BLENDED
			-- Une surface pour le temps.

	texture_titre_temps: GAME_TEXTURE
			-- Une texture pour le titre "TEMPS".

	texture_temps: GAME_TEXTURE
			-- Une texture pour le temps r�alis�.

	texture_titre_nom: GAME_TEXTURE
			-- Une texture pour le titre "NOM".

	texture_nom: GAME_TEXTURE
			-- Une texture pour le nom du joueur.

	nom: LINKED_LIST [TUPLE [lettre: STRING_32]]
			-- La liste qui contient les lettres du nom.

feature {ANY} -- Constantes

	Bouton_suivant_coordonnees: TUPLE [x1, y1, x2, y2: INTEGER]
			-- Constante repr�sentant les coordonn�es du bouton SUIVANT exclusivement � la classe pr�sente.
		once
			Result := [759, 519, 965, 577]
		end

end
