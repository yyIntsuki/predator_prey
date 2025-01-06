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
	float energy <- rnd(max_energy) update: energy_update_rule() max: max_energy;
	
	float energy_update_rule {
		if (is_infected) { return energy - energy_consum + infection_energy_consum; } 
		else { return energy - energy_consum; }
	}
	
	/* Reproduction */
	float proba_reproduce;
	int nb_max_offsprings;
	float energy_reproduce;
	
	/* Disease */
	bool is_infected <- false;

	reflex infection{
		list<generic_species> nearby_species <- list<generic_species> (self neighbors_at 4);
		if not empty(nearby_species) and one_of (nearby_species).is_infected {
			if (flip(infection_spread_probability)) { is_infected <- true; }
		}
	}

	reflex cure when: is_infected {
		if (flip(cured_proba)) { is_infected <- false; }
    }

	/* Location */
	vegetation_cell my_cell;
	
	/* Initialization */
	init {
		my_cell <- one_of (vegetation_cell);
		location <- my_cell.location;
	}
	
	/* Movement */
	reflex basic_move {
		my_cell <- choose_cell();
		location <- my_cell.location;
	}
	
	vegetation_cell choose_cell { return nil; }
	
	/* Survival related behaiors */
	reflex eat { energy <- energy + energy_from_eat(); }
	
	float energy_from_eat { return 0.0; }
	
	reflex reproduce when: (energy >= energy_reproduce) and (flip(proba_reproduce)) {
        int nb_offsprings <- rnd(1, nb_max_offsprings);
        create species(self) number: nb_offsprings {
            my_cell <- myself.my_cell;
            location <- my_cell.location;
            energy <- myself.energy / nb_offsprings;
        }
        energy <- energy / nb_offsprings ;
    }
	
	reflex die when: energy <= 0 { do die; }
	
}
