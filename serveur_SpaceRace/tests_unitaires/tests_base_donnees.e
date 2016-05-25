note
	description: "Summary description for {TESTS_BASE_DONNEES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TESTS_BASE_DONNEES

inherit

	EQA_TEST_SET

	BASE_DONNEES
		undefine
			default_create
		end

feature -- Test routines

		remplir_liste_joueurs_normal
			-- Test normal de la routine `incrementer_tour'.
		note
			testing: "execution/serial"
		local
			un_joueur: JOUEUR
		do
			create un_joueur.make ("Etienne", "2:09")
			joueurs.extend (un_joueur)
			remplir_liste_joueurs
			assert ("remplir_liste_joueur test normal", joueurs.item ~ un_joueur)
		end

--		remplir_liste_joueurs_limite
--			-- Test normal de la routine `incrementer_tour'.
--		note
--			testing: "execution/serial"
--		local
--			un_joueur: JOUEUR
--		do
--			create un_joueur.make ("Etienne", "2:09")
--			joueurs.extend (un_joueur)
--			remplir_liste_joueurs
--			assert ("remplir_liste_joueur test normal", joueurs.item ~ un_joueur)
--		end



end
