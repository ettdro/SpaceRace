note
	description: "[
		Classe effectuant des tests sur les méthodes testables de la classe BASE_DONNEES.
	]"
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-05-25"
	revision: "1.5"
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
		-- Crée les attributs de la classe BASE_DONNEES avant d'effectuer les tests.
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
end
