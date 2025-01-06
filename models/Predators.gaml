model Predators

import "Main.gaml"
import "GenericSpecies.gaml"

species predator parent: generic_species {
	
	init {
		color <- #red;
		max_energy <- predator_max_energy;
		energy_transfer <- predator_energy_transfer;
		energy_consum <- predator_energy_consum;
		energy <- rnd(max_energy);
		proba_reproduce <- predator_proba_reproduce;
		nb_max_offsprings <- predator_nb_max_offsprings;
		energy_reproduce <- predator_energy_reproduce;
	}
	
	/* Chooses random neiboring nodes */
    vegetation_cell choose_cell {
    	return one_of (my_cell.neighbors2);
		// vegetation_cell my_cell_tmp <- shuffle (my_cell.neighbors2) first_with (!(empty(prey inside (each))));
		// if my_cell_tmp != nil { return my_cell_tmp; }
		// else { return one_of (my_cell.neighbors2); }
    }
	
	/* Consumes a prey inside current node
	 * Predator is infected if prey consumed was infected
	 */
	float energy_from_eat {
		if (energy > max_energy*0.7){
			return 0.0;
		}	
		list<prey> reachable_preys <- prey inside(my_cell);
		if !empty(reachable_preys) {
			ask one_of (reachable_preys) { do die; }
			return energy_transfer;
		}
		return 0.0;
	}
	
	reflex infected when: is_infected {
		color <- #darkred;
	}
	
}
