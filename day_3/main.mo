import Custom "custom";
import Animal "animal";
import List "mo:base/List";
import CustomList "list";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Cycles "mo:base/ExperimentalCycles";

actor day_3 {
    //     Challenge 1 : Create two files called custom.mo and main.mo, create your own type inside custom.mo and import it in your main.mo file. In main, create a public function fun that takes no argument but return a value of your custom type.
    public type Student = Custom.Student;
    var example : Student = {
        name = "Ngo Viet Tien";
        code = "SE161204";
        age = 20;
    };
    public func fun() : async Student {
        return example;
    };

    // Challenge 2 : Create a new file called animal.mo with at least 2 property (specie of type Text, energy of type Nat), import this type in your main.mo and create a variable that will store an animal.
    public type Animal = Animal.Animal;
    var exampleAnimal : Animal = {
        specie = "dog";
        energy = 50;
    };
    // Challenge 3 : In animal.mo create a public function called animal_sleep that takes an Animal and returns the same Animal where the field energy has been increased by 10. Note : As this is a public function of a module, you don't need to make the return type Async !
    
    // Challenge 4 : In main.mo create a public function called create_animal_then_takes_a_break that takes two parameter : a specie of type Text, an number of energy point of type Nat and returns an animal. This function will create a new animal based on the parameters passed and then put this animal to sleep before returning it ! 
    public func create_animal_then_takes_a_break(spec : Text, ener : Nat) : async Animal {
        var animal : Animal = {
            specie = spec;
            energy = ener;
        };
        return Animal.animal_sleep(animal);
    };
    // Challenge 5 : In main.mo, import the type List from the base Library and create a list that stores animal.
    public type List<T> = ?(T, List<T>);
    var listAnimal : List<Animal> = null;
    // Challenge 6 : In main.mo : create a function called push_animal that takes an animal as parameter and returns nothing this function should add this animal to your list created in challenge 5. Then create a second functionc called get_animals that takes no parameter but returns an Array that contains all animals stored in the list. 
    public func push_animal(animal : Animal) {
        listAnimal := List.push(animal, listAnimal);
    };
    
    public func get_animals() : async [Animal] {
        return List.toArray(listAnimal);
    };
    // For challenges 7 to 10 : You need to start from a fresh file (call it list.mo) you cannot use the List module of the base library, the goal is to reimplement some functionnality of arrays.

    // Challenge 11 : Write a function is_anonymous that takes no arguments but returns true is the caller is anonymous and false otherwise.
    public shared({caller}) func is_anonymous() : async Bool {
        switch(Principal.toText(caller)) {
            case("2vxsx-fae") return true;
            case(_) return false;
        }
    };

    // Challenge 12 : Create an HashMap called favoriteNumber where the keys are Principal and the value are Nat.
    var favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);
    // Challenge 13 : Write two functions :
    // add_favorite_number that takes n of type Nat and stores this value in the HashMap where the key is the principal of the caller. This function has no return value.
    public shared({caller}) func add_favorite_number_demo(n : Nat) {
        favoriteNumber.put(caller, n);
    };
    // show_favorite_number that takes no argument and returns n of type ?Nat, n is the favorite number of the person as defined in the previous function or null if the person hasn't registered.
    public shared({caller}) func show_favorite_number() : async ?Nat {
        switch(Principal.toText(caller)) {
            case("2vxsx-fae") return null;
            case(_) return favoriteNumber.get(caller);
        }
    };
    // Challenge 14 : Rewrite your function add_favorite_number so that if the caller has already registered his favorite number, the value in memory isn't modified. This function will return a text of type Text that indicates "You've already registered your number" in that case and "You've successfully registered your number" in the other scenario.
    public shared({caller}) func add_favorite_number(n : Nat) : async Text {
        if (favoriteNumber.get(caller) == null) {
            favoriteNumber.put(caller, n);
            return "You've successfully registered your number";
        }
        else {
            return "You've already registered your number";
        };
    };
    // Challenge 15 : Write two functions
    // update_favorite_number
    public shared({caller}) func update_favorite_number(n : Nat) : async Text {
        if (favoriteNumber.get(caller) == null) {
            return "You haven't registered your number";
        }
        else {
            var preValue = favoriteNumber.replace(caller, n);
            return "You've successfully changed your number";
        };
    };
    // delete_favorite_number
    public shared({caller}) func delete_favorite_number() : async Text {
        if (favoriteNumber.get(caller) == null) {
            return "You haven't registered your number";
        }
        else {
            var delValue = favoriteNumber.remove(caller);
            return "You've successfully removed your number";
        };
    };
    // Challenge 16 : Write a function deposit_cycles that allow anyone to deposit cycles into the canister. This function takes no parameter but returns n of type Nat corresponding to the amount of cycles deposited by the call.
    public shared({caller}) func deposit_cycles() : async Nat {
        var depositAmount : Nat = 100000;
        if (Cycles.available() < depositAmount) {
            return 0;
        };
        var depositCycles = Cycles.accept(depositAmount);
        return depositCycles;
    };


    // Challenge 17 (hard) : Write a function withdraw_cycles that takes a parameter n of type Nat corresponding to the number of cycles you want to withdraw from the canister and send it to caller asumming the caller has a callback called deposit_cycles()
    // Note : You need two canisters.
    // Note 2 : Don't do that in production without admin protection or your might be the target of a cycle draining attack.
    public func withdraw_cycles(n : Nat) {

    };


    // Challenge 18 : Rewrite the counter (of day 1) but this time the counter will be kept accross ugprades. Also declare a variable of type Nat called versionNumber that will keep track of how many times your canister has been upgraded.
    stable var versionNumber : Nat = 0;
    stable var counter : Nat = 0;
    // counter := 0;
    public func increment_counter(n : Nat) : async Nat {
        versionNumber += 1;
        counter += n;
        return counter;
    };
    public query func showCounter() : async Nat {
        return counter;
    };
    public query func showVersionNumber() : async Nat {
        return versionNumber;
    };
    // Challenge 19 : In a new file, copy and paste the functionnalities you've created in challenges 12 to 15. This time the hashmap and all records should be preserved accross upgrades.
    //file: hashMapRewrite.mo
    
};
