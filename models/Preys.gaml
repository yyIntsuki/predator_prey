model Preys

import "Main.gaml"
import "GenericSpecies.gaml"

species prey parent: generic_species {
	
	init {
		color <- #blue;
		max_energy <- prey_max_energy;
		max_transfer <- prey_max_transfer;
		energy_consum <- prey_energy_consum;
		energy <- rnd(max_energy);
	}
	
	/* Chooses the richest vegetation node nearby */
	vegetation_cell choose_cell {
        return (my_cell.neighbors2) with_max_of (each.food);
    }
	
	/* Consumes vegetation inside current node */
	float energy_from_eat {
		energy_transfer <- 0.0;
		if (my_cell.food > 0) {
			energy_transfer <- min([max_transfer, my_cell.food]);
			my_cell.food <- my_cell.food - energy_transfer;
		}
		return energy_transfer;
	}
}