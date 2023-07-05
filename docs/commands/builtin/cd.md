# The cd builtin command

## Synopsis

    cd [-L|-P] [DIRECTORY]

    cd -

## Description

The `cd` builtin command is used to change the current working directory

-   to the given directory (`cd DIRECTORY`)
-   to the previous working directory (`cd -`) as saved in the
    [OLDPWD](/syntax/shellvars#OLDPWD) shell variable
-   to the user\'s home directory as specified in the
    [HOME](/syntax/shellvars#HOME) environment variable (when used
    without a `DIRECTORY` argument)

The `cd` builtin command searches the directories listed in
[CDPATH](/syntax/shellvars#CDPATH) for a matching directory.

The default behaviour is to follow symbolic links unless the `-P` option
is given or the shell is configured to do so (see the `-P` option of
[the set builtin command](/commands/builtin/set)).

### Options

  Option   Description
  -------- ----------------------------------------------------
  `-L`     Follow symbolic links (default)
  `-P`     Do not follow symbolic links
  `-@`     Browse a file\'s extended attributed, if supported

### Exit status

-   true if the directory was changed successfully
-   false if a change to the home directory was requested, but
    [HOME](/syntax/shellvars#HOME) is unset
-   false if anything else goes wrong

## Examples

### Change the working directory to the user\'s home directory

    cd

### Change the working directory to the previous directory

    cd -

## Portability considerations

## See also

-   variable [CDPATH](/syntax/shellvars#CDPATH)
-   variable [HOME](/syntax/shellvars#HOME)
-   variable [OLDPWD](/syntax/shellvars#OLDPWD)
-   the `-P` option of [the set builtin command](/commands/builtin/set)
