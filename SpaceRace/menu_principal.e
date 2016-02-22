note
	description: "Summary description for {MENU_PRINCIPAL}."
	author: "Étienne Drolet & Nicolas Bisson"
	date: "$Date$"
	revision: "$Revision$"

class
	MENU_PRINCIPAL

inherit

	MENU

	GAME_LIBRARY_SHARED

	AUDIO_LIBRARY_SHARED

	IMG_LIBRARY_SHARED



create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			game_library.enable_video
			audio_library.enable_sound
			image_file.enable_image (true, false, false)
			run_game
			image_file.quit_library
			audio_library.quit_library
			game_library.quit_library
		end

	run_game
		local
			l_fenetre: GAME_WINDOW_SURFACED
		do
			l_fenetre := creer_fenetre
			set_son (l_fenetre)
			game_library.quit_signal_actions.extend (agent quit_game)
			game_library.launch
			l_fenetre.close
		end

	creer_fenetre: GAME_WINDOW_SURFACED
		local
			l_fenetre_builder: GAME_WINDOW_SURFACED_BUILDER
		do
			create l_fenetre_builder
			l_fenetre_builder.set_dimension (800, 500)
			l_fenetre_builder.set_title ("SpaceRace")
			Result := l_fenetre_builder.generate_window
			if Result.has_error then
				game_library.stop
			end
		end

	creer_background (a_window: GAME_WINDOW)
		local
			l_fond: IMG_IMAGE_FILE
		do
			create l_fond.make("space_background.png")
			if l_fond.is_openable then
				l_fond.open
				if l_fond.is_open then
					make_from_image (l_fond)
				end
			end
		end

	set_son (a_window: GAME_WINDOW)
		local
			l_son_background: AUDIO_SOUND_FILE
			l_source: AUDIO_SOURCE
		do
			create l_son_background.make ("Y-Wing.wav")
			if l_son_background.is_openable then
				l_son_background.open
				if l_son_background.is_open then
					audio_library.sources_add
					l_source := audio_library.last_source_added
					l_source.queue_sound (l_son_background)
					game_library.iteration_actions.extend (agent update_son(?, a_window))
					l_source.play
				else
					print ("Ne peut ouvrir le fichier")
				end
			else
				print ("Ne peut ouvrir le fichier")
			end
		end

	update_son (a_timestamp: NATURAL; a_window: GAME_WINDOW)
		do
			audio_library.update
		end

	quit_game (a: NATURAL_32)
		do
			game_library.stop
		end

end
