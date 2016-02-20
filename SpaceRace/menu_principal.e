note
	description: "Summary description for {MENU_PRINCIPAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MENU_PRINCIPAL

inherit
	MENU
	GAME_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			game_library.enable_video
			run_standard
			game_library.quit_library
		end

	run_standard
		local
			l_fenetre:GAME_WINDOW_SURFACED
			l_background:IMG_IMAGE_FILE
		do
			l_fenetre:=creer_fenetre
			l_background:=afficher_background
			game_library.quit_signal_actions.extend (agent quit_game)
			game_library.launch
		end

	creer_fenetre:GAME_WINDOW_SURFACED

		local
			l_fenetre_builder:GAME_WINDOW_SURFACED_BUILDER
		do
			create l_fenetre_builder
			l_fenetre_builder.set_dimension(800,500)
			l_fenetre_builder.set_title("SpaceRace")
			Result := l_fenetre_builder.generate_window
			if Result.has_error then
				game_library.stop
			end
		end

	afficher_background:GAME_SURFACE
		local
			l_image:IMG_IMAGE_FILE
		do
			create l_image.make ("space_background.png")
			l_image.open
		end

	quit_game(a:NATURAL_32)
		do
			game_library.stop
		end
end
