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

	make (a_fenetre: GAME_RENDERER; a_font: TEXT_FONT; a_color: GAME_COLOR)
			-- Cr�e le compteur de tours.
		do
			fenetre := a_fenetre
			font := a_font
			color := a_color
			create text_surface_total_tours.make ("0", a_font, a_color)
			create text_surface_tours_execute.make ("/3", a_font, a_color)
			create texture_total_tours.make_from_surface (a_fenetre, text_surface_total_tours)
			create texture_tours_execute.make_from_surface (a_fenetre, text_surface_tours_execute)
		end

feature {ANY}

	afficher_tours
			-- Affiche le nombre de tours � l'�cran.
		do
		end

	tours
			-- Incr�mente le nombre de tours
		do
		end

feature {NONE} -- Implementation

	font: TEXT_FONT -- La police d'�criture du texte.

	color: GAME_COLOR -- La couleur du texte.

	texture_total_tours: GAME_TEXTURE -- La texture du "/3" qui signifie le nombre de tours total.

	texture_tours_execute: GAME_TEXTURE -- La texture qui signifie le nombre de tours ex�cut�s.

	fenetre: GAME_RENDERER -- La fen�tre de l'application.

	text_surface_total_tours: TEXT_SURFACE_BLENDED -- Une surface pour le total des tours.

	text_surface_tours_execute: TEXT_SURFACE_BLENDED -- Une surface pour le nombre de tours ex�cut�s.

end
