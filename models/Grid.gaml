model Grid

grid vegetation_cell width: 50 height: 50 neighbors: 4 {
    float max_food <- (rnd(1.0) < 0.1 ? 3.0 : 1.0);
    float food_prod <- rnd(0.01);
    float food <- rnd(1.0) max: max_food update: food + food_prod;
    
    rgb color <- (max_food > 1.0 
        ? rgb(255, 255, int(255 * (1 - food / max_food)))
        : rgb(int(255 * (1 - food / max_food)), 255, int(255 * (1 - food / max_food)))) 
        update: (max_food > 1.0 
        ? rgb(255 , 255, int(255 * (1 - food / max_food)))
        : rgb(int(255 * (1 - food / max_food)), 255, int(255 * (1 - food / max_food))));
    
    list<vegetation_cell> neighbors2 <- (self neighbors_at 2);
}