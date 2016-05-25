note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TESTS_BASE_DONNEES

inherit
	EQA_TEST_SET
		redefine
			on_prepare
		end

	BASE_DONNEES
		undefine
			default_create
		end

feature {NONE} -- Events

	on_prepare
		-- Crée les attributs de la classe BASE_DONNEES.
			note
				testing: "execution/serial"
			do
				make
			end

feature -- Test routines

	remplir_liste_joueurs_normal
		-- Test normal de la routine `remplir_liste_joueurs'.
		note
			testing: "execution/serial"
		local
			un_joueur: JOUEUR
		do
			create un_joueur.make ("Etienne", "2:09")
			joueurs.extend (un_joueur)
			remplir_liste_joueurs
			assert ("remplir_liste_joueur test normal", joueurs.last ~ un_joueur)
		end

--	ajouter_joueur_normal
--			-- Test normal de la routine `remplir_liste_joueurs'.
--		note
--			testing: "execution/serial"
--		local
--			un_joueur: JOUEUR
--		do
--			create un_joueur.make ("Nicolas", "1:10")
--			ajouter_joueur (un_joueur.nom_joueur, un_joueur.temps_joueur)
--			remplir_liste_joueurs
--			assert ("ajouter_joueur test normal", joueurs.first ~ un_joueur)
--		end
end


