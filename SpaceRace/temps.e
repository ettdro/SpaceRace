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

	make (a_fenetre: GAME_RENDERER; a_font: TEXT_FONT; a_color: GAME_COLOR)
			-- Initialization for `Current'.
		do
			fenetre := a_fenetre
			font := a_font
			color := a_color
			create liste_texte_str.make(1)
			liste_texte_str.extend ("0")
			liste_texte_str.start
			create text_surface_minutes.make (liste_texte_str.item, a_font, a_color)
			create text_surface_points.make (":", a_font, a_color)
			create text_surface_secondes.make ("00", a_font, a_color)
			create texture_minutes.make_from_surface (a_fenetre, text_surface_minutes)
			create texture_points.make_from_surface (a_fenetre, text_surface_points)
			create texture_secondes.make_from_surface (a_fenetre, text_surface_secondes)
		end


feature {ANY}

	afficher_temps_initial
		do
			chronometre
			fenetre.draw_texture (texture_minutes, 800, 75)
			fenetre.draw_texture (texture_points, 845, 75)
			fenetre.draw_texture (texture_secondes, 865, 75)
--			fenetre.set_drawing_color (create {GAME_COLOR}.make_rgb (255, 255, 0))
--			fenetre.draw_rectangle (0, 0, texture.width, texture.height)
			fenetre.present
		end

	chronometre
		do
			temps := temps + 1
			liste_texte_str.put (temps.out)
			create text_surface_secondes.make (liste_texte_str.item, font, color)
			create texture_secondes.make_from_surface (fenetre, text_surface_secondes)
		end

	temps: INTEGER

	font: TEXT_FONT

	color: GAME_COLOR

	liste_texte_str: ARRAYED_LIST[STRING]

	texture_minutes: GAME_TEXTURE

	texture_points: GAME_TEXTURE

	texture_secondes: GAME_TEXTURE

	fenetre: GAME_RENDERER

	text_surface_minutes: TEXT_SURFACE_BLENDED
	text_surface_points: TEXT_SURFACE_BLENDED
	text_surface_secondes: TEXT_SURFACE_BLENDED
end
