note
	description: "Classe qui g�re le nombre de tours."
	author: "Nicolas Bisson et �tienne Drolet"
	date: "2016-05-18"
	revision: "1.4"

class
	TOURS_PISTE

inherit

	TOURS

create
	make

feature {NONE} -- Initialisation

	make (a_fenetre: GAME_RENDERER; a_police: TEXT_FONT; a_couleur: GAME_COLOR)
			-- Cr�e le compteur de tours, sa police (a_police) et sa couleur (a_couleur) dans la fen�tre (a_fen�tre).
		do
			fenetre := a_fenetre
			police := a_police
			couleur := a_couleur
			nombre_tour := 0
			create text_surface_total_tours.make ("/3", a_police, a_couleur)
			create texture_total_tours.make_from_surface (a_fenetre, text_surface_total_tours)
		ensure
			Fenetre_Assigne: fenetre = a_fenetre
			Police_Assigne: police = a_police
			Couleur_Assigne: couleur = a_couleur
			Nombre_Tour_Assigne: nombre_tour = 0
		end

feature {ANY} -- Access

	afficher_tours (a_tour_complete: BOOLEAN)
			-- Affiche le nombre de tours � l'�cran (a_tour_complete).
		local
			l_text_surface_tours_execute: TEXT_SURFACE_BLENDED
			l_texture_tours_execute: GAME_TEXTURE
		do
			create l_text_surface_tours_execute.make (nombre_tour.out, police, couleur)
			create l_texture_tours_execute.make_from_surface (fenetre, l_text_surface_tours_execute)
			fenetre.draw_texture (l_texture_tours_execute, 815, 200)
			fenetre.draw_texture (texture_total_tours, 855, 200)
			tour_complete := False
		ensure
			Tour_Complete_Correct: tour_complete = False
		end

feature {NONE} -- Implementation

	police: TEXT_FONT
			-- La police d'�criture du texte.

	couleur: GAME_COLOR
			-- La couleur du texte.

	texture_total_tours: GAME_TEXTURE
			-- La texture du "/3" qui signifie le nombre de tours total.

	fenetre: GAME_RENDERER
			-- La fen�tre de l'application.

	text_surface_total_tours: TEXT_SURFACE_BLENDED
			-- Une surface pour le total des tours.

end
