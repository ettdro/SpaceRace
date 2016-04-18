note
	description: "Classe principale de l'application qui cr�e et lance le jeu."
	author: "Nicolas Bisson et �tienne Drolet"
	date: "2016-04-03"
	revision: "1.1"

class
	APPLICATION

inherit

	GAME_LIBRARY_SHARED

	IMG_LIBRARY_SHARED

	AUDIO_LIBRARY_SHARED

	TEXT_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialization

	make
			-- Boucle principale du jeu qui ouvre les librairies et lance le menu principal.
		local
			l_menu: detachable MENU_PRINCIPAL
		do
			game_library.enable_video
			image_file_library.enable_image (True, True, False)
			audio_library.enable_sound
			text_library.enable_text
			create l_menu.make
			l_menu.execution
			l_menu := Void
			text_library.quit_library
			audio_library.quit_library
			image_file_library.quit_library
			game_library.quit_library
		end

end
