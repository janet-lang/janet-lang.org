(function() {
  var ansi_up = new AnsiUp;
  var printRaw = (function () {
    var element = document.getElementById('replterm');
    if (element) element.textContent = ''; // clear browser cache
    return function (text) {
      if (element) {
        element.innerHTML += text;
        element.scrollTop = element.scrollHeight; // focus on bottom
      }
    }
  })();

  function htmlEscape(text) {
    text = ansi_up.ansi_to_html(text);
    text = text.replace('\n', '<br>', 'g');
    return text;
  }

  function cleanContentEditableInput(text) {
    text = text.replace(/\u00A0/g, " ");
    return text;
  }

  function print(text) {
    if (arguments.length > 1) text = Array.prototype.slice.call(arguments).join(' ');
    printRaw(htmlEscape(text));
  }

  // Don't print initial errors
  var errorsReady = false;

  // Line history
  var replHistory = [''];
  var historyIndex = 0;

  // prevent infinite restarts
  var restartCount = 0;

  var Module = {
    preRun: [],
    print: function(x) {
      print(x + '\n');
    },
    printErr: function(text) {
      if (arguments.length > 1) text = Array.prototype.slice.call(arguments).join(' ');
      if (errorsReady) {
        printRaw('<span style="color:#E55;">' + htmlEscape(text + '\n') + '</span>')
      } else {
        console.error(text);
      }
    },
    postRun: [function() {
      Module._repl_init()
      var repl_input = Module.cwrap('repl_input', 'void', ['string']);
      var repl_prompt = Module.cwrap('repl_prompt', 'string', []);
      var promptel = document.getElementById('replprompt');
      promptel.textContent = repl_prompt();
      document.getElementById('replin').addEventListener('keydown', (e) => {
        const srcElement = e.target || srcElement;
        if (e.keyCode === 13) {
          const content = srcElement.textContent;
          const text = cleanContentEditableInput(content + '\n');
          replHistory.pop();
          replHistory.push(content);
          historyIndex = replHistory.length;
          replHistory.push('');
          srcElement.textContent = '';
          printRaw('<span style="color:#9198e5;">' + htmlEscape(repl_prompt() + text) + '</span>')
          repl_input(text);
          promptel.textContent = repl_prompt();
        } else if (e.keyCode === 38) {
          if (historyIndex > 0) {
            if (historyIndex === replHistory.length - 1) {
              replHistory.pop()
              replHistory.push(srcElement.textContent)
            }
            historyIndex--;
            srcElement.textContent = replHistory[historyIndex];
          }
        } else if (e.keyCode === 40) {
          if (historyIndex < replHistory.length - 1) {
            if (historyIndex === replHistory.length - 1) {
              replHistory.pop()
              replHistory.push(srcElement.textContent)
            }
            historyIndex++;
            srcElement.textContent = replHistory[historyIndex];
          }
        }
      });
      errorsReady = true;
    }],
  };

  window.onerror = function (code) {
    const element = document.getElementById('replterm');
    if (restartCount > 100) {
      element.innerHTML = '<span style="color:#E55">Repl restarted too many times. Browser may be unsupported.<span><br>';
    } else {
      restartCount++;
      element.innerHTML = '<span style="color:#E55">Restarting repl...</span><br>';
      Module._repl_deinit();
      Module._repl_init();
    }
  };

  window.Module = Module;
})();
