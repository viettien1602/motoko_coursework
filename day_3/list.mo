import Array "mo:base/Array";

module CustomList {
    public type List<T> = ?(T, List<T>);

    // Challenge 7 : Write a function is_null that takes l of type List<T> and returns a boolean indicating if the list is null . Tips : Try using a switch/case.
    public func is_null<T>(l : List<T>) : Bool {
        switch(l) {
            case(null) return true;
            case(?l) return false;
        };
    };

    // Challenge 8 : Write a function last that takes l of type List<T> and returns the optional last element of this list.
    public func last<T>(l : List<T>) : ?T {
        switch(l) {
            case(null) return null;
            case(?(value, null)) return ?value;
            case(?(value, nextList)) return (last<T>(nextList));
        }
    };

    // Challenge 9 : Write a function size that takes l of type List<T> and returns a Nat indicating the size of this list.
    // Note : If l is null , this function will return 0.
    public func size<T>(l : List<T>) : Nat {
        switch(l) {
            case(null) return 0;
            case(?(value, null)) return 1;
            case(?(value, nextList)) return (1 + size<T>(nextList));
        }
    };

    // Challenge 10 : Write a function get that takes two arguments : l of type List<T> and n of type Nat this function should return the optional value at rank n in the list.
    public func get<T>(l : List<T>, n : Nat) : ?T {
        var index : Nat = 0;
        switch(l, n) {
            case(null, _) return null;
            case(?(value, nextList), 0) return ?value;
            case(?(value, nextList), n) return get<T>(nextList, n - 1);
        }
    };

}