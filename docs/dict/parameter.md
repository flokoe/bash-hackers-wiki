# Parameter

Also the article for: [variable]{.underline}, [positional
parameter]{.underline}, [special parameter]{.underline}

In Bash, a parameter is simply an entity that stores values and can be
referenced. Depending on the type, the parameters can be set directly,
only indirectly, or only automatically by the shell.

Bash knows 3 types of parameters:

-   variables
-   positional parameters
-   special parameters

## variables

A shell variable is a parameter denoted by a *variable name*:

-   containing only alphanumeric characters and underscores
-   beginning with an alphabetic character or an underscore

A value can be assigned to a variable, using the variable\'s name and an
equal-sign:

    NAME=VALUE

Once a variable is set, it exists and can only be unset by the `unset`
builtin command.

The nullstring is a valid value:

    NAME=
    NAME=""

## positional parameters

A positional parameter is denoted by a number other than `0` (zero).

Positional parameters reflect the shell\'s arguments that are not given
to the shell itself (in practise, the script arguments, also the
function arguments). You can\'t directly assign to the positional
parameters, however, [the set builtin command](/commands/builtin/set)
can be used to indirectly set them.

The first to ninth positional parameter is referenced by `$1` to `$9`.
All following positional parameters (tenth and above) must be referenced
by the number given in curly braces, i.e., `${10}` or `${432}`.

Unlike popular belief, `$0` is *not a positional parameter*.

See also the [scripting article about handling positional
parameters](/scripting/posparams).

## special parameters

There are a bunch of special parameters, which are set by the shell.
Direct assignment to them is not possible. These parameter names are
formed of one character.

Please see [shellvars](/syntax/shellvars).

## See also

-   Syntax article, internal: [pe](/syntax/pe)
-   Syntax article, internal: [shellvars](/syntax/shellvars)
-   Scripting article, internal: [posparams](/scripting/posparams)
