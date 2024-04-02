# The local builtin command

## Synopsis

    local [option] name[=value] ...

## Description

`local` is identical to [declare](../../commands/builtin/declare.md) in every
way, and takes all the same options, with 3 exceptions:

-   Usage outside of a function is an error. Both `declare` and `local`
    within a function have the same effect on variable scope, including
    the -g option.
-   `local` with no options prints variable names and values in the same
    format as `declare` with no options, except the variables are
    filtered to print only locals that were set in the same scope from
    which `local` was called. Variables in parent scopes are not
    printed.
-   If name is '-', the set of shell options is made local to the
    function in which local is invoked: shell options changed using the
    set builtin inside the function are restored to their original
    values when the function returns. The restore is effected as if a
    series of set commands were executed to restore the values that were
    in place before the function.

## Portability considerations

-   `local` is not specified by POSIX. Most bourne-like shells don't
    have a builtin called `local`, but some such as `dash` and the
    busybox shell do.

```{=html}
<!-- -->
```
-   The behavior of function scope is not defined by POSIX, however
    local variables are implemented widely by bourne-like shells, and
    behavior differs substantially. Even the`dash` shell has local
    variables.

```{=html}
<!-- -->
```
-   In ksh93, using POSIX-style function definitions, `typeset` doesn't
    set `local` variables, but rather acts upon variables of the
    next-outermost scope (e.g. setting attributes). Using `typeset`
    within functions defined using ksh `function name {` syntax,
    variables follow roughly
    [lexical-scoping](http://community.schemewiki.org/?lexical-scope),
    except that functions themselves don't have scope, just like Bash.
    This means that even functions defined within a \"function's
    scope\" don't have access to non-local variables except through
    `namerefs`.

## See also

-   <http://wiki.bash-hackers.org/scripting/basics#variable_scope>
