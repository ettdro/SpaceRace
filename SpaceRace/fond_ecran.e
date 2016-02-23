note
	description: "Classe pour gérer le fond d'ecran {FOND_ECRAN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FOND_ECRAN

inherit
	GAME_LIBRARY_SHARED
	IMG_LIBRARY_SHARED
	EXCEPTIONS

create
	make_fond_ecran
	
feature {NONE} -- Initialization

	make_fond_ecran(a_filename:STRING):GAME_SURFACE
		local
			l_fond:IMG_IMAGE_FILE
		do
			create l_fond.make (a_filename)	-- When created, the image source is not open
			if l_fond.is_openable then		-- Look if the file can be open. In the present case, if the file exist and is readable.
				l_fond.open		--Try to open the image source
				if l_fond.is_open then		-- If the image source is not open, then the file is probably not a valid bmp file
					create Result.share_from_image (l_fond)		-- Create a surface containing the image
					if not Result.is_open then	-- If the surface has not open as it should be.
						io.error.put_string ("The surface cannot be created.%N")
						die(4)						-- Quit the application
					end
				else
					io.error.put_string ("The file " + a_filename.as_string_8 + " does not seem to be a valid image file.%N")
					die(3)
				end
			else
				io.error.put_string ("Cannot read the image file " + a_filename.as_string_8 + ".%N")
				die (2)
			end
		end
end
