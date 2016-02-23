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

create
	make_principal

feature {NONE} -- Initialization

	make_principal
			-- Initialization for `Current'.
		do
			game_library.enable_video
			image_file_library.enable_image(true,false,false)
			run_game
			image_file_library.quit_library
			game_library.quit_library
		end

	run_game
		do
			make_affichage
			--set_son (l_fenetre)
			game_library.quit_signal_actions.extend (agent quit_game)
			game_library.launch
		end

--	set_son (a_window: GAME_WINDOW)
--		local
--			l_son_background: AUDIO_SOUND_FILE
--			l_source: AUDIO_SOURCE
--		do
--			create l_son_background.make ("Y-Wing.wav")
--			if l_son_background.is_openable then
--				l_son_background.open
--				if l_son_background.is_open then
--					audio_library.sources_add
--					l_source := audio_library.last_source_added
--					l_source.queue_sound (l_son_background)
--					game_library.iteration_actions.extend (agent update_son(?, a_window))
--					l_source.play
--				else
--					print ("Ne peut ouvrir le fichier")
--				end
--			else
--				print ("Ne peut ouvrir le fichier")
--			end
--		end

--	update_son (a_timestamp: NATURAL; a_window: GAME_WINDOW)
--		do
--			audio_library.update
--		end

	quit_game (a: NATURAL_32)
		do
			game_library.stop
		end

end
