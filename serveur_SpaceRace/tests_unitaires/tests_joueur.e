note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TESTS_JOUEUR

inherit
	EQA_TEST_SET
		redefine
			on_prepare
		end

	JOUEUR
		undefine
			default_create,
			is_equal
		end

feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		do
			make ("", "")

		end

feature -- Test routines

	is_less_normal
			-- New test routine
		note
			testing:  "execution/serial"
		local
--			l_liste_joueurs: LINKED_LIST[JOUEUR]
			l_joueur1: JOUEUR
			l_joueur2: JOUEUR
			est_plus_petit: BOOLEAN
		do
			create l_joueur1.make ("Joueur1", "2:10")
			create l_joueur2.make ("Joueur2", "1:01")
			est_plus_petit := l_joueur2 < l_joueur1
--			create l_liste_joueurs.make
--			l_liste_joueurs.extend (l_joueur1)
--			l_liste_joueurs.extend (l_joueur2)
			assert ("is_less test normal", est_plus_petit)
		end
end


