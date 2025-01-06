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
	float energy <- rnd(max_energy) 
					update: is_infected ? 
					energy - (energy_consum + infection_energy_consum) :
					energy - energy_consum  
					max: max_energy;
	
		
	/* Reproduction */
	float proba_reproduce;
	int nb_max_offsprings;
	float energy_reproduce;
	
	/* Disease */
	bool is_infected <- false;
	
	reflex infection {
	    loop cell over: my_cell.neighbors2{
	    	list<predator> pred <- predator inside (cell);
	    	list<prey> pr <- prey inside (cell);
	    	loop i over: pred {
	    		if (i.is_infected and flip(infection_spread_probability)){
	    			is_infected <- true;
	    		}
	    	}
	    	loop i over: pr {
	    		if (i.is_infected and flip(infection_spread_probability)){
	    			is_infected <- true;
	    		}
	    	}
	    	if (is_infected) {break;}
        }
	}

	
	reflex cure when: is_infected {
		if (flip(cured_proba)){
			is_infected <- false;
		}
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
