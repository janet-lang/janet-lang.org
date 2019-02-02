{%
(def title "The String Library")
(def description "The string library in Janet provides most of the functionality
 for manipulating strings in Janet. The Janet string library provides a number
 of functions for selecting substrings, concatenating strings, and transforming
 strings.")
%}

The string is a basic type that represents a sequence of characters. Strings
are usually used to represent text, but since strings in Janet are "8 bit clean", they
can hold any sequence of bytes.
Strings are immutable, and can be compared for equality and
used as dictionary keys efficiently.

## Substrings

The `string/slice` function is used to get substrings from a string. Negative
integers can be used to index from the end of the string.

```janet
(string/slice "abcdefg") # -> "abcdefg"
(string/slice "abcdefg" 1) # -> "bcdefg"
(string/slice "abcdefg" 2 -2) # -> "cdef"
(string/slice "abcdefg" -4 -2) # -> "ef"
```

## Finding Substrings

Janet has multiple functions for finding and replacing strings. The
Janet string finding functions do not work on patterns or regular expressions;
they only work on string literals. For more flexible searching and replacing, see
the [peg module](/peg.html).

```janet
(string/find "h" "h h h h") #-> 0
(string/find-all "h" "h h h h") #-> @[0 2 4 6]
(string/replace "a" "b" "a a a a") #-> "b a a a"
(string/replace-all "a" "b" "a a a a") #-> "b b b b"
```

## Splitting Strings

The `string/split` function can be used to split strings or buffer on a delimiting
character. This can be used as a quick and dirty function for getting fields
from a csv line or getting words from a sentence.

```janet
(string/split "," "abc,def,ghi") #-> @["abc" "def" "ghi"]
(string/split " " "abc def ghi") #-> @["abc" "def" "ghi"]
```

## Concatenating strings

There are many ways to concatenate strings. The first, most common
way is the `string` function, which takes any number of arguments and
creates a string that is the concatenation of all of the arguments.

```janet
(string "abc" 123 "def") # -> "abc123def"
```

The second way is the `string/join` function, which takes an array
or tuple of strings and joins them together. `string/join` can also
take an optional separator string which is inserted between items in
the array. All items in the array or tuple must be byte sequences.

```janet
(string/join @["abc" "123" "def"]) #-> "abc123def"
(string/join @["abc" "123" "def"] ",") # -> "abc,123,def"
```

This has the advantage over the `string` function that one can
specify a separator. Otherwise, the behavior can be easily emulated
using the splice special form.

```janet
(= (string ;@["a" "b" "c"])
   (string/join @["a" "b" "c"])) # -> true
```

## Upper and lower case

The string library also provides facilities for converting strings to
upper case and lower case. However, only ascii is supported for case
transformations. The functions `string/ascii-upper` and `string/ascii-lower`
return a new string that has all character in the appropriate case.

```janet
(string/ascii-upper "aBcdef--*") #-> "ABCDEF--*"
(string/ascii-lower "aBc676A--*") #-> "abc676a--*"
```

## All functions

For a full listing of all functions in the string library, see
the [Core Library API](/doc.html#string/ascii-lower).
