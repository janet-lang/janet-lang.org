{% (def title "Numbers and Arithmetic") %}

Any programming language will have some way to do arithmetic. Janet is no exception,
and supports the basic arithmetic operators

```janet
# Prints 13
# (1 + (2*2) + (10/5) + 3 + 4 + (5 - 6))
(print (+ 1 (* 2 2) (/ 10 5) 3 4 (- 5 6)))
```

Just like the print function, all arithmetic operators are entered in
prefix notation. Janet also supports the remainder operator, or `%`, which returns
the remainder of division. For example, `(% 10 3)` is 1, and `(% 10.5 3)` is
1.5. The lines that begin with `#` are comments.

All janet numbers are IEEE 754 double precision floating point numbers. They can be used to represent
both integers and real numbers to a finite precision.

## Numeric literals

Numeric literals can be written in many ways. Numbers can be written in base 10, with
underscores used to separate digits into groups. A decimal point can be used for floating
point numbers. Numbers can also be written in other bases by prefixing the number with the desired
base and the character 'r'. For example, 16 can be written as `16`, `1_6`, `16r10`, `4r100`, or `0x10`. The
`0x` prefix can be used for hexadecimal as it is so common. The radix must be themselves written in base 10, and
can be any integer from 2 to 36. For any radix above 10, use the letters as digits (not case sensitive).

Numbers can also be in scientific notation such as `3e10`. A custom radix can be used as well
as for scientific notation numbers, (the exponent will share the radix). For numbers in scientific
notation with a radix besides 10, use the `&` symbol to indicate the exponent rather then `e`.

## Arithmetic Functions

Besides the 5 main arithmetic functions, janet also supports a number of math functions
taken from the C library `<math.h>`, as well as bit-wise operators that behave like they
do in C or Java. Functions like `math/sin`, `math/cos`, `math/log`, and `math/exp` will
behave as expected to a C programmer. They all take either 1 or 2 numeric arguments and
return a real number (never an integer!) Bit-wise functions are all prefixed with b.
They are `bnot`, `bor`, `bxor`, `band`, `blshift`, `brshift`, and `brushift`. Bit-wise
functions only work on integers.

See the [Core Library API](doc.html#math/acos) for info on functions in the `math/` namespace.

