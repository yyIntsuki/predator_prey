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
	}
	
	/* Chooses neighboring preys if found, otherwise random */
    vegetation_cell choose_cell {
        vegetation_cell my_cell_tmp <- shuffle(my_cell.neighbors2) first_with (!(empty (prey inside (each))));
		if my_cell_tmp != nil { return my_cell_tmp; }
		else { return one_of (my_cell.neighbors2); }
    }
	
	/* Consumes a prey inside current node */
	float energy_from_eat {
		list<prey> reachable_preys <- prey inside(my_cell);
		if (!empty(reachable_preys)) {
			ask one_of(reachable_preys) { do die; }
			return energy_transfer;
		}
		return 0.0;
	}
	
}