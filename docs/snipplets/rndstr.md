# Print a random string or select random elements

\-\-\-- dataentry snipplet \-\-\-- snipplet_tags: terminal, line
LastUpdate_dt: 2013-04-30 Contributors: Dan Douglas (ormaaj) type:
snipplet

------------------------------------------------------------------------

First off, here is a fast / reliable random string function for scripts
or libraries which can optionally assign directly to a variable.

``` bash
# Print or assign a random alphanumeric string of a given length.
# rndstr len [ var ]
function rndstr {
    if [[ $FUNCNAME == "${FUNCNAME[1]}" ]]; then
        unset -v a
        printf "$@"
    elif [[ $1 != +([[:digit:]]) ]]; then
        return 1
    elif (( $1 )); then
        typeset -a a=({a..z} {A..Z} {0..9})
        eval '${2:+"$FUNCNAME" -v} "${2:-printf}" -- %s "${a[RANDOM%'"${#a[@]}"']"{1..'"$1"'}"}"'
    fi
}
```

This example prints 10 random positional parameters and operates on
basically the same principle as the `rndstr` function above.

     ~ $ ( set -- foo bar baz bork; printf '%s ' "${!_[_=RANDOM%$#+1,0]"{0..10}"}"; echo )
    bork bar baz baz foo baz baz baz baz baz bork 

\<div hide\> This has some interesting option parsing concepts, but is
overly complex. This is a good example of working too hard to avoid an
eval for no benefit and some performance penalty. :/

``` bash
# Print or assign a random alphanumeric string of a given length.
# rndstr [ -v var ] len
# Bash-only
rndstr()
    if [[ $FUNCNAME == "${FUNCNAME[1]}" ]]; then
        # On recursion, this branch unsets the outer scope's locals and assigns the result.
        unset -v a b
        printf -v "$1" %s "${@:2}"
    elif ! { [[ $1 == -v ]] && shift; }; [[ $?+1 -ne $# || ${!#} != +([[:digit:]]) || ( $? -gt 0 && -z $1 ) ]]; then
        # This branch does input validation, strips -v, and guarantees we're left with either 1 or 2 args.
        return 1
    elif (( ! ${!#} )); then
        # If a zero-length string is requested, return success.
        return
    else
        # This line generates the string and assigns it to "b".
        local -a a=({a..z} {A..Z} {0..9}) 'b=("${a[RANDOM%'"${#a[@]}"']"{1..'"${!#}"'}"}")'
        if (( $# == 2 )); then
            # If -v, then pass a variable name and value to assign and recurse once.
            "$FUNCNAME" "$1" "${b[@]}"
        else
            # If no -v, write to stdout.
            printf %s "${b[@]}"
        fi
    fi
```

\</div\>

The remaining examples don't use quite the same tricks, which will
hopefully be explained elsewhere eventually. See
[unset](../commands/builtin/unset.md#scope) for why doing assignments in this
way works well.

This next example is a variation on
[print_horizontal_line](../snipplets/print_horizontal_line.md). We\'re using
the printf field width specifier to truncate the values of a
`sequence expansion` to one character.

``` bash
a=({a..z} {A..Z} {0..9})
printf '%.1s' "${a[RANDOM%${#a[@]}]}"{0..9} $'\n'
```

The extra detail that makes this work is to notice that in Bash, [brace
expansion](../syntax/expansion/brace.md) is usually the very first type of
expansion to be processed, always before parameter expansion. Bash is
unique in this respect \-- all other shells with a brace expansion
feature perform it almost last, just before pathname expansion. First
the sequence expansion generates ten parameters, then the parameters are
expanded left-to-right causing the [arithmetic](../syntax/arith_expr.md) for
each to be evaluated individually, resulting in independent selection of
random element of `a`. To get ten of the same element, put the array
selection inside the format string where it will only be evaluated once,
just like the dashed-line trick:

``` bash
printf "%.s${a[RANDOM%${#a[@]}]}" {0..9} 
```

Selecting random elements whose lengths are not fixed is harder.

``` bash
a=(one two three four five six seven eight nine ten)
printf '%.*s ' $(printf '%s ' "${#a[x=RANDOM%${#a[@]}]} ${a[x]}"{1..10})
```

This generates each parameter and it's length in pairs. The \'\*\'
modifier instructs printf to use the value preceding each parameter as
the field width. Note the space between the parameters. This example
unfortunately relies upon the unquoted command substitution to perform
unsafe wordsplitting so that the outer printf gets each argument. Values
in the array can't contain characters in IFS, or anything that might be
interpreted as a pattern without using `set -f`.

Lastly, empty brace expansions can be used which don't generate any
output that would need to be filtered. The disadvantage of course is
that you must construct the brace expansion syntax to add up to the
number of arguments to be generated, where the most optimal solution is
its set of prime factors.

``` bash
a=(one two three)
echo "${a[RANDOM%${#a[@]}]}"{,}{,,,,}
```
