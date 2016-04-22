note
	description: "Classe principale de l'application qui crée et lance le jeu."
	author: "Nicolas Bisson et Étienne Drolet"
	date: "2016-04-22"
	revision: "1.2"

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
			thread
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

	thread
			-- Méthode qui gère des threads. Il arrête après 1000 fois.
		local
			thread_salut: EX_THREAD
			thread_louis: EX_THREAD
			i: INTEGER
		do
			create thread_salut.make ("Salut ")
			create thread_louis.make ("Louis ")
			thread_salut.launch
			thread_louis.launch
			from
				i := 0
			until
				i = 1000
			loop
				io.put_string (i.out + "%N")
				i := i + 1
			end
			thread_salut.arret_thread
			thread_louis.arret_thread
			thread_salut.join
			thread_louis.join
		end

end
