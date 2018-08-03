import java.util.*;

Population p;                           // Population of rockets
PVector target = new PVector(400, 50);  // Target
int lifespan = 1000;                    // How long each generation lasts
int counter = 0;                        // Counter used to loop through generations
int generation = 1;                     // Counts generation number
int targetRadius = 10;                  // Size of target
float maxAcc = 0.1;                     // Maximum acceleration of rockets
int bestTime = lifespan;                // Best time of all 
int populationSize = 500;               // Population size of each geneartion
int randomNum = populationSize / 10;     // Number of random rockets every generation (set to 0 if you want to see genocide)


void setup() {
    size(800, 800);
    p = new Population();
    smooth();
    noStroke();
}


void draw() {

    background(0);

    // Target
    fill(255);
    ellipse(target.x, target.y, targetRadius * 2, targetRadius * 2);

    // Text on screen
    pushMatrix();
    textSize(20);
    text("Time: " + (counter), 30, height - 30);
    if (bestTime < lifespan)
      text("Best Time : " + bestTime, 30, height - 60);
    else
      text("Best Time : None", 30, height - 60);
    text("Generation: " + generation, 30, height - 90);
    text("Lifespan: " + lifespan, 30, height - 120);
    popMatrix();
    counter++;
    counter %= lifespan;

    // Population of rockets
    p.run();

    // New generation of population
    if (p.allCrashed())
        counter = lifespan;

    if(counter == 0) {
        generation++;
        p.evaluate();
        p.selection();
    }

}
