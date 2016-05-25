note
	description: "Classe contenant les tests de la classe TOURS."
	author: "Nicolas Bisson et Étienne Drolet"
	date: "2016-04-25"
	revision: "1.3"
	testing: "type/manual"

class
	TESTS_TOURS

inherit

	EQA_TEST_SET

	TOURS
		undefine
			default_create
		end

feature {NONE} -- Test routines

	incrementer_tour_normal
			-- Test normal de la routine `incrementer_tour'.
		note
			testing: "execution/serial"
		do
			incrementer_tour (True)
			assert ("incrementer_tour test normal", nombre_tour ~ 1)
		end

	incrementer_tour_limite
			-- Test limite de la routine `incrementer_tour'.
		note
			testing: "execution/serial"
		do
			incrementer_tour (True)
			incrementer_tour (True)
			incrementer_tour (True)
			assert ("incrementer_tour test limite", nombre_tour ~ 3)
		end

	incrementer_tour_errone
			-- Test erroné de la routine `incrementer_tour'.
		note
			testing: "execution/serial"
		do
			incrementer_tour (True)
			incrementer_tour (True)
			incrementer_tour (True)
			incrementer_tour (True)
			assert ("incrementer_tour test erroné", nombre_tour ~ 3)
		end

end
