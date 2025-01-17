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
		proba_reproduce <- prey_proba_reproduce;
		nb_max_offsprings <- prey_nb_max_offsprings;
		energy_reproduce <- prey_energy_reproduce;
		is_infected <- flip(infection_probability);
	}
	
	/* Chooses random neighboring vegetation node */
	vegetation_cell choose_cell { return one_of (my_cell.neighbors2); }
	
	/* Consumes vegetation inside current node */
	float energy_from_eat {
		energy_transfer <- 0.0;
		if (my_cell.food > 0) {
			energy_transfer <- min([max_transfer, my_cell.food]);
			my_cell.food <- my_cell.food - energy_transfer;
		}
		return energy_transfer;
	}
	
	reflex cured when: not is_infected { color <- #blue; }
	
	reflex infected when: is_infected { color <- #darkblue; }
	
}
