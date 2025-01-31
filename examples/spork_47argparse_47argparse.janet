(import spork)

(def argparse-params
  ["An example CLI tool."
   "my-flag" {:kind :flag
              :short "f"
              :help "set my-flag"}
   "my-opt" {:kind :option
             :short "o"
             :help "Value for option"
             :default "DEFAULT VALUE"}
   "my-req" {:kind :option
             :short "r"
             :required true}])

(def cli-args (spork/argparse/argparse ;argparse-params))

(unless cli-args
  (os/exit 1))

(print "flag: " (get cli-args "my-flag"))
(print "my-opt: " (get cli-args "my-opt"))
(print "my-req: " (get cli-args "my-req"))
