model Predators

import "Main.gaml"
import "GenericSpecies.gaml"

species predator parent: generic_species {
	init {
		color <- #red;
	}
	
	float max_energy <- predator_max_energy;
	float energy_transfer <- predator_energy_transfer;
	float energy_consum <- predator_energy_consum;

	float energy_from_eat {
		list<prey> reachable_preys <- prey inside (my_cell);
		if (!empty(reachable_preys)) {
			ask one_of(reachable_preys) { do die; }
			return energy_transfer;
		}
		return 0.0;
	}

}
