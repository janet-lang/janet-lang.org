/*
Language: Janet
Description: Janet syntax (based on lisp.js)
Author: bakpakin
Contributors: Calvin Rose <calsrose@gmail.com>
Category: lisp
*/

hljs.registerLanguage('janet', function (hljs) {
  var keywords = {
    'builtin-name': 
    'def var while splice quote fn quaisquote '+
    "% %= & &= * *= *doc-width* *env* + ++ += - -- -= -> ->> / /= < << <<= <= = == > >= >> >>= >>> >>>= ^ ^= _env _fiber abstract? all all-symbols and apply array array/concat array/ensure array/insert array/new array/peek array/pop array/push array/slice array? asm bnot boolean? buffer buffer/clear buffer/new buffer/popn buffer/push-byte buffer/push-integer buffer/push-string buffer/slice buffer? bytes? callable? case cfunction? comment comp compile complement cond coro count debug debug/arg-stack debug/break debug/fbreak debug/lineage debug/stack debug/unbreak debug/unfbreak dec deep-not= deep= def- default defglobal defmacro defmacro- defn defn- describe dictionary? disasm distinct doc doc* doc-format drop-until drop-while each empty? env-lookup error eval eval-string even? every? extreme false? fiber/current fiber/maxstack fiber/new fiber/setmaxstack fiber/status fiber? file/close file/flush file/open file/popen file/read file/seek file/write filter find find-index first flatten flatten-into for frequencies function? gccollect gcinterval gcsetinterval generate gensym get getline hash idempotent? identity if-let if-not import import* inc indexed? int integer? interleave interpose invert janet/build janet/version juxt juxt* keep keys keyword? kvs last length let loop macex macex1 make-env map mapcat marshal match match-1 math/acos math/asin math/atan math/ceil math/cos math/e math/exp math/floor math/inf math/log math/log10 math/pi math/pow math/random math/seedrandom math/sin math/sqrt math/tan max max-order merge merge-into min min-order module/find module/native-paths module/paths native neg? next nil? not not= not== number? odd? one? or order< order<= order> order>= os/clock os/cwd os/execute os/exit os/getenv os/setenv os/shell os/sleep os/time os/which pairs parser/byte parser/consume parser/error parser/flush parser/new parser/produce parser/state parser/status parser/where partial pos? print process/args product put range real real? reduce repl require resume reverse run-context scan-integer scan-number scan-real sentinel seq some sort sorted status-pp stderr stdin stdout string string/ascii-lower string/ascii-upper string/bytes string/check-set string/find string/find-all string/from-bytes string/join string/number string/pretty string/repeat string/replace string/replace-all string/reverse string/slice string/split string? struct struct? sum symbol symbol? table table/getproto table/new table/rawget table/setproto table/to-struct table? take-until take-while true? tuple tuple/append tuple/prepend tuple/slice tuple? type unless unmarshal update values varglobal when when-let with-idemp yield zero? zipcoll | |="
  };

  var number_types = [];
  function syntaxNumber(prefix, expo, digit) {
    var dig = '[_' + digit + ']'
    number_types.push({
      r: 0,
      cN: 'number',
      b: '[-+]?' + prefix + '(' +
        dig + '+|' +
        dig + '+.' + dig + '*|' +
        '.' + dig + '+)(' + expo + '[-+]?[' + digit + ']+)?'
    });
  }
  var radix_chars = "0123456789abcdefghijklmnopqrstuvwxyz";
  for (var i = 2; i <= 36; i++) {
    syntaxNumber(i + 'r', '&', radix_chars.slice(0, i));
  }
  syntaxNumber('', '[&e]', '0123456789');
  syntaxNumber('0x', '&', '0123456789abcdef');

  var SYMBOLSTART = 'a-zA-Z_\\-!.?+*=<>&#~/@&\|\^\'';
  var SYMBOL_RE = '[' + SYMBOLSTART + '][' + SYMBOLSTART + '0-9/;:]*';
  var SIMPLE_NUMBER_RE = '[-+]?\\d+(\\.\\d+)?';

  var SYMBOL = {
    b: SYMBOL_RE,
    r: 0
  };
  var NUMBER = {
    cN: 'number', b: SIMPLE_NUMBER_RE,
    r: 0
  };
  var STRING = hljs.inherit(hljs.QSM, {illegal: null});
  var BUFFER = hljs.inherit(hljs.QSM, {b: '@"', illegal: null});
  var LONG_STRING = {
    cN: 'string',
    b: '\\`+',
    e: '\\`+'
  };
  var LONG_BUFFER = {
    cN: 'string',
    b: '@\\`+',
    e: '\\`+'
  };
  var COMMENT = hljs.C(
    '#',
    '$',
    {
      r: 0
    }
  );
  var LITERAL = {
    cN: 'literal',
    b: /\b(true|false|nil)\b/
  };
  var COLLECTION = {
    b: '[\\@[\\@{\\[\\{]', e: '[\\]\\}\\]\\}]'
  };
  var KEY = {
    cN: 'symbol',
    b: ':' + SYMBOL_RE
  };
  var LIST = {
    b: '\\(', e: '\\)'
  };
  var BODY = {
    eW: true,
    r: 0
  };
  var NAME = {
    k: keywords,
    l: SYMBOL_RE,
    cN: 'name', b: SYMBOL_RE,
    s: BODY
  };
  var DEFAULT_CONTAINS = ([LIST, BUFFER, STRING, LONG_STRING, COMMENT, KEY, COLLECTION]).concat(number_types).concat([LITERAL, SYMBOL]);

  LIST.c = [hljs.C('comment', ''), NAME, BODY];
  BODY.c = DEFAULT_CONTAINS;
  COLLECTION.c = DEFAULT_CONTAINS;

  return {
    aliases: ['janet'],
    i: /\S/,
    c: DEFAULT_CONTAINS
  }
});
hljs.initHighlightingOnLoad();
