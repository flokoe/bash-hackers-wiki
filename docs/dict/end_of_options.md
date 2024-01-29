# End of Options

The options of UNIX(r) utilities usually are introduced with a dash
(`-`) character.

This is problematic when a non-option argument has to be specified that
begins with a dash. A common example for this are filenames.

Many utilities use the convention to specify two consecutive dashes
(`--`) to signal \"end of options at this point\". Beyond this tag, no
options are processed anymore, even if an argument begins with a dash.

Example: You want to list (`ls`) the file with the name `-hello`. With
common option processing, this could end up in the ls-options `-h`,
`-e`, `-l` and `-o` and probably in an error message about invalid
options. You use this to avoid the wrong option processing:

    ls -- -hello

POSIX(r) specifies that every utility should follow this rule (see ch.
[12.2 Utility Syntax
Guidelines](https://pubs.opengroup.org/onlinepubs/9699919799.2013edition/basedefs/V1_chap12.html)),
except

-   `echo` (historical reasons)
-   `test` (obvious parsing reasons)

## See also

-   Scripting article, internal:
    [getopts_tutorial](../howto/getopts_tutorial.md)
