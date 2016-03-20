note
	description: "Gère le menu où l'on choisi le modèle du vaisseau avec lequel courser."
	author: "Nicolas Bisson et Étienne Drolet"
	date: "2016-03-01"
	revision: "1.0"

class
	MODELES_VAISSEAUX

inherit

	MENU
		redefine
			execution
		end

create
	make

feature {NONE} -- Initialization

	make (a_fenetre: FENETRE; a_musique: MUSIQUE; a_son_click: EFFETS_SONORES)
			-- Construit le menu pour choisir le vaisseaux.
		do
			fenetre := a_fenetre
			musique := a_musique
			son_click := a_son_click
		end

feature -- Access

	execution
			-- Faire afficher le menu et ses images et lancer la gestion de la souris.
		do
			game_library.clear_all_events
			Precursor {MENU}
			game_library.launch
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris dans le menu.
		do
		end

		--	mouvements_souris (a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_MOTION_STATE; a_delta_x, a_delta_y: INTEGER_32; a_window: GAME_WINDOW_RENDERED)
		--			-- When the mouse is moving, update the mouse information (from `a_mouse_state') on the `a_window' using
		--			-- `a_font' to draw text.
		--		do
		--		end

end
