note
	description: "Gère le choix des pistes et des menus."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

class
	MENU_VAISSEAUX_PISTES

inherit

	MENU
		redefine
			execution
		end

create
	make

feature -- Access

	make (a_fenetre: FENETRE; a_musique: MUSIQUE; a_son_click: EFFETS_SONORES)
			-- Construit le menu pour choisir les vaisseaux et pistes.
		do
			fenetre := a_fenetre
			musique := a_musique
			son_click := a_son_click
			create musique.creer
		end

	execution
		do

		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris dans les menus.
		do
		end

end
