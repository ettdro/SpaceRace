note
	description: "[
		Classe effectuant des tests sur les méthodes testables de la classe JOUEUR.
	]"
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-05-25"
	revision: "1.5"
	testing: "type/manual"

class
	TESTS_JOUEUR

inherit
	EQA_TEST_SET

feature -- Test routines

	is_less_normal
			-- Test normal pour savoir si la valeur est vraiment plus petite que la suivante.
		note
			testing:  "execution/serial"
		local
			l_joueur1: JOUEUR
			l_joueur2: JOUEUR
			est_plus_petit: BOOLEAN
		do
			create l_joueur1.make ("Joueur1", "2:10")
			create l_joueur2.make ("Joueur2", "1:01")
			est_plus_petit := l_joueur2 < l_joueur1
			assert ("is_less test normal", est_plus_petit)
		end
end
