# Run some bash commands with SSH remotely using local variables

---- dataentry snipplet ---- snipplet_tags: ssh, variables
LastUpdate_dt: 2010-07-31 Contributors: cweiss type: snipplet

------------------------------------------------------------------------

In this example, we want to make sure a certain file exists on the
remote server:

    file=/tmp/file.log
    ssh ${options} ${login} "if [ ! -e '$file' ] ; then touch '$file' ; fi"

Notice the command is surrounded by double quotes, and the \$file
variable is surrounded by single quotes. That has the effect to be
wordsplit-proof in the local shell (due to the double-quotes) and in the
remote shell (due to the single-quotes).
