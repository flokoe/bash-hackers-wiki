# Globbing

Globbing is the procedure of

-   matching all filenames against a given pattern
-   expanding to all matching filenames

Unlike MSDOS, where the called program had to interpret the patterns,
the globbing on UNIX(r) is done by the shell, the matched filenames are
given as parameters to a called command:

    $ cat *.txt

really executes

    $ cat 1.txt 3.txt foobar.txt XXX.txt

The term \"glob\" originates back in the UNIX(r) days where an
executable `glob` (from \"global\") existed which was used to expand
pattern-matching characters. Later, this functionality was built into
the shell. There\'s still a library function called `glob()` (POSIX(r)),
which serves the same purpose.

## See also

-   [shell](../dict/terms/shell.md)
-   [hardlink](../dict/terms/hardlink.md)

## See also (article)

-   [pathname expansion](../syntax/expansion/globs.md)
