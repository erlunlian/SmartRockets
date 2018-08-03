public class Dna {

    PVector[] genes; // array of forces
    float red;
    float blue;
    float green;

    public Dna(PVector[] newGenes) {
        genes = newGenes;
    }

    public Dna() {
        genes = new PVector[lifespan];
        for (int i = 0; i < lifespan; i++) {
            genes[i] = (PVector.random2D());
            genes[i].setMag(maxAcc);
        }
        red = random(255);
        blue = random(255);
        green = random(255);
    }

    // Mutates dna
    public void mutate() {
        int end = floor(random(0, lifespan));
        int start = floor(random(0, end));

        for (int i = start; i <= end; i++) {
            // if (random(1) < 0.5)
            genes[i] = (PVector.random2D());
            genes[i].setMag(maxAcc);
        }
        if (random(1) < 0.1)
          red = random(255);
        if (random(1) < 0.1)
          green = random(255);
        if (random(1) < 0.1)
          blue = random(255);
    }

    // Creating childDna from two parents' dna
    public Dna crossover(Dna partner) {

        // Initializes new genes
        PVector[] newGenes = new PVector[lifespan];
  
        // Pick a random int as middle
        int mid = floor(random(genes.length));

        for (int i = 0; i < lifespan; i ++) {
            if (i < mid)
                newGenes[i] = genes[i];
            else
                newGenes[i] = partner.genes[i];
        }
        
        Dna newDna = new Dna(newGenes);
        newDna.red = (red + partner.red) / 2;
        newDna.green = (green + partner.green) / 2;
        newDna.blue = (blue + partner.blue) / 2;

        return newDna;

    }

}
