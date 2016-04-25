note
	description: "Classe contenant les tests de la classe TEMPS."
	author: "Étienne Drolet et Nicolas Bisson"
	date: "2016-04-25"
	revision: "1.0"
	testing: "type/manual"

class
	TESTS_TEMPS

inherit
	EQA_TEST_SET

	TEMPS
		undefine
			default_create
		end

feature -- Test routines

	chronometre_normal
			-- Test normal de la routine `chronometre'
		note
			testing:  "execution/serial"
		local
			temps: NATURAL
		do
			temps := 7000
			chronometre (temps)
			assert ("chronometre test normal", temps ~ 7000)
		end

	chronometre_limite
			-- Test limite de la routine `chronometre'
		note
			testing:  "execution/serial"
		local
			temps: NATURAL
		do
			temps := 0
			chronometre (temps)
			assert ("chronometre test limite", temps ~ 0)
		end

	depart_chrono_normal
			-- Test normal de la routine `depart_chrono'
		note
			testing:  "execution/serial"
		local
			temps: NATURAL
		do
			temps := 0
			depart_chrono (temps)
			assert ("depart_chrono test normal", temps ~ 0)
		end

	depart_chrono_errone
			-- Test erroné de la routine `depart_chrono'
		note
			testing:  "execution/serial"
		local
			temps: NATURAL
		do
			temps := 1
			depart_chrono (temps)
			assert ("depart_chrono test erroné", temps ~ 1)
		end
end


