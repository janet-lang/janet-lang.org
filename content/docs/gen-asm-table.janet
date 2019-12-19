(import mendoza/markup-env :as menv)

(defn- to-row
  [[inst sig desc]]
  {:tag "tr" :content [{:tag "td" :content (menv/code inst)}
                       {:tag "td" :content (menv/code (string/format "%.20p" sig))}
                       {:tag "td" :content desc}]})
(def- instrs
  [['add '(add dest lhs rhs) "$dest = $lhs + $rhs"]
   ['addim '(addim dest lhs im) "$dest = $lhs + im"]
   ['band '(band dest lhs rhs) "$dest = $lhs & $rhs"]
   ['bnot '(bnot dest operand) "$dest = ~$operand"]
   ['bor '(bor dest lhs rhs) "$dest = $lhs | $rhs"]
   ['bxor '(bxor dest lhs rhs) "$dest = $lhs ^ $rhs"]
   ['call '(call dest callee) "$dest = call($callee, args)"]
   ['clo '(clo dest index) "$dest = closure(defs[$index])"]
   ['cmp '(cmp dest lhs rhs) "$dest = janet_compare($lhs, $rhs)"]
   ['div '(div dest lhs rhs) "$dest = $lhs / $rhs"]
   ['divim '(divim dest lhs im) "$dest = $lhs / im"]
   ['eq '(eq dest lhs rhs) "$dest = $lhs == $rhs"]
   ['eqim '(eqim dest lhs im) "$dest = $lhs == im"]
   ['eqn '(eqn dest lhs im) "$dest = $lhs .== $rhs"]
   ['err '(err message) "Throw error $message."]
   ['get '(get dest ds key) "$dest = $ds[$key]"]
   ['geti '(geti dest ds index) "$dest = $ds[index]"]
   ['gt '(gt dest lhs rhs) "$dest = $lhs > $rhs"]
   ['gten '(gten dest lhs rhs) "$dest = $lhs .>= $rhs"]
   ['gtim '(gtim dest lhs im) "$dest = $lhs .> im"]
   ['gtn '(gtn dest lhs rhs) "$dest = $lhs .> $rhs"]
   ['jmp '(jmp label) "pc = label, pc += offset"]
   ['jmpif '(jmpif cond label) "if $cond pc = label else pc++"]
   ['jmpno '(jmpno cond label) "if $cond pc++ else pc = label"]
   ['ldc '(ldc dest index) "$dest = constants[index]"]
   ['ldf '(ldf dest) "$dest = false"]
   ['ldi '(ldi dest integer) "$dest = integer"]
   ['ldn '(ldn dest) "$dest = nil"]
   ['lds '(lds dest) "$dest = current closure (self)"]
   ['ldt '(ldt dest) "$dest = true"]
   ['ldu '(ldu dest env index) "$dest = envs[env][index]"]
   ['len '(len dest ds) "$dest = length(ds)"]
   ['lt '(lt dest lhs rhs) "$dest = $lhs < $rhs"]
   ['lten '(lten dest lhs rhs) "$dest = $lhs .<= $rhs"]
   ['ltim '(ltim dest lhs im) "$dest = $lhs .< im"]
   ['ltn '(ltn dest lhs rhs) "$dest = $lhs .< $rhs"]
   ['mkarr '(mkarr dest) "$dest = call(array, args)"]
   ['mkbtp '(mkbtp dest) "$dest = call(tuple/brackets, args)"]
   ['mkbuf '(mkbuf dest) "$dest = call(buffer, args)"]
   ['mkstr '(mkstr dest) "$dest = call(string, args)"]
   ['mkstu '(mkstu dest) "$dest = call(struct, args)"]
   ['mktab '(mktab dest) "$dest = call(table, args)"]
   ['mktup '(mktup dest) "$dest = call(tuple, args)"]
   ['movf '(movf src dest) "$dest = $src"]
   ['movn '(movn dest src) "$dest = $src"]
   ['mul '(mul dest lhs rhs) "$dest = $lhs * $rhs"]
   ['mulim '(mulim dest lhs im) "$dest = $lhs * im"]
   ['noop '(noop) "Does nothing."]
   ['prop '(prop val fiber) "Propagate (Re-raise) a signal that has been caught."]
   ['push '(push val) "Push $val on arg"]
   ['push2 '(push2 val1 val3) "Push $val1, $val2 on args"]
   ['push3 '(push3 val1 val2 val3) "Push $val1, $val2, $val3, on args"]
   ['pusha '(pusha array) "Push values in $array on args"]
   ['put '(put ds key val) "$ds[$key] = $val"]
   ['puti '(puti ds index val) "$ds[index] = $val"]
   ['res '(res dest fiber val) "$dest = resume $fiber with $val"]
   ['ret '(ret val) "Return $val"]
   ['retn '(retn) "Return nil"]
   ['setu '(setu env index val) "envs[env][index] = $val"]
   ['sig '(sig dest value sigtype) "$dest = emit $value as sigtype"]
   ['sl '(sl dest lhs rhs) "$dest = $lhs << $rhs"]
   ['slim '(slim dest lhs shamt) "$dest = $lhs << shamt"]
   ['sr '(sr dest lhs rhs) "$dest = $lhs >> $rhs"]
   ['srim '(srim dest lhs shamt) "$dest = $lhs >> shamt"]
   ['sru '(sru dest lhs rhs) "$dest = $lhs >>> $rhs"]
   ['sruim '(sruim dest lhs shamt) "$dest = $lhs >>> shamt"]
   ['sub '(sub dest lhs rhs) "$dest = $lhs - $rhs"]
   ['tcall '(tcall callee) "Return call($callee, args)"]
   ['tchck '(tcheck slot types) "Assert $slot matches types"]])

(defn gen
  "Reference table for assembly instructions."
  []
  {:tag "table"
   :content [{:tag "tr" :content [{:tag "th" :content "Instruction"}
                                  {:tag "th" :content "Signature"}
                                  {:tag "th" :content "Description"}]}
             ;(map to-row instrs)]})

