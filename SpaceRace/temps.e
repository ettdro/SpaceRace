note
	description: "Classe qui gère le chronomètre."
	author: "Nicolas Bisson & Étienne Drolet"
	date: "2016-04-03"
	revision: "1.1"

class
	TEMPS

create
	make

feature {NONE} -- Initialization

	make (a_fenetre: GAME_RENDERER; a_police: TEXT_FONT; a_couleur: GAME_COLOR)
			-- Crée le chronomètre.
		do
			temps_debut_milliseconde := 0
			temps_milliseconde := 0
			fenetre := a_fenetre
			police := a_police
			couleur := a_couleur
			create text_surface_minutes.make ("00", a_police, a_couleur)
			create text_surface_points.make (":", a_police, a_couleur)
			create text_surface_secondes.make ("00", a_police, a_couleur)
			create text_surface_decompte.make ("3", a_police, a_couleur)
			create texture_minutes.make_from_surface (a_fenetre, text_surface_minutes)
			create texture_points.make_from_surface (a_fenetre, text_surface_points)
			create texture_secondes.make_from_surface (a_fenetre, text_surface_secondes)
			create texture_decompte.make_from_surface (a_fenetre, text_surface_decompte)
		ensure
			Temps_Debut_Milliseconde_Assigne: temps_debut_milliseconde = 0
			Temps_Milliseconde_Assigne: temps_milliseconde = 0
			Fenetre_Assigne: fenetre = a_fenetre
			Police_Assigne: police = a_police
			Couleur_Assigne: couleur = a_couleur
		end

feature {ANY} -- Access

	depart_chrono (a_debut_millisecond: NATURAL)
			-- Démarre le chronomètre.
		do
			temps_debut_milliseconde := a_debut_millisecond
		end

	afficher_temps
			-- Affiche le chronomètre à l'écran.
		local
			temps_secondes: NATURAL
			temps_minutes: NATURAL
		do
			temps_secondes := ((temps_milliseconde // 1000) \\ 60)
			temps_minutes := (temps_milliseconde // 60000)
			if temps_secondes < 10 then
				create text_surface_secondes.make ("0" + temps_secondes.out, police, couleur)
			else
				create text_surface_secondes.make (temps_secondes.out, police, couleur)
			end
			if temps_minutes < 10 then
				create text_surface_minutes.make ("0" + temps_minutes.out, police, couleur)
			else
				create text_surface_minutes.make (temps_minutes.out, police, couleur)
			end
			create texture_secondes.make_from_surface (fenetre, text_surface_secondes)
			create texture_minutes.make_from_surface (fenetre, text_surface_minutes)
			fenetre.draw_texture (texture_minutes, 780, 75)
			fenetre.draw_texture (texture_points, 865, 75)
			fenetre.draw_texture (texture_secondes, 885, 75)
		end

		--	afficher_decompte
		--		do
		--			create text_surface_decompte.make (temps_decompte.out, font, color)
		--			create texture_decompte.make_from_surface (fenetre, text_surface_decompte)
		--			fenetre.draw_texture (texture_decompte, 500, 300)
		--		end

	chronometre (a_timestamp: NATURAL)
			-- Incrémente le temps du chronomètre.
		do
			pause := False
			temps_milliseconde := temps_milliseconde + a_timestamp - temps_debut_milliseconde
			temps_debut_milliseconde := a_timestamp
		end

		--	decompte(a_timestamp:NATURAL)
		--		do
		--			temps_decompte := temps_decompte + a_timestamp - temps_debut_milliseconde
		--		end

	pause_chrono
			-- Mets le chronomètre sur pause.
		do
			pause := True
			temps_pause := ((temps_milliseconde // 1000) \\ 60)
		end

feature {NONE} -- Implementation

	temps_debut_milliseconde: NATURAL -- Le temps depuis la création du chronomètre.

	temps_decompte: NATURAL -- Le temps du décompte

	temps_milliseconde: NATURAL -- Le temps en millisecondes.

	temps_pause: NATURAL -- Le temps de la pause.

	police: TEXT_FONT -- La police d'écriture du texte.

	couleur: GAME_COLOR -- La couleur du texte.

	texture_minutes: GAME_TEXTURE -- La texture qui signifie le nombre de minutes.

	texture_points: GAME_TEXTURE -- La texture qui signifie les points.

	texture_secondes: GAME_TEXTURE -- La texture qui signifie le nombre de secondes.

	fenetre: GAME_RENDERER -- La fenêtre de l'application.

	texture_decompte: GAME_TEXTURE -- La texture du décompte.

	text_surface_minutes: TEXT_SURFACE_BLENDED -- Une surface pour le nombre de minutes.

	text_surface_points: TEXT_SURFACE_BLENDED -- Une surface pour les points.

	text_surface_secondes: TEXT_SURFACE_BLENDED -- Une surface pour le nombre de secondes.

	text_surface_decompte: TEXT_SURFACE_BLENDED -- Une surface pour le décompte.

	pause: BOOLEAN -- Détermine si le jeu est en pause.

end
