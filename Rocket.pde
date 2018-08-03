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
    int timeTaken;              // Time taken for rocket to reach target
    float red;                  // Color (visual dna family)
    float green;                  // Color (visual dna family)
    float blue;                  // Color (visual dna family)

    // New random rocket constructor
    public Rocket() {
        pos = new PVector(width / 2, height - 50);
        vel = new PVector(0, 0);
        acc = new PVector(0, 0);
        dna = new Dna(); // Array of directions to go
        maxDistance = dist(target.x, target.y, 0, height) + 10;
        crashed = false;
        red = random(255);
        blue = random(255);
        green = random(255);

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
    }

    // Fitness determining function
    public void calcFitness() {
        float d = PVector.dist(pos, target);
        fitness = map(d, 0, maxDistance, maxDistance, 0);

        if (completed)
            fitness *= 3 * (lifespan / timeTaken);

        if (crashed)
            fitness /= 3;

        if (pos.y > height * 0.6)
            fitness /= 2;

        if (pos.x < width / 2 - 200 || pos.x > width / 2 + 200)
            fitness /= 2;
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
            timeTaken = lifespan - counter;
        }

        if (!completed && !crashed) {
            pos.add(vel);
            vel.add(acc);
            acc.mult(0);

            // Applying force from Dna.genes array of forces
            addForce(dna.genes[counter]);
        }

    }


    public void show() {
        pushMatrix();

        noStroke();
        fill(red, blue, green, 150);

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
