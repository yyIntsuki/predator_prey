model Main

import "Grid.gaml"
import "GenericSpecies.gaml"
import "Preys.gaml"
import "Predators.gaml"
import "Simulation.experiment"

global {
	int nb_preys_init <- 200;
	int nb_predators_init <- 20;
	int nb_preys -> { length(prey) };
	int nb_predators -> { length(predator) };
	
	float prey_max_energy <- 1.0;
	float prey_max_transfer <- 0.1;
	float prey_energy_consum <- 0.05;
	
	float predator_max_energy <- 1.0;
	float predator_energy_transfer <- 0.5;
	float predator_energy_consum <- 0.02;

	init {
		create prey number: nb_preys_init;
		create predator number: nb_predators_init;
	}
}
