note
	description: "Classe qui gère le chronomètre."
	author: "Nicolas Bisson & Étienne Drolet"
	date: "2016-04-25"
	revision: "1.3"

class
	TEMPS_CHRONOMETRE

inherit

	TEMPS

create
	make

feature {NONE} -- Initialization

	make (a_fenetre: GAME_RENDERER; a_police: TEXT_FONT; a_couleur: GAME_COLOR)
			-- Crée le chronomètre, sa police (a_police) et sa couleur (a_couleur) dans la fenêtre (a_fenetre).
		do
			temps_debut_milliseconde := 0
			temps_milliseconde := 0
			fenetre := a_fenetre
			police := a_police
			couleur := a_couleur
			create text_surface_minutes.make ("00", a_police, a_couleur)
			create text_surface_points.make (":", a_police, a_couleur)
			create text_surface_secondes.make ("00", a_police, a_couleur)
			create texture_minutes.make_from_surface (a_fenetre, text_surface_minutes)
			create texture_points.make_from_surface (a_fenetre, text_surface_points)
			create texture_secondes.make_from_surface (a_fenetre, text_surface_secondes)
		ensure
			Temps_Debut_Milliseconde_Assigne: temps_debut_milliseconde = 0
			Temps_Milliseconde_Assigne: temps_milliseconde = 0
			Fenetre_Assigne: fenetre = a_fenetre
			Police_Assigne: police = a_police
			Couleur_Assigne: couleur = a_couleur
		end

feature {ANY} -- Access

	afficher_temps
			-- Affiche le chronomètre à l'écran.
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
		ensure
			Bon_Temps_Secondes: temps_secondes = ((temps_milliseconde // 1000) \\ 60)
			Bon_Temps_Minutes: temps_minutes = (temps_milliseconde // 60000)
		end

	pause_chrono (a_temps: NATURAL)
			-- Mets le chronomètre sur pause en retenant a_temps.
		do
			temps_pause := a_temps
			pause := True
		ensure
			Temps_Pause_Assigne: temps_pause = a_temps
			Est_Pause: pause = True
		end

feature {NONE} -- Implementation

	temps_secondes: NATURAL
			-- Le temps en secondes.

	temps_minutes: NATURAL
			-- Le temps en minutes.

	police: TEXT_FONT
			-- La police d'écriture du texte.

	couleur: GAME_COLOR
			-- La couleur du texte.

	texture_minutes: GAME_TEXTURE
			-- La texture qui signifie le nombre de minutes.

	texture_points: GAME_TEXTURE
			-- La texture qui signifie les points.

	texture_secondes: GAME_TEXTURE
			-- La texture qui signifie le nombre de secondes.

	fenetre: GAME_RENDERER
			-- La fenêtre de l'application.

	text_surface_minutes: TEXT_SURFACE_BLENDED
			-- Une surface pour le nombre de minutes.

	text_surface_points: TEXT_SURFACE_BLENDED
			-- Une surface pour les points.

	text_surface_secondes: TEXT_SURFACE_BLENDED
			-- Une surface pour le nombre de secondes.

end
