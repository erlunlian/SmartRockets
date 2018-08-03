import java.util.*;

public class Population {

    int size;
    Rocket[] rockets;       // Array of rockets
    Rocket[] matingPool;    // Array of rockets for mating
    float maxFitness;       // Maximum fitness out of all rockets
    int newSize;            // Size of new array
    int PbestTime;           // Best time
    public Population() {
        size = populationSize;
        rockets = new Rocket[size];
        maxFitness = 0;
        newSize = 0;
        PbestTime = lifespan;

        // Adds new rockets to generation
        for (int i = 0; i < size; i++) {
            rockets[i] = new Rocket();
        }
    }

    // Allows rockets in population to funciton
    public void run() {
        for (Rocket r: rockets) {
            r.show();
            r.update();
            if (r.finalTime < PbestTime)
              PbestTime = bestTime = r.finalTime;
            
        }
    }

    // Evaluates fitness each rocket in all array
    public void evaluate() {
        newSize = 0; // Resets array size for new generation

        for (Rocket r: rockets) {
            r.calcFitness();

            // Adjusts max fitness
            if (r.fitness > maxFitness)
                maxFitness = r.fitness;
        }

        // Normalizes rocket's fitness
        for (Rocket r: rockets) {
            r.normalizedFitness = r.fitness / maxFitness;
            int n = int(r.normalizedFitness * 100);

            // Calculates size of matingPool
            newSize += n;
        }

    }

    // Creates and selects new generation
    public void selection() {

        matingPool = new Rocket[newSize];

        int currentIndex = 0;

        // Adds rockets to mating pool based on fitness
        for (Rocket r: rockets) {
            int n = int(r.normalizedFitness * 100);
            for (int i = 0; i < n; i ++) {
                matingPool[currentIndex] = r;
                currentIndex++;
            }
        }

        // Create new population for next generation
        Rocket[] newRockets = new Rocket[size];

        // Selecting two parents based on probability from matingPool
        for (int i = 0; i < size - randomNum; i ++) {

            // Choosing parents
            int parentIndexA = floor(random(matingPool.length));
            int parentIndexB = parentIndexA;

            while (parentIndexB != parentIndexA)
                parentIndexB = floor(random(matingPool.length));

            Rocket parentA = matingPool[parentIndexA];
            Rocket parentB = matingPool[parentIndexB];

            // Creating child dna from parents' dna
            Dna childDna = parentA.dna.crossover(parentB.dna);

            // Mutates dna
            childDna.mutate();

            // Add new child with new dna to new population of next generation
            newRockets[i] = new Rocket(childDna);

        }

        for (int i = size - randomNum; i < size; i++) {
            newRockets[i] = new Rocket();
        }

        // Advances to next generation
        rockets = newRockets;
    }

    public boolean allCrashed() {
        boolean result = true;
        for (Rocket r: rockets) {
            if (!r.crashed && !r.completed)
                result = false;
        }
        return result;
    }


}
