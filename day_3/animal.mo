module Animal {
    public type Animal = {
        specie : Text;
        energy : Nat;
    };

    //challenge 3
    public func animal_sleep(animal : Animal) : Animal {
        var sleepAni : Animal = {
            specie = animal.specie;
            energy = animal.energy + 10;
        };
        return sleepAni;
    }; 

    
};