note
	description: "Tests pour la classe TOURS"
	author: "Nicolas Bisson et �tienne Drolet"
	date: "2016-04-25"
	revision: "1.0"
	testing: "type/manual"

class
	TESTS_TOURS

inherit
	EQA_TEST_SET

	TOURS
		undefine
			default_create
		end

feature -- Test routines

	incrementer_tour_normal
			-- Test normal de la routine `incrementer_tour'
		note
			testing:  "execution/serial"
		do
			incrementer_tour (True)
			assert ("incrementer_tour test normal", nombre_tour ~ 1)
		end

	incrementer_tour_limite
			-- Test limite de la routine `incrementer_tour'
		note
			testing:  "execution/serial"
		do
			incrementer_tour (True)
			incrementer_tour (True)
			incrementer_tour (True)
			assert ("incrementer_tour test limite", nombre_tour ~ 3)
		end

	incrementer_tour_errone
			-- Test errone de la routine `incrementer_tour'
		note
			testing:  "execution/serial"
		do
			incrementer_tour (True)
			incrementer_tour (True)
			incrementer_tour (True)
			incrementer_tour (True)
			assert ("incrementer_tour test errone", nombre_tour ~ 3)
		end

end


