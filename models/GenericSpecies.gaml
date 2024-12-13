model GenericSpecies

import "Grid.gaml"

species generic_species {
	float size <- 1.0;
	rgb color;
	float max_energy;
	float max_transfer;
	float energy_consum;
	vegetation_cell my_cell <- one_of (vegetation_cell);
	float energy <- rnd(max_energy) update: energy - energy_consum max: max_energy;
	
	init {
		location <- my_cell.location;
	}

	reflex basic_move {
		my_cell <- one_of(my_cell.neighbors2);
		location <- my_cell.location;
	}

	reflex eat {
		energy <- energy + energy_from_eat();
	}

	reflex die when: energy <= 0 {
		do die;
	}

	float energy_from_eat {
		return 0.0;
	} 

	aspect base {
		draw circle(size) color: color;
	}
}