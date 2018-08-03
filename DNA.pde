public class Dna {

    PVector[] genes; // array of forces

    public Dna(PVector[] newGenes) {
        genes = newGenes;
    }

    public Dna() {
        genes = new PVector[lifespan];
        for (int i = 0; i < lifespan; i++) {
            genes[i] = (PVector.random2D());
            genes[i].setMag(maxAcc);
        }
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

        return new Dna(newGenes);

    }

}
