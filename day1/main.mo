import Debug "mo:base/Debug";
import Array "mo:base/Array";
import Nat "mo:base/Nat";

actor Demo {
  
  //challenge 1
  public func add(n : Nat, m : Nat) : async Nat {
    return (n + m);
  };

  //challenge 2
  public func square(n : Nat) : async Nat {
    return (n * n);
  };

  //challenge 3
  public func daysToSecond(n : Nat) : async Nat {
    return (n * 86400);
  };

  //challenge 4
  var counter : Nat = 0;
  public func increment_counter(n : Nat) : async Nat {
    counter += n;
    return counter
  };
  public func clear_counter() {
    counter := 0;
  };

  //challenge 5
  public func divide(n : Nat, m  : Nat) : async Bool {
    if (m == 0) {
      Debug.print(debug_show("Divide by 0"));
      return false;
    }
    else {
      if (n % m == 0) {
        return true;
      }
      else {
        return false;
      }
    };
  };

  //challenge 6
  public func isEven(n : Nat) : async Bool {
    if (n % 2 == 0) {
      return true;
    }
    else {
      return false;
    }
  };

  //challenge 7
  public func sumOfArray(ar : [Nat]) : async Nat {
    var sum : Nat = 0;
    for (value in ar.vals()) {
      sum += value;
    };
    return sum;
  };

  //challenge 8
  public func maximum(ar : [Nat]) : async Nat {
    var max : Nat = 0;
    if (ar.size() == 0) {
      return max;
    };
    for (value in ar.vals()) {
      if (max < value) {
        max := value;
      }
    };
    return max;
  };

  //challenge 9
  public func removeFromArray(ar : [Nat], n : Nat) : async [Nat] {
    return Array.filter(ar, func(value : Nat) : Bool {
      return value != n;
    });
  };

  //challenge 10
  public func selectionSort(ar : [Nat]) : async [Nat] {
    let newAr : [var Nat] = Array.thaw(ar); //immutable to mutable
    var i : Nat = 0;
    var j : Nat = 0;
    var temp : Nat = 0;
    var size = ar.size();
    while (i < size - 1) {
      j := i + 1;
      while (j < size) {
        if (newAr[i] > newAr[j]) {
          temp := newAr[i];
          newAr[i] := newAr[j];
          newAr[j] := temp;
        };
        j += 1;
      };
      i += 1;
    };
    return Array.freeze(newAr); //mutable to immutable
  };

  //challenge 10 other method 
  public func sortArray(ar : [Nat]) : async [Nat] {
    return Array.sort(ar, Nat.compare);
  };
}
