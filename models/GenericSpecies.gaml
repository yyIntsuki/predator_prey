model GenericSpecies

import "Main.gaml"
import "Grid.gaml"

species generic_species {
	/* Visual */
	float size <- 1.0;
	rgb color;
	aspect base { draw circle(size) color: color; }
	
	/* Energy */
	float max_energy;
	float max_transfer;
	float energy_transfer;
	float energy_consum;
	float energy <- rnd(max_energy) update: energy - energy_consum max: max_energy;
	
	/* Location */
	vegetation_cell my_cell <- one_of (vegetation_cell);
	
	/* Events */
	reflex basic_move {
		my_cell <- one_of(my_cell.neighbors2);
		location <- my_cell.location;
	}
	
	float energy_from_eat { return 0.0; }
	
	reflex eat { energy <- energy + energy_from_eat(); }
	
	reflex die when: energy <= 0 {
		do die;
	}
	
	/* Initialization */
	init { location <- my_cell.location; }
}