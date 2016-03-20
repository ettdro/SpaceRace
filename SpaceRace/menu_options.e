note
	description: "Classe qui g�re le menu des options de l'application."
	author: "�tienne Drolet et Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

class
	MENU_OPTIONS

inherit

	MENU
		redefine
			execution
		end

	TEXT_LIBRARY_SHARED

create
	make

feature -- Initialization

	make (a_fenetre: FENETRE; a_musique: MUSIQUE; a_son_click: EFFETS_SONORES)
			-- Construit le menu des options et ses images.
		do
			fenetre := a_fenetre
			musique := a_musique
			son_click := a_son_click
			if not musique.est_muet then
				doit_afficher_bouton_muet := False
			end 									--POURQUOI DOIS-JE FAIRE 2 IF ICI POUR QUE SA FONCTIONNE?
			if musique.est_muet then
				doit_afficher_bouton_muet := True
			end
			create bouton_muet.creer_affichable (fenetre.fenetre.renderer, "bouton_muet.png")
			create bouton_non_muet.creer_affichable (fenetre.fenetre.renderer, "bouton_non_muet.png")
			create bouton_credits.creer_affichable (fenetre.fenetre.renderer, "bouton_credits.png")
			create bouton_comment_jouer.creer_affichable (fenetre.fenetre.renderer, "bouton_comment_jouer.png")
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			create fond.make_image (fenetre.fenetre.renderer)
		end

feature -- Access

	execution
			-- Faire afficher le menu et ses images et lancer la gestion de la souris.
		do
			game_library.clear_all_events
			generer_fenetre
			Precursor {MENU}
			game_library.launch
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- M�thode qui g�re les actions de la souris dans le menu.
		do
			if a_etat_souris.is_left_button_pressed then
				if a_etat_souris.x > 399 and a_etat_souris.x < 606 and a_etat_souris.y > 100 and a_etat_souris.y < 155 then
					doit_afficher_bouton_muet := not doit_afficher_bouton_muet
					generer_fenetre
				elseif a_etat_souris.x > 399 and a_etat_souris.x < 606 and a_etat_souris.y > 200 and a_etat_souris.y < 255 then
					generer_credits
				elseif a_etat_souris.x > 30 and a_etat_souris.x < 236 and a_etat_souris.y > 519 and a_etat_souris.y < 577 then
					game_library.stop
				end
			end
		end

		--	mouvements_souris (a_timestamp: NATURAL_32; a_mouse_state: GAME_MOUSE_MOTION_STATE; a_delta_x, a_delta_y: INTEGER_32; a_window: GAME_WINDOW_RENDERED)
		--			-- When the mouse is moving, update the mouse information (from `a_mouse_state') on the `a_window' using
		--			-- `a_font' to draw text.
		--		do
		--			x := a_mouse_state.x
		--			y := a_mouse_state.y
		--			if (x > 399 and x < 606 and y > 100 and y < 155) or (x > 30 and x < 236 and y > 519 and y < 577) then
		--				game_library.set_cursor (curseur_main)
		--			else
		--				game_library.set_cursor (curseur_defaut)
		--			end
		--		end

	generer_fenetre
			-- Affiche toutes les images du menu � l'endroit pr�cis�.
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			if doit_afficher_bouton_muet = True then
				bouton_muet.afficher (400, 100, fenetre.fenetre.renderer)
				musique.mute
			else
				bouton_non_muet.afficher (400, 100, fenetre.fenetre.renderer)
				musique.unmute
			end
			bouton_credits.afficher (400, 200, fenetre.fenetre.renderer)
			bouton_comment_jouer.afficher (310, 300, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

	generer_credits
			-- Remplace les images du menu des options par celui des cr�dits. (Le faire dans une autre classe)
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

feature {ANY} -- Implementation

	fond: FOND_ECRAN

	doit_afficher_bouton_muet: BOOLEAN

	bouton_muet: BOUTONS

	bouton_non_muet: BOUTONS

	bouton_credits: BOUTONS

	bouton_comment_jouer: BOUTONS

	bouton_retour: BOUTONS

end
