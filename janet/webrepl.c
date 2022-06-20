/*
* Copyright (c) 2019 Calvin Rose
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to
* deal in the Software without restriction, including without limitation the
* rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
* sell copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
* IN THE SOFTWARE.
*/

#include <janet.h>
#include <emscripten.h>

static const char startup[] =
"(print (string `Janet ` janet/version `-` janet/build ` ` (os/which) `/` (os/arch) ` - '(doc)' for help`))\n"
"(fiber/new (fn webrepl []\n"
"             (setdyn :pretty-format `%.20P`)\n"
"             (repl (fn get-line [buf p]\n"
"                     (def [offset] (parser/where p))\n"
"                     (def prompt (string `janet:` offset `:` (parser/state p :delimiters) `> `))\n"
"                     (repl-yield prompt buf)\n"
"                     (yield)\n"
"                     buf))))";

extern const unsigned char *janet_gen_webinit;
extern int32_t janet_gen_webinit_size;

static JanetFiber *repl_fiber = NULL;
static JanetBuffer *line_buffer = NULL;
static const uint8_t *line_prompt = NULL;

/* Yield to JS event loop from janet. Takes a repl prompt
 * and a buffer to fill with input data. */
JANET_FN(repl_yield, "(repl-yield prompt buf)",
        "Yield to the repl line prompt") {
    janet_fixarity(argc, 2);
    line_prompt = janet_getstring(argv, 0);
    line_buffer = janet_getbuffer(argv, 1);
    return janet_wrap_nil();
}

/* Re-enter the loop */
static int enter_loop(void) {
    Janet ret;
    JanetSignal status = janet_continue(repl_fiber, janet_wrap_nil(), &ret);
    if (status == JANET_SIGNAL_ERROR) {
        janet_stacktrace(repl_fiber, ret);
        janet_deinit();
        repl_fiber = NULL;
        return 1;
    }
    return 0;
}

/* Allow JS interoperation from within janet */
JANET_FN(cfun_js, "(js source)",
        "Execute raw JS source code") {
    janet_fixarity(argc, 1);
    JanetByteView bytes = janet_getbytes(argv, 0);
    emscripten_run_script((const char *)bytes.bytes);
    return janet_wrap_nil();
}

/* Initialize the repl */
EMSCRIPTEN_KEEPALIVE
void repl_init(void) {
    int status;
    JanetTable *env;

    /* Set up VM */
    janet_init();
    env = janet_core_env(NULL);

    const JanetRegExt regs[] = {
        JANET_REG("repl-yield", repl_yield),
        JANET_REG("js", cfun_js),
        JANET_REG_END
    };

    janet_cfuns_ext(env, NULL, regs);

    /* Run startup script */
    Janet ret;
    status = janet_dostring(env, startup, "webinit.janet", &ret);
    if (status == JANET_SIGNAL_ERROR) {
        printf("start up error.\n");
        janet_deinit();
        repl_fiber = NULL;
        return;
    }
    janet_gcroot(ret);
    repl_fiber = janet_unwrap_fiber(ret);

    /* Start repl */
    if (enter_loop()) return;
}

/* Deinitialize the repl */
EMSCRIPTEN_KEEPALIVE
void repl_deinit(void) {
    if (!repl_fiber) {
        return;
    }
    repl_fiber = NULL;
    line_buffer = NULL;
    janet_deinit();
}

/* Get the prompt to show in the repl */
EMSCRIPTEN_KEEPALIVE
const char *repl_prompt(void) {
    return line_prompt ? ((const char *)line_prompt) : "";
}

/* Restart the repl calling from JS. Pass in the input for the next line. */
EMSCRIPTEN_KEEPALIVE
void repl_input(char *input) {

    /* Create the repl if we haven't yet */
    if (!repl_fiber) {
        printf("initialize the repl first");
    }

    /* Now fill the pending line_buffer and resume the repl loop */
    if (line_buffer) {
        janet_buffer_push_cstring(line_buffer, input);
        line_buffer = NULL;
        enter_loop();
    }
}
