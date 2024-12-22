model Preys

import "Main.gaml"
import "GenericSpecies.gaml"

species prey parent: generic_species {
	init {
		color <- #blue;
	}
	
	float max_energy <- prey_max_energy;
	float max_transfer <- prey_max_transfer;
	float energy_consum <- prey_energy_consum;

	float energy_from_eat {
		energy_transfer <- 0.0;
		if (my_cell.food > 0) {
			energy_transfer <- min([max_transfer, my_cell.food]);
			my_cell.food <- my_cell.food - energy_transfer;
		}
		return energy_transfer;
	}
}