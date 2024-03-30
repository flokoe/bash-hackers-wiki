# Print a horizontal line

\-\-\-- dataentry snipplet \-\-\-- snipplet_tags: terminal, line
LastUpdate_dt: 2010-07-31 Contributors: Jan Schampera, prince_jammys,
ccsalvesen, others type: snipplet

------------------------------------------------------------------------

The purpose of this small code collection is to show some code that
draws a horizontal line using as less external tools as possible (it's
not a big deal to do it with AWK or Perl, but with pure or nearly-pure
Bash it gets more interesting).

In general, you should be able to use this code to repeat any character
or character sequence.

## The simple way: Just print it

Not a miracle, just to be complete here.

``` bash
printf '%s\n' --------------------
```

## The iterative way

This one simply loops 20 times, always draws a dash, finally a newline

``` bash
for ((x = 0; x < 20; x++)); do
  printf %s -
done
echo
```

## The simple printf way

This one uses the `printf` command to print an **empty** field with a
**minimum field width** of 20 characters. The text is padded with
spaces, since there is no text, you get 20 spaces. The spaces are then
converted to `-` by the `tr` command.

``` bash
printf '%20s\n' | tr ' ' -
```

whitout an external command, using the (non-POSIX) substitution
expansion and `-v` option:

``` bash
printf -v res %20s
printf '%s\n' "${res// /-}"
```

## A line across the entire width of the terminal

This is a variant of the above that uses `tput cols` to find the width
of the terminal and set that number as the minimum field witdh.

``` bash
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
```

## The more advanced printf way

This one is a bit tricky. The format for the `printf` command is `%.0s`,
which specified a field with the **maximum** length of **zero**. After
this field, `printf` is told to print a dash. You might remember that
it's the nature of `printf` to repeat, if the number of conversion
specifications is less than the number of given arguments. With brace
expansion `{1..20}`, 20 arguments are given (you could easily write
`1 2 3 4 ... 20`, of course!). Following happens: The **zero-length
field** plus the dash is repeated 20 times. A zero length field is,
naturally, invisible. What you see is the dash, repeated 20 times.

``` bash
# Note: you might see that as ''%.s'', which is a (less documented) shorthand for ''%.0s''
printf '%.0s-' {1..20}; echo
```

If the 20 is variable, you can use [eval](../commands/builtin/eval.md) to
insert the expansion (take care that using `eval` is potentially
dangerous if you evaluate external data):

``` bash
eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo
```

Or restrict the length to 1 and prefix the arguments with the desired
character.

``` bash
eval printf %.1s '-{1..'"${COLUMNS:-$(tput cols)}"\}; echo
```

You can also do it the crazy ormaaj way™ following basically the same
principle as this [string reverse
example](../commands/builtin/eval.md#expansion_side-effects). It completely
depends on Bash due to its brace expansion evaluation order and array
parameter parsing details. As above, the eval only inserts the COLUMNS
expansion into the expression and isn\'t involved in the rest, other
than to put the `_` value into the environment of the `_[0]` expansion.
This works well since we\'re not creating one set of arguments and then
editing or deleting them to create another as in the previous examples.

``` bash
_=- command eval printf %s '"${_[0]"{0..'"${COLUMNS:-$(tput cols)}"'}"}"'; echo
```

## The parameter expansion way

Preparing enough dashes in advance, we can then use a non-POSIX
subscript expansion:

``` bash
hr=---------------------------------------------------------------\
----------------------------------------------------------------
printf '%s\n' "${hr:0:${COLUMNS:-$(tput cols)}}"
```

A more flexible approach, and also using modal terminal line-drawing
characters instead of hyphens:

``` bash
hr() {
  local start=$'\e(0' end=$'\e(B' line='qqqqqqqqqqqqqqqq'
  local cols=${COLUMNS:-$(tput cols)}
  while ((${#line} < cols)); do line+="$line"; done
  printf '%s%s%s\n' "$start" "${line:0:cols}" "$end"
}
```

## Related articles

-   [printf](../commands/builtin/printf.md)
