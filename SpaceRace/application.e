note
	description: "Classe principale pour lancer le jeu."
	author: "Nicolas Bisson et �tienne Drolet"
	date: "2016-03-01"
	revision: "1.0"

class
	APPLICATION

inherit

	GAME_LIBRARY_SHARED

	IMG_LIBRARY_SHARED

	AUDIO_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		local
			l_menu: detachable MENU_PRINCIPAL
		do
			game_library.enable_video
			image_file_library.enable_image (True, True, False)
			audio_library.enable_sound
			create l_menu.make_principal
			l_menu.execution
			l_menu := Void
			audio_library.quit_library
			image_file_library.quit_library
			game_library.quit_library
		end

end
