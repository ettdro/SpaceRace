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

	make (a_fenetre: GAME_RENDERER; a_font: TEXT_FONT; a_color: GAME_COLOR; a_debut_millisecond:NATURAL)
			-- Initialization for `Current'.
		do
			temps_debut_milliseconde := a_debut_millisecond
			temps_milliseconde := 0
			temps_decompte := 3
			fenetre := a_fenetre
			font := a_font
			color := a_color
			create text_surface_minutes.make ("00", a_font, a_color)
			create text_surface_points.make (":", a_font, a_color)
			create text_surface_secondes.make ("00", a_font, a_color)
			create text_surface_decompte.make ("3", a_font, a_color)
			create texture_minutes.make_from_surface (a_fenetre, text_surface_minutes)
			create texture_points.make_from_surface (a_fenetre, text_surface_points)
			create texture_secondes.make_from_surface (a_fenetre, text_surface_secondes)
			create texture_decompte.make_from_surface (a_fenetre, text_surface_decompte)
		end


feature {ANY}

	afficher_temps
		local
			temps_secondes : NATURAL
			temps_minutes : NATURAL
		do
			temps_secondes := ((temps_milliseconde // 1000) \\ 60)
			temps_minutes := (temps_milliseconde // 60000)
			if temps_secondes < 10 then
				create text_surface_secondes.make ("0" + temps_secondes.out, font, color)
			else
				create text_surface_secondes.make (temps_secondes.out, font, color)
			end
			if temps_minutes < 10 then
				create text_surface_minutes.make ("0" + temps_minutes.out, font, color)
			else
				create text_surface_minutes.make (temps_minutes.out, font, color)
			end
			create texture_secondes.make_from_surface (fenetre, text_surface_secondes)
			create texture_minutes.make_from_surface (fenetre, text_surface_minutes)
			fenetre.draw_texture (texture_minutes, 780, 75)
			fenetre.draw_texture (texture_points, 865, 75)
			fenetre.draw_texture (texture_secondes, 885, 75)
		end

	afficher_decompte
		do
			create text_surface_decompte.make (temps_decompte.out, font, color)
			create texture_decompte.make_from_surface (fenetre, text_surface_decompte)
			fenetre.draw_texture (texture_decompte, 500, 300)
		end

	chronometre(a_timestamp:NATURAL)
		do
			arret := False
			temps_milliseconde := temps_milliseconde + a_timestamp - temps_debut_milliseconde
			temps_debut_milliseconde := a_timestamp
		end

	decompte(a_timestamp:NATURAL)
		do
			temps_decompte := temps_decompte + a_timestamp - temps_debut_milliseconde
		end

	arreter
		do
			arret := True
		end

	temps_debut_milliseconde: NATURAL

	temps_milliseconde: NATURAL

	temps_decompte: NATURAL

	font: TEXT_FONT

	color: GAME_COLOR

	texture_minutes: GAME_TEXTURE

	texture_points: GAME_TEXTURE

	texture_secondes: GAME_TEXTURE

	texture_decompte: GAME_TEXTURE

	fenetre: GAME_RENDERER

	text_surface_minutes: TEXT_SURFACE_BLENDED

	text_surface_points: TEXT_SURFACE_BLENDED

	text_surface_secondes: TEXT_SURFACE_BLENDED

	text_surface_decompte: TEXT_SURFACE_BLENDED

	arret: BOOLEAN
end
