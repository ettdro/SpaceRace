note
	description: "Classe pour gérer les options du jeu."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-03-01"
	revision: "1.0"

class
	MENU_OPTIONS

inherit

	MENU
		redefine
			execution
		end

	AUDIO_LIBRARY_SHARED

create
	make

feature -- Initialization

	make (a_fenetre: FENETRE; a_musique:MUSIQUE)
			-- Construit le menu des options.
		do
			fenetre := a_fenetre
			musique := a_musique
			create bouton_muet.creer_affichable (fenetre.fenetre.renderer, "bouton_muet.png")
			create bouton_non_muet.creer_affichable (fenetre.fenetre.renderer, "bouton_non_muet.png")
			create bouton_credits.creer_affichable (fenetre.fenetre.renderer, "bouton_credits.png")
			create bouton_comment_jouer.creer_affichable (fenetre.fenetre.renderer, "bouton_comment_jouer.png")
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			create fond.make_image (fenetre.fenetre.renderer)
		end

	execution
		do
			game_library.clear_all_events
			generer_fenetre (1)
			game_library.iteration_actions.extend (agent (a_timestamp:NATURAL) do audio_library.update end)
			fenetre.fenetre.mouse_button_pressed_actions.extend (agent action_souris(?, ?, ?))
			Precursor {MENU}
			game_library.launch
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris dans les menus.
		do
			if a_etat_souris.is_left_button_pressed then
				if a_etat_souris.x > 399 and a_etat_souris.x < 606 and a_etat_souris.y > 100 and a_etat_souris.y < 175 then
					doit_afficher_bouton_muet := not doit_afficher_bouton_muet
					generer_fenetre (1)
				end
				if a_etat_souris.x > 30 and a_etat_souris.x < 236 and a_etat_souris.y > 519 and a_etat_souris.y < 577 then
					game_library.stop
				end
			end
		end

	generer_fenetre (a_temps: NATURAL_32)
		do
			fond.afficher (0, 0, fenetre.fenetre.renderer)
			if doit_afficher_bouton_muet then
				bouton_muet.afficher (400, 100, fenetre.fenetre.renderer)
				musique.mute
			else
				bouton_non_muet.afficher (400, 100, fenetre.fenetre.renderer)
				musique.unmute
			end
			bouton_credits.afficher (400, 200, fenetre.fenetre.renderer)
			bouton_comment_jouer.afficher ( 310, 300, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

feature {ANY}

	doit_afficher_bouton_muet: BOOLEAN

	fond: FOND_ECRAN

	bouton_muet: BOUTONS

	bouton_non_muet: BOUTONS

	bouton_credits: BOUTONS

	bouton_comment_jouer: BOUTONS

	bouton_retour: BOUTONS

	fenetre:FENETRE
	musique:MUSIQUE

end
