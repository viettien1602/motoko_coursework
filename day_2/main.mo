import Debug "mo:base/Debug";
import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Nat "mo:base/Nat";
import Char "mo:base/Char";
import Text "mo:base/Text";
import Array "mo:base/Array";
import Prim "mo:prim";
import Iter "mo:base/Iter";
import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";

actor Day_2 {
    // Challenge 1 : Write a function nat_to_nat8 that converts a Nat n to a Nat8. Make sure that your function never trap.
    public func nat_to_nat8(n : Nat) : async Nat8 {
        if (n < 256){
            return (Nat8.fromNat(n));
        }
        else {
            return 0;
        };
    };
    // Challenge 2 : Write a function max_number_with_n_bits that takes a Nat n and returns the maximum number than can be represented with only n-bits.
    public func max_number_with_n_bits(n : Nat) : async Nat {
        return (2 ** n - 1);
    };
    // Challenge 3 : Write a function decimal_to_bits that takes a Nat n and returns a Text corresponding to the binary representation of this number.
    // Note : decimal_to_bits(255) -> "11111111".
    public func decimal_to_bits(n : Nat) : async Text {
        var binaryNum : Nat = 0;
        var i : Nat = 0;
        var temp : Nat = n;
        while (temp != 0) {
            binaryNum += (temp % 2) * (10 ** i);
            i += 1;
            temp := temp / 2;
        };
        return Nat.toText(binaryNum);
    };
    // Challenge 4 : Write a function capitalize_character that takes a Char c and returns the capitalized version of it.
    public func capitalize_character(c : Nat32) : async Text {
        var temp = c;
        if (temp >= 97 and temp <= 122) {
            temp := temp - 32;
        };
        return Char.toText(Char.fromNat32(temp));
    };
    
    // Challenge 5 : Write a function capitalize_text that takes a Text t and returns the capitalized version of it.
    public func capitalize_text(t : Text) : async Text {
        return Text.map(t, Prim.charToUpper);
    };
    // Challenge 6 : Write a function is_inside that takes two arguments : a Text t and a Char c and returns a Bool indicating if c is inside t .
    public func is_inside(t : Text, c : Char) : async Bool {
        return Text.contains(t, #char c);
    };
     
    // Challenge 7 : Write a function trim_whitespace that takes a text t and returns the trimmed version of t. Note : Trim means removing any leading and trailing spaces from the text : trim_whitespace(" Hello ") -> "Hello".
    public func trim_whitespace(t : Text) : async Text {
        return Text.trim(t, #char ' ');
    };
    // Challenge 8 : Write a function duplicated_character that takes a Text t and returns the first duplicated character in t converted to Text. Note : The function should return the whole Text if there is no duplicate character : duplicated_character("Hello") -> "l" & duplicated_character("World") -> "World".
    public func duplicated_character(t : Text) : async Text {
        type hashMap = HashMap.HashMap<Nat, Text>;
        var textHashMap : hashMap = HashMap.HashMap(32, Nat.equal, Hash.hash);
        for (char in t.chars()) {
            if (textHashMap.get(Nat32.toNat(Char.toNat32(char))) == null) {
                textHashMap.put(Nat32.toNat(Char.toNat32(char)), Char.toText(char));
            }
            else {
                return Char.toText(char);
            };
        };
        return t;
    };
    // Challenge 9 : Write a function size_in_bytes that takes Text t and returns the number of bytes this text takes when encoded as UTF-8.
    public func size_in_bytes(t : Text) : async Nat {
        var text : Blob = Text.encodeUtf8(t);
        return text.size();
    };
    // Challenge 10 :
    // Watch this video on bubble sort.
    // Implement a function bubble_sort that takes an array of natural numbers and returns the sorted array .
    public func bubbleSort(ar : [Nat]) : async [Nat] {
        var array : [var Nat] = Array.thaw(ar);
        for (i in Iter.range(2, array.size())) {
            for (j in Iter.range(0, array.size() - i)) {
                if (array[j] > array[j + 1]) {
                    var temp = array[j];
                    array[j] := array[j + 1];
                    array[j + 1] := temp;
                 };
            };
        };
        return Array.freeze(array);
    };
    // Challenge 11 : Write a function nat_opt_to_nat that takes two parameters : n of type ?Nat and m of type Nat . This function will return the value of n if n is not null and if n is null it will default to the value of m.
    public func nat_opt_to_nat(n : ?Nat, m : Nat) : async Nat {
        switch(n) {
            case(null) return m;
            case(?value) return value;
        };
    };
    // Challenge 12 : Write a function day_of_the_week that takes a Nat n and returns a Text value corresponding to the day. If n doesn't correspond to any day it will return null .
    // day_of_the_week (1) -> "Monday".
    // day_of_the_week (7) -> "Sunday".
    // day_of_the_week (12) -> null.
    public func day_of_the_week(n : Nat) : async ?Text {
        var day : ?Text = null;
        switch(n) {
            case(1) day := ?"Monday";
            case(2) day := ?"Tuesday";
            case(3) day := ?"Wednesday";
            case(4) day := ?"Thursday";
            case(5) day := ?"Friday";
            case(6) day := ?"Saturday";
            case(7) day := ?"Sunday";
            case(default) day := null;
        };
        return day;
    };
    // Challenge 13 : Write a function populate_array that takes an array [?Nat] and returns an array [Nat] where all null values have been replaced by 0.
    // Note : Do not use a loop.
    public func populate_array(ar : [?Nat]) : async [Nat] {
        return Array.map(ar, func(value : ?Nat) : Nat {
            switch(value) {
                case(null) return 0;
                case(?v) return v;
            };
        });
    };
    // Challenge 14 : Write a function sum_of_array that takes an array [Nat] and returns the sum of a values in the array.
    // Note : Do not use a loop.
    public func sum_of_array(ar : [Nat]) : async Nat {
        // var sum : Nat = 0;
        // var newAr : [Nat] = Array.map(ar, func(value : Nat) : Nat {
        //     sum += value;
        //     return value;
        // }); 
        // return sum;  
        return Array.foldRight(ar, 0, Nat.add);
    };

    // Challenge 15 : Write a function squared_array that takes an array [Nat] and returns a new array where each value has been squared.
    // Note : Do not use a loop.
    public func squared_array(ar : [Nat]) : async [Nat] {
        return Array.map(ar, func(value : Nat) : Nat {
            return value ** 2;
        });
    };
    // Challenge 16 : Write a function increase_by_index that takes an array [Nat] and returns a new array where each number has been increased by it's corresponding index.
    // Note : increase_by_index [1, 4, 8, 0] -> [1 + 0, 4 + 1 , 8 + 2 , 0 + 3] = [1,5,10,3]
    // Note 2 : Do not use a loop.
    public func increase_by_index(ar : [Nat]) : async [Nat] {
        var i : Nat = 0;
        return Array.map(ar, func(value : Nat) : Nat {
            var result = value + i;
            i += 1;
            return result;
        });
    };
    // Challenge 17 : Write a higher order function contains<A> that takes 3 parameters : an array [A] , a of type A and a function f that takes a tuple of type (A,A) and returns a boolean.
    // This function should return a boolean indicating whether or not a is present in the array.
    func contains<A>(ar : [A], a : A, f : (A, A) -> Bool) : Bool {
        for (value in ar.vals()) {
            if (f(value, a)) {
                return true;
            }
        };
        return false;
    };
    public func checkContain(ar : [Nat], n : Nat) : async Bool {
        return contains(ar, n, func(a : Nat, b : Nat) : Bool {
            return a == b;
        });
    };
};
