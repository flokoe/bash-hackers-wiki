# Kill a background job without a message

\-\-\-- dataentry snipplet \-\-\-- snipplet_tags: kill, process
management, jobs LastUpdate_dt: 2010-07-31 Contributors: Jan Schampera
type: snipplet

------------------------------------------------------------------------

When you start background jobs from within a script (non-interactive
shell) and kill it afterwards, you will get a message from the shell
that the process was terminated.

Example:

    #!/bin/bash

    # example background process
    sleep 300 &

    # get the PID
    BG_PID=$!

    # kill it, hard and mercyless
    kill -9 $BG_PID

    echo "Yes, we killed it"

You will get something like this:

    $ ./bg_kill1.sh
    ./bg_kill1.sh: line 11:  3413 Killed                  sleep 300
    Yes, we killed it

This is more or less a normal message. And it can\'t be easily
redirected since it's the shell itself that yells this message, not the
command `kill` or something else. You would have to redirect the whole
script's output.

It's also useless to temporarily redirect `stderr` when you call the
`kill` command, since the successful termination of the job, the
termination of the `kill` command and the message from the shell may not
happen at the same time. And a blind `sleep` after the `kill` would be
just a workaround.

The solution is relatively easy: The shell spits that message because it
controls the background job, and when it terminates, the shell will tell
you whenever possible. Now you just need to tell your shell that it is
no longer responsible for that background process. This is done by the
`disown` command, which can take an internal shell job number (like
`%1`) or a process ID as argument.

    #!/bin/bash

    # example background process
    sleep 300 &

    # get the PID
    BG_PID=$!

    ### HERE, YOU TELL THE SHELL TO NOT CARE ANY MORE ###
    disown $BG_PID
    ###


    # kill it, hard and mercyless, now without a trace
    kill -9 $BG_PID

    echo "Yes, we killed it"

That way, you can run and kill background processes without disturbing
messages.
