note
	description: "Classe qui gère le chrono et les tours."
	author: "Nicolas Bisson & Étienne Drolet"
	date: "2016-04-03"
	revision: "1.1"

class
	TEMPS

create
	make

feature {NONE} -- Initialization

	make (a_fenetre: GAME_RENDERER; a_font: TEXT_FONT; a_color: GAME_COLOR; a_debut_millisecond: NATURAL)
			-- Crée le chronomètre.
		do
			temps_debut_milliseconde := a_debut_millisecond
			temps_milliseconde := 0
			fenetre := a_fenetre
			font := a_font
			color := a_color
			create liste_texte_str_secondes.make (0)
			create liste_texte_str_minutes.make (0)
			liste_texte_str_secondes.extend ("0")
			liste_texte_str_minutes.extend ("0")
			liste_texte_str_secondes.start
			liste_texte_str_minutes.start
			create text_surface_minutes.make ("00", a_font, a_color)
			create text_surface_points.make (":", a_font, a_color)
			create text_surface_secondes.make ("00", a_font, a_color)
			create texture_minutes.make_from_surface (a_fenetre, text_surface_minutes)
			create texture_points.make_from_surface (a_fenetre, text_surface_points)
			create texture_secondes.make_from_surface (a_fenetre, text_surface_secondes)
		end

feature {ANY}

	afficher_temps
			-- Affiche le chronomètre à l'écran.
		do
			if temps_milliseconde < 10000 then
				create text_surface_secondes.make ("0" + ((temps_milliseconde // 1000) \\ 60).out, font, color)
			else
				create text_surface_secondes.make (((temps_milliseconde // 1000) \\ 60).out, font, color)
			end
			if temps_milliseconde < 600000 then
				create text_surface_minutes.make ("0" + (temps_milliseconde // 60000).out, font, color)
			else
				create text_surface_minutes.make ((temps_milliseconde // 60000).out, font, color)
			end
			create texture_secondes.make_from_surface (fenetre, text_surface_secondes)
			create texture_minutes.make_from_surface (fenetre, text_surface_minutes)
			fenetre.draw_texture (texture_minutes, 780, 75)
			fenetre.draw_texture (texture_points, 865, 75)
			fenetre.draw_texture (texture_secondes, 885, 75)
		end

	chronometre (a_timestamp: NATURAL)
			-- Incrémente le temps du chronomètre.
		do
			temps_milliseconde := temps_milliseconde + a_timestamp - temps_debut_milliseconde
			temps_debut_milliseconde := a_timestamp
				--			if temps_milliseconde < 10 then
				--				temps_milliseconde := temps_milliseconde + a_timestamp - temps_debut_milliseconde
				--			end
				--			if temps_secondes = 60 then
				--				temps_secondes := 0
				--				temps_minutes := temps_minutes + 1
				--				liste_texte_str_secondes.put (temps_secondes.out)
				--				liste_texte_str_minutes.put (temps_minutes.out)
				--			end
		end

feature {NONE} -- Implementation

	temps_debut_milliseconde: NATURAL -- Le temps depuis la création du chronomètre.

	temps_milliseconde: NATURAL -- Le temps en millisecondes.

	font: TEXT_FONT -- La police d'écriture du texte.

	color: GAME_COLOR -- La couleur du texte.

	texture_minutes: GAME_TEXTURE -- La texture qui signifie le nombre de minutes.

	texture_points: GAME_TEXTURE -- La texture qui signifie les points.

	texture_secondes: GAME_TEXTURE -- La texture qui signifie le nombre de secondes.

	fenetre: GAME_RENDERER -- La fenêtre de l'application.

	text_surface_minutes: TEXT_SURFACE_BLENDED -- Une surface pour le nombre de minutes.

	text_surface_points: TEXT_SURFACE_BLENDED -- Une surface pour les points.

	text_surface_secondes: TEXT_SURFACE_BLENDED -- Une surface pour le nombre de secondes.

end
