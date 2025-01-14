# janet-lang.org

[![Zulip](https://img.shields.io/badge/zulip-join_chat-brightgreen.svg)](https://janet.zulipchat.com)

This is the source code for the website of the [Janet](https://janet-lang.org) programming
language. It is a static website built with [mendoza](https://github.com/bakpakin/mendoza), a
static site generator.

## Prereqs

Build this website using the bundled janet amalgamated source.

```sh
git clone https://github.com/janet-lang/janet-lang.org
cd janet-lang.org
make
make run
```

## Building

To build, simply use `make` or `make build`.

## Watch for changes

This requires first installing `inotify-tools`, which can be installed easily on most Linux distros.
To watch for changes, use `make watch`.

## Serve on localhost:8000

```
make run
```

## Authoring Content

All pages in the content directory with `.mdz` extension will be parsed by mendoza
and converted to an html file of the same name but with the `.html` extension. The markup
language is similar to [Scribble](https://docs.racket-lang.org/scribble/), the Racket
documentation tool, but of course is written in and is a dialect of Janet. See
[mendoza](https://github.com/bakpakin/mendoza) for more information.

## Adding Examples

Simply add a file with the name of the binding you are giving examples for to the examples
directory, with the `.janet` suffix. If the binding includes any of the following characters `%*/:<>?`, replace it with
an underscore followed by its ascii character code.

|Symbol | Replacement|
|-------|------------|
|%      |_37         |
|*      |_42         |
|/      |_47         |
|:      |_58         |
|<      |_60         |
|>      |_62         |
|?      |_63         |

For example, the binding `string/has-prefix?` has examples in the `examples/string_47has-prefix_63.janet` file.

If such a file already exists, you can simply append your example code the existing file.

When building the site, the new examples will be included in the generated documentation. Make
sure that your example has correct janet syntax, as syntax errors will cause the entire site
to not build. If the example has valid syntax (has a 0 exit code when loaded with
        `janet -k example/my-fn.janet`), there may be a bug in the mendoza janet syntax
highlighter and you open a bug in mendoza.
