# janet-lang.org

This is the source code for the website for the [Janet](https://janet-lang.org) programming
language. It is a static website built with [mendoza](https://github.com/bakpakin/mendoza), a
static site generator.

## Prereqs

The recommended way to build this website is to first install both Janet and mendoza. Below
is one way to do that for Linux systems.

### Installing Janet

```sh
git clone https://github.com/janet-lang/janet
cd janet
make -j 12
sudo make install
```

### Installing Mendoza

```sh
git clone https://github.com/bakpakin/mendoza
cd mendoza
sudo ./install
```

## Building

To build, simply use `make` or `mdz`

## Watch for changes

This requires first installing `inotify-tools`, which can be installed easily on most Linux distros.
To watch for changes, use `make watch` or `mdz watch`.

## Serve on localhost:8080

```
make serve
```

## Authoring Content

All pages in the content directory with `.mdz` extension will be parsed by mendoza
and converted to an html file of the same name but with the `.html` extension. The markup
language is similar to [Scribble](https://docs.racket-lang.org/scribble/), the Racket
documentation tool, but of course is written in and is a dialect of Janet. See
[mendoza](https://github.com/bakpakin/mendoza) for more information.
