import java.util.*;

public class Rocket {

    PVector pos;                // Position of rocket
    PVector vel;                // Velocity of rocket
    PVector acc;                // Acceleration of rocket
    Dna dna;                    // Forces that accelerate the rocket
    float fitness;              // Fitness based on distance from target
    float normalizedFitness;    // Normalized fitness based on max fitness
    float maxDistance;          // Max distance from target
    boolean crashed;            // Whether rocket crashed or not
    boolean completed;          // Whether rocket reached target or not
    int timeTaken;              // Continously updated time taken for rocket to reach target
    int finalTime;              // Final time taken for rocket to reach target

    // New random rocket constructor
    public Rocket() {
        pos = new PVector(width / 2, height - 50);
        vel = new PVector(0, 0);
        acc = new PVector(0, 0);
        dna = new Dna(); // Array of directions to go
        maxDistance = dist(target.x, target.y, 0, height) + 10;
        crashed = false;
        timeTaken = 0;
        finalTime = lifespan;

    }

    // New rocket constructor with child genes
    public Rocket(Dna childDna) {
        pos = new PVector(width / 2, height - 50);
        vel = new PVector(0, 0);
        acc = new PVector(0, 0);
        counter = 0;
        dna = childDna;
        maxDistance = dist(target.x, target.y, 0, height) + 10;
        crashed = false;
        timeTaken = 0;
        finalTime = lifespan;
    }

    // Fitness determining function
    public void calcFitness() {
        float d = PVector.dist(pos, target);
        fitness = map(d, 0, maxDistance, maxDistance, 0);

        if (completed) {
            float factor = lifespan / finalTime;
            if (factor < 1)
              factor = 1;
            fitness = (float) Math.pow(fitness, lifespan / finalTime);
        }
        
        if (pos.y > target.y && pos.y < height / 2)
          fitness *= 2;
        
        if (crashed)
            fitness /= 5;

        if (pos.y > height * 0.6)
            fitness /= 3;

        if (pos.x < width / 2 - 200 || pos.x > width / 2 + 200)
            fitness /= 3;
    }

    // Adding force to particular rocket object
    public void addForce(PVector force) {
        acc.add(force);
    }

    // Physics engine
    public void update() {

        // Rcoket has hit left or right
        if (pos.x > width || pos.x < 0)
            crashed = true;

        // Rocket has hit top or bottom of window
        if (pos.y > height || pos.y < 0)
            crashed = true;

        else if (PVector.dist(pos, target) < targetRadius) {
            completed = true;
            finalTime = timeTaken;
        }

        if (!completed && !crashed) {
            pos.add(vel);
            vel.add(acc);
            acc.mult(0);
            timeTaken++;

            // Applying force from Dna.genes array of forces
            addForce(dna.genes[counter]);
        }

    }


    public void show() {
        pushMatrix();

        noStroke();
        fill(dna.red, dna.blue, dna.green, 150);

        translate(pos.x, pos.y);
        rotate(vel.heading());

        beginShape();
        vertex(10, 0);
        vertex(-10, 5);
        vertex(-5, 0);
        vertex(-10, -5);
        endShape();

        popMatrix();

    }

}
