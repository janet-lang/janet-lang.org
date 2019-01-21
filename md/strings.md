{% (def title "Strings, Keywords, and Symbols") %}

Janet supports several varieties of types that can be used as labels for things in
your program. The most useful type for this purpose is the keyword type. A keyword
begins with a semicolon, and then contains 0 or more alphanumeric or a few other common
characters. For example, `:hello`, `:my-name`, `::`, and `:ABC123_-*&^%$` are all keywords.

Keywords, symbols, and strings all behave similarly and can be used as keys for tables and structs.
Symbols and keywords are optimized for fast equality checks, so are preferred for table keys.

The difference between symbols and keywords is that keywords evaluate to themselves, while
symbols evaluate to whatever they are bound to. To have a symbol evaluate to itself, it must be
quoted.

```janet
# Evaluates to :monday
:monday

# Will throw a compile error as monday is not defined
monday

# Quote it - evaluates to the symbol monday
'monday

# Our first define, 'monday'
(def monday "It is monday")

# Now the evaluation should work - monday evaluates to "It is monday"
monday
```

The most common thing to do with a keyword is to check it for equality or use it as a key into
a table or struct. Note that symbols, keywords and strings are all immutable. Besides making your
code easier to reason about, it allows for many optimizations involving these types.

```janet
# Evaluates to true
(= :hello :hello)

# Evaluates to false, everything in janet is case sensitive
(= :hello :HeLlO)

# Look up into a table - evaluates to 25
(get {
    :name "John"
    :age 25
    :occupation "plumber"
} :age)
```

Strings can be used similarly to keywords, but there primary usage is for defining either text
or arbitrary sequences of bytes. Strings (and symbols) in janet are what is sometimes known as
"8-bit clean"; they can hold any number of bytes, and are completely unaware of things like character
encodings. This is completely compatible with ASCII and UTF-8, two of the most common character
encodings. By being encoding agnostic, janet strings can be very simple, fast, and useful for
for other uses besides holding text.

Literal text can be entered inside quotes, as we have seen above.

```janet
"Hello, this is a string."

# We can also add escape characters for newlines, double quotes, backslash, tabs, etc.
"Hello\nThis is on line two\n\tThis is indented\n"

# For long strings where you don't want to type a lot of escape characters,
# you can use 1 or more backticks (`) to delimit a string.
# To close this string, simply repeat the opening sequence of backticks
``
This is a string.
Line 2
    Indented
"We can just type quotes here", and backslashes \ no problem.
``
```

Strings, symbols, and keywords can all contain embedded utf-8. It is recomended
to embed utf-8 literally in strings rather than escaping it if it is printable.

```janet
"Hello, 👍"
```
