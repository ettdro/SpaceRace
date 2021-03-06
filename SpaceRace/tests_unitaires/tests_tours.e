note
	description: "Classe effectuant des tests sur les m�thodes testables de la classe TOURS."
	author: "�tienne Drolet et Nicolas Bisson"
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

feature {ANY} -- Test routines

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
			-- Test erron� de la routine `incrementer_tour'.
		note
			testing: "execution/serial"
		do
			incrementer_tour (True)
			incrementer_tour (True)
			incrementer_tour (True)
			incrementer_tour (True)
			assert ("incrementer_tour test erron�", nombre_tour ~ 3)
		end

end
