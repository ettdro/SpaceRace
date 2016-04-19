note
	description: "Classe qui va g�rer le nombre de tours."
	author: "Nicolas Bisson et �tienne Drolet"
	date: "2016-05-18"
	revision: "1.0"

class
	TOURS

create
	make

feature {NONE} -- Initialisation

	make (a_fenetre: GAME_RENDERER; a_police: TEXT_FONT; a_couleur: GAME_COLOR)
			-- Cr�e le compteur de tours.
		do
			fenetre := a_fenetre
			police := a_police
			couleur := a_couleur
			create text_surface_total_tours.make ("0", a_police, a_couleur)
			create text_surface_tours_execute.make ("/3", a_police, a_couleur)
			create texture_total_tours.make_from_surface (a_fenetre, text_surface_total_tours)
			create texture_tours_execute.make_from_surface (a_fenetre, text_surface_tours_execute)
		end

feature {ANY}

	afficher_tours
			-- Affiche le nombre de tours � l'�cran.
		local
			nombre_tour: INTEGER
		do
			if tour_complete then
				nombre_tour := nombre_tour + 1
				create text_surface_total_tours.make (nombre_tour.to_hex_string, police, couleur)
			end
			create texture_tours_execute.make_from_surface (fenetre, text_surface_tours_execute)
			fenetre.draw_texture (texture_total_tours, 815, 200)
			fenetre.draw_texture (texture_tours_execute, 855, 200)
		end

	tours
			-- Incr�mente le nombre de tours
		do
		end

feature {NONE} -- Implementation

	police: TEXT_FONT -- La police d'�criture du texte.

	couleur: GAME_COLOR -- La couleur du texte.

	texture_total_tours: GAME_TEXTURE -- La texture du "/3" qui signifie le nombre de tours total.

	texture_tours_execute: GAME_TEXTURE -- La texture qui signifie le nombre de tours ex�cut�s.

	fenetre: GAME_RENDERER -- La fen�tre de l'application.

	text_surface_total_tours: TEXT_SURFACE_BLENDED -- Une surface pour le total des tours.

	text_surface_tours_execute: TEXT_SURFACE_BLENDED -- Une surface pour le nombre de tours ex�cut�s.

	tour_complete: BOOLEAN

end
