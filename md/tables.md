{% (def title "Tables") %}

Tables are one of the most flexible data structures in Janet that
is modelled after the associative array, or dictionary. Values are
put into a table with a key, and can be looked up later with the
same key. Tables are implemented with an underlying open hash table, so
they are quite fast and do not make many allocations.

Any Janet value except nil can either a key or a value in a Janet
table, and a single Janet table can have any mixture of
types as keys and values.
