import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";

actor hashMapRewrite {

    stable var entries : [(Principal, Nat)] = [];
    // entries := [];
    let favoriteNumber = HashMap.fromIter<Principal, Nat>(
    entries.vals(), 10, Principal.equal, Principal.hash);

    //add
    public shared({caller}) func add_favorite_number(n : Nat) : async Text {
        if (favoriteNumber.get(caller) == null) {
            favoriteNumber.put(caller, n);
            return "You've successfully registered your number";
        }
        else {
            return "You've already registered your number";
        };
    };

    //read
    public shared({caller}) func show_favorite_number() : async ?Nat {
        switch(Principal.toText(caller)) {
            case("2vxsx-fae") return null;
            case(_) return favoriteNumber.get(caller);
        }
    };

    //update
    public shared({caller}) func update_favorite_number(n : Nat) : async Text {
        if (favoriteNumber.get(caller) == null) {
            return "You haven't registered your number";
        }
        else {
            var preValue = favoriteNumber.replace(caller, n);
            return "You've successfully changed your number";
        };
    };
    //delete
    public shared({caller}) func delete_favorite_number() : async Text {
        if (favoriteNumber.get(caller) == null) {
            return "You haven't registered your number";
        }
        else {
            var delValue = favoriteNumber.remove(caller);
            return "You've successfully removed your number";
        };
    };


    system func preupgrade() {
      entries := Iter.toArray(favoriteNumber.entries());
    };

    system func postupgrade() {
      entries := [];
    };
};