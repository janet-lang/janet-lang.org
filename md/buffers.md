{%
(def title "Buffers")
(def description "Janet buffers contain a sequence of byte
 values. They can be used to represent mutable strings, or to
 represent arbitrary memory.")
%}

Buffers in Janet are the mutable version of strings. Since strings
in Janet can hold any sequence of bytes, including zeros, buffers share
this same property and can be used to hold any arbitrary memory, which
makes them very simple but versatile data structures. They can be
used to accumulate small strings into a large string, to implement
a bitset, or to represent sound or images in a program.

## Creating Buffers

A Buffer literal looks like a string literal, but prefixed with an
at symbol `@`.

```janet
(def my-buf @"This is a buffer.")

(defn make-buffer
 "Creates a buffer"
 []
 @"a new buffer")

(make-buffer) # -> @"a new buffer"
(= (make-buffer) (make-buffer)) # -> false
# All buffers are unique - buffers are equal only to themselves.
```

## Getting bytes from a buffer

To get bytes from a buffer, use the `get` function that works
on all builtin data structures. Bytes in a buffer are indexed from
0, and each byte is considered an integer from 0 to 255.

```janet
(def buf @"abcd")

(get buf 0) # -> 97
(0 buf) # -> 97

# Use destructuring to print 4
# bytes of a buffer.
(let [[b1 b2 b3 b4] buf]
 (print b1)
 (print b2)
 (print b3)
 (print b4))
```

One can also use the `string/slice` or `buffer/slice` functions
to get sub strings (or sub buffers) from inside any sequence of bytes.

```janet
(def buf @"abcdefg")
(def buf1 (buffer/slice buf)) # -> @"abcdef", but a different buffer
(def buf2 (buffer/slice buf 2)) # -> @"cdefg"
(def buf3 (buffer/slice buf 2 -2)) # -> @"cdef"

# string/slice works the same way, but returns strings.
```

## Setting bytes in a buffer

Buffers are mutable, meaning we can add bytes or change bytes in
an already created buffer. Use the `put` function to set individual
bytes in a buffer at a given byte index. Buffers will be expanded
as needed if an index out of the range is provided.

```janet
(def b @"")
(put b 0 97) #-> @"a"
(put b 10 97) #-> @"a\0\0\0\0\0\0\0\0\0a"
```

The `set` special form also works for setting bytes in a buffer.

```janet
(def b @"")
(set (b 0) 97) #-> @"a"
(set (b 10) 97) #-> @"a\0\0\0\0\0\0\0\0\0a"
```

The main difference between `set` and `put` is that `set` will return the byte
value, while `put` will return the buffer value.

## Pushing bytes to a buffer

There are also many functions to push data into a buffer. Since buffers
are commonly used to accumulate data, there are a variety of functions
for pushing data into a buffer.

* `buffer/push-byte`
* `buffer/push-word`
* `buffer/push-string`

See the documentation for these functions in the [Core API](/doc.html#buffer/push-byte).
