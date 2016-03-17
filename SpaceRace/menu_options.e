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

create
	make

feature -- Initialization

	make (a_fenetre: FENETRE; a_musique: MUSIQUE; a_son_click: EFFETS_SONORES)
			-- Construit le menu des options.
		do
			fenetre := a_fenetre
			musique := a_musique
			son_click := a_son_click
			if not musique.est_muet then
				doit_afficher_bouton_muet := False
			end													--POURQUOI DOIS-JE FAIRE 2 IF ICI POUR QUE SA FONCTIONNE?
			if musique.est_muet then
				doit_afficher_bouton_muet := True
			end
			create bouton_muet.creer_affichable (fenetre.fenetre.renderer, "bouton_muet.png")
			create bouton_non_muet.creer_affichable (fenetre.fenetre.renderer, "bouton_non_muet.png")
			create bouton_credits.creer_affichable (fenetre.fenetre.renderer, "bouton_credits.png")
			create bouton_comment_jouer.creer_affichable (fenetre.fenetre.renderer, "bouton_comment_jouer.png")
			create bouton_retour.creer_affichable (fenetre.fenetre.renderer, "bouton_retour.png")
			create bouton_musique_precedente.creer_affichable (fenetre.fenetre.renderer, "fleche_musique_precedente.png")
			create bouton_musique_suivante.creer_affichable (fenetre.fenetre.renderer, "fleche_musique_suivante.png")
			create fond.make_image (fenetre.fenetre.renderer)
		end

feature -- Access
	execution
		do
			game_library.clear_all_events
			generer_fenetre
			Precursor {MENU}
			game_library.launch
		end

	action_souris (a_temps: NATURAL_32; a_etat_souris: GAME_MOUSE_BUTTON_PRESSED_STATE; a_nb_clicks: NATURAL_8)
			-- Méthode qui gère les actions de la souris dans les menus.
		do
			if a_etat_souris.is_left_button_pressed then
				if a_etat_souris.x > 399 and a_etat_souris.x < 606 and a_etat_souris.y > 100 and a_etat_souris.y < 155 then
					doit_afficher_bouton_muet := not doit_afficher_bouton_muet
					generer_fenetre
				elseif a_etat_souris.x > 800 and a_etat_souris.x < 853 and a_etat_souris.y > 520 and a_etat_souris.y < 579 then
					print("musique précédente")
				elseif a_etat_souris.x > 875 and a_etat_souris.x < 928 and a_etat_souris.y > 520 and a_etat_souris.y < 579 then
					musique.suivante
				elseif a_etat_souris.x > 30 and a_etat_souris.x < 236 and a_etat_souris.y > 519 and a_etat_souris.y < 577 then
					game_library.stop
				end
			end
		end

	generer_fenetre
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
			bouton_comment_jouer.afficher ( 310, 300, fenetre.fenetre.renderer)
			bouton_musique_precedente.afficher (800, 520, fenetre.fenetre.renderer)
			bouton_musique_suivante.afficher (875, 520, fenetre.fenetre.renderer)
			bouton_retour.afficher (30, 520, fenetre.fenetre.renderer)
			fenetre.fenetre.renderer.present
		end

feature {ANY}

	fond: FOND_ECRAN

	doit_afficher_bouton_muet: BOOLEAN

	bouton_muet: BOUTONS

	bouton_non_muet: BOUTONS

	bouton_credits: BOUTONS

	bouton_comment_jouer: BOUTONS

	bouton_retour: BOUTONS

	bouton_musique_precedente: BOUTONS

	bouton_musique_suivante: BOUTONS

end
