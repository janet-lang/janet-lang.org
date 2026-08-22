(describe 1) # -> "1"

(describe nil) # -> "nil"

(describe true) # -> "true"

(describe "hi") # -> `"hi"`
(describe @"hi") # -> `@"hi"`
(describe 'hi) # -> "hi"
(describe :hi) # -> ":hi"

(string/has-prefix? "<tuple 0x" (describe [:a :b])) # -> true
(string/has-prefix? "<array 0x" (describe @[:a :b])) # -> true

(string/has-prefix? "<struct 0x" (describe {:x 1})) # -> true
(string/has-prefix? "<table 0x" (describe @{:x 1})) # -> true

(string/has-prefix? "<cfunction describe" (describe describe)) # -> true
(string/has-prefix? "<function pp" (describe pp)) # -> true

(string/has-prefix? "<fiber 0x" (describe (coro (yield :O)))) # -> true

(ffi/context nil)
(ffi/defbind memcpy :ptr [dest :ptr src :ptr n :size])
(string/has-prefix? "<pointer 0x" (describe (memcpy @"a" @"b" 1))) # -> true

(string/has-prefix? "<core/peg 0x" (describe (peg/compile 1))) # -> true

(= "<core/u64 1>" (describe 1:u)) # -> true
(= "<core/s64 1>" (describe 1:s)) # -> true
