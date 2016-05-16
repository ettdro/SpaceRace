note
	description: "Classe qui lance la création de toutes les images du jeux."
	author: "Nicolas Bisson et Étienne Drolet"
	date: "2016-05-15"
	revision: "1.4"

class
	AFFICHABLE

inherit

	IMAGES

create
	creer_affichable

feature {NONE} -- Initialization

	creer_affichable (a_renderer: GAME_RENDERER; a_nom_fichier: STRING)
			-- Méthode qui lance la création du fichier affichable (a_nom_fichier) dans la fenêtre (a_renderer).
		require
			Bon_Format_Image: a_nom_fichier.ends_with (".png")
			Bonne_Taille_String: a_nom_fichier.count > 4
		do
			creer_image (a_renderer, a_nom_fichier)
		end

feature {ANY} -- Access

	afficher (a_pos_x, a_pos_y: INTEGER; a_renderer: GAME_RENDERER)
			-- Affiche l'image aux coordonnées a_pos_x et a_pos_y dans la fenêtre (a_renderer).
		do
			a_renderer.draw_texture (Current, a_pos_x, a_pos_y)
		end

	afficher_rotation (a_angle_rotation: REAL_64; a_pos_x, a_pos_y: INTEGER; a_renderer: GAME_RENDERER)
			-- Affiche l'image aux coordonnées a_pos_x et a_pos_y dans la fenêtre (a_renderer) selon l'angle de rotation (a_angle_rotation).
		do
			a_renderer.draw_sub_texture_with_scale_rotation_and_mirror (Current, 0, 0, width, height, a_pos_x, a_pos_y, width, height, width // 2, height // 2, a_angle_rotation, False, False)
		end

end
