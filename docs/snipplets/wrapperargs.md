# Generate code with own arguments properly quoted

\-\-\-- dataentry snipplet \-\-\-- snipplet_tags: arguments, quoting,
escaping, wrapper LastUpdate_dt: 2010-07-31 Contributors: Jan Schampera
type: snipplet

------------------------------------------------------------------------

  Keywords:      arguments,escape,quote,wrapper,generate
  -------------- -----------------------------------------
  Contributor:   self

There are situations where Bash code needs to generate Bash code. A
script that writes out another script the user or cron may start, for
example.

The general issue is easy, just write out text to the file.

A specific detail of it is tricky: If the generated script needs to call
a command using the arguments the first original script got, you have
problem in writing out the correct code.

I.e. if you run your generator script like

    ./myscript "give me 'some' water"

then this script should generate code that looks like

    echo give me 'some' water"

you need correct escapes or quotes to not generate shell special
characters out of normal text (like embedded dollar signs `$`).

**[Solution:]{.underline}**

A loop over the own arguments that writes out properly quoted/escaped
code to the generated script file

There are two (maybe more) easy options:

-   writing out singlequoted strings and handle the embedded
    singlequotes
-   the [printf command](/commands/builtin/printf) knows the `%q` format
    specification, which will print a string (like `%s` does), but with
    all shell special characters escaped

## Using singlequoted string

    #!/bin/bash

    # first option:
    # generate singlequoted strings out of your own arguments and handle embedded singlequotes
    # here to call 'echo' in the generated script

    {
    printf "#!/bin/bash\n\n"
    printf "echo "
    for arg; do
      arg=${arg/\'/\'\\\'\'}
      printf "'%s' " "${arg}"
    done

    printf "\n"
    } >s2

The generated script will look like:

    #!/bin/bash

    echo 'fir$t' 'seco "ond"' 'thir'\''d' 

## Using printf

The second method is easier, though more or less Bash-only (due to the
`%q` in printf):

    #!/bin/bash

    {
    printf "#!/bin/bash\n\n"
    printf "echo "
    for arg; do
      printf '%q ' "$arg"
    done

    printf "\n"
    } >s2

The generated script will look like:

    #!/bin/bash

    echo fir\$t seco\ \"ond\" thir\'d 
