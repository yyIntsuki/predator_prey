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
	
	/* Disease */
	bool infected <- false;
	bool recovered <- false;
	int infection_duration <- 0;
	int max_infection_duration <- 20;
	
	/* Location and Surroundings */
	vegetation_cell my_cell;
	list<generic_species> my_neighbors;
	
	/* Initialization */
	init {
		my_cell <- one_of(vegetation_cell);
		location <- my_cell.location;
	}
	
	/* Events */
	reflex basic_move {
		my_cell <- choose_cell();
		location <- my_cell.location;
	}
	
	vegetation_cell choose_cell {
		return nil;
	}
	
	float energy_from_eat { return 0.0; }
	
	reflex eat { energy <- energy + energy_from_eat(); }
	
	reflex die when: energy <= 0 { do die; }
	
}