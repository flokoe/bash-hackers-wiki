# Interpreter Directive

-   shebang

The interpreter directive, usually called shebang, is the character
sequence starting with `#!` (hash, exclamation-point) at the beginning
of the very first line of an executable text file on unixoid operating
systems.

The program loader of the operating system may use this line to load an
interpreter for this file when executed. This makes it a self-executable
script.

A shebang will typically look like

    #!/bin/bash

Since the line starting with `#` is a comment for the shell (and some
other scripting languages), it's ignored.

Regarding the shebang, there are various, differences between operating
systems, including:

-   may require a space after `#!` and before the pathname of the
    interpreter
-   may be able to take arguments for the interpreter
-   \...

POSIX(r) doesn't specify the shebang, though in general it's commonly
supported by operating systems.

## See also

-   [#!-magic](http://www.in-ulm.de/~mascheck/various/shebang/) - a nice
    overview of the differences between various operating systems
