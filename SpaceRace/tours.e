note
	description: "Contient ce qui est g�n�ral aux tours."
	author: "Nicolas Bisson et �tienne Drolet"
	date: "2016-04-25"
	revision: "1.0"

deferred class
	TOURS

feature {ANY} -- Access

	incrementer_tour (a_tour_complete: BOOLEAN)
			-- Augmente le nombre de tour lorsqu'un tour est compl�t� (a_tour_complete).
		do
			tour_complete := a_tour_complete
			if nombre_tour < 3 then
				if tour_complete then
					nombre_tour := nombre_tour + 1
					if nombre_tour = 3 then
						print ("Tu as gagn�!!!") -- TEMPORAIRE
					end
				end
			end
		end

feature {ANY} -- Implementation

	tour_complete: BOOLEAN
			-- D�termine si le nombre de tours compl�t�s doit augmenter.

	nombre_tour: NATURAL
			-- La nombre de tours qui sont actuellement compl�t�s.

end
