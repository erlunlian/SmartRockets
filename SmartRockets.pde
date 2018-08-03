import java.util.*;

Population p;                           // Population of rockets
PVector target = new PVector(400, 50);  // Target
int lifespan = 900;                    // How long each generation lasts
int counter = 0;                        // Counter used to loop through generations
int generation = 0;                     // Counts generation number
int targetRadius = 10;                  // Size of target
float maxAcc = 0.1;                     // Maximum acceleration of rockets
int randomNum = 50;                     // Number of random rockets every generation


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
    text("Lifespan: " + (lifespan - counter), 30, height - 30);
    text("Generation: " + generation, 30, height - 60);
    popMatrix();
    counter++;
    counter %= lifespan;

    // Population of rockets
    p.run();

    // New generation of population
    if (p.allCrashed())
        counter = 0;

    if(counter == 0) {
        generation++;
        p.evaluate();
        p.selection();
    }

}
