(string/check-set :abcdef 'deadbeef) # -> true

(string/check-set "acdefilop" "encyclopedia") # -> false

(string/check-set "acgt" @"gattaca") # -> true
