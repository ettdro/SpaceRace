note
	description: "Classe abstraite {TEMPS} qui contient des m�thodes utilis�es dans {TEMPS} et dans les tests."
	author: "�tienne Drolet et Nicolas Bisson"
	date: "2016-04-25"
	revision: "1.0"

deferred class
	TEMPS

create
	make

feature {NONE} -- Initialization

	make (a_fenetre: GAME_RENDERER; a_police: TEXT_FONT; a_couleur: GAME_COLOR)
			-- Cr�e le chronom�tre.
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
			-- D�marre le chronom�tre.
		do
			temps_debut_milliseconde := a_debut_millisecond
		end

	afficher_temps
			-- Affiche le chronom�tre � l'�cran.
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
			-- Incr�mente le temps du chronom�tre.
		do
			pause := False
			temps_milliseconde := temps_milliseconde + a_timestamp - temps_debut_milliseconde
			temps_debut_milliseconde := a_timestamp
		end

	depart_chrono (a_debut_millisecond: NATURAL)
			-- D�marre le chronom�tre.
		do
			temps_debut_milliseconde := a_debut_millisecond
		end

feature {ANY}

	pause: BOOLEAN -- D�termine si le jeu est en pause.

	temps_debut_milliseconde: NATURAL -- Le temps depuis la cr�ation du chronom�tre.

	temps_milliseconde: NATURAL -- Le temps en millisecondes.

end
