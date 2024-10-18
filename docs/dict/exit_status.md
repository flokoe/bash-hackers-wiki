# Exit Status

-   exit code
-   return status

## Purpose

The exit status is a numeric value that is returned by a program to the
calling program or shell. In C programs, this is represented by the
return value of the `main()` function or the value you give to
`exit(3)`. The only part of the number that matters are the least
significant 8 bits, which means there are only values from 0 to 255.

In the shell, every operation generates an exit status (return status),
even if no program is called. An example for such an operation is a
redirection.

The parameter to the

-   `exit` (exit the shell/script)
-   `return` (return from a function)

builtin commands serve the purpose of giving the exit status to the
calling component.

This - and only this - makes it possible to determinate the success or
failure of an operation. For scripting, always set exit codes.

## Values

The code is a number between 0 and 255, where the part from 126 to 255
is reserved to be used by the Bash shell directly or for special
purposes, like reporting a termination by a signal:

|Code|Description|
|----|-----------|
|0|success|
|1-255|failure (in general)|
|126|the requested command (file) can't be executed (but was found)|
|127|command (file) not found|
|128|according to ABS it's used to report an invalid argument to the exit builtin, but I wasn't able to verify that in the source code of Bash (see code 255)|
|128+N|the shell was terminated by the signal N (also used like this by various other programs)|
|255|wrong argument to the exit builtin (see code 128)|

The lower codes 0 to 125 are not reserved and may be used for whatever
the program likes to report. A value of **0 means successful**
termination, a value **not 0 means unsuccessful** termination. This
behavior (== 0, != 0) is also what Bash reacts on in some code flow
control statements like `if` or `while`.

## Portability

Tables of shell behavior involving non-portable side-effects or common
bugs with exit statuses. Note heirloom doesn't support pipeline
negation (`! pipeline`).

### Misc

|test|bash 4.2.45|bash (POSIX)|zsh 5.0.2 (emulate ksh)|ksh93 93v- 2013-03-18|mksh R44 2013/02/24|posh 0.11|dash 0.5.7.3|busybox 1.2.1|heirloom 050706|
|--|--|--|--|--|--|--|--|--|--|
|<pre>:; : \`false\` \`echo $? >&2\`</pre>|1|1|1|1|0|0|0|0|1|
|<pre>false; eval; echo $?</pre>|0|0|0|0|0|1|0|1|0|
|<pre>x=\`false\` eval echo $?</pre>|1|1|1|1|0|0|0|0|1|
|<pre>eval echo \$? <&0\`false\`</pre>|1|1|1|1|0|0|0|0|1|
|<pre>while :; do ! break; done; echo $?</pre>|1|1|1|1|0|0|1|1|-|
|<pre>false; :| echo $?</pre><br>[discussion](https://lists.gnu.org/archive/html/bug-bash/2010-09/msg00009.html)|1|1|1|0|1|1|1|1|0|
|<pre>(exit 2); for x in "\`exit 3\`"; do echo $?; done</pre>|3|3|3|3|2|2|0|0|3|


### functions

Measuring side-effects during the function call, during return, and
transparency of the return builtin.

|test|bash|bash<br>(POSIX)|zsh<br>(emulate ksh)|ksh93|mksh|posh|dash|busybox|heirloom
|--|--|--|--|--|--|--|--|--|--|
|<pre>f() { echo $?; }; :; f \`false\`</pre>|1|1|1|1|0|0|0|0|1|
|<pre>f() { return; }; false; f; echo $?</pre>|1|1|1|0|1|1|1|1|1|
|<pre>f() { return $?; }; false; f; echo $?</pre>|1|1|1|1|1|1|1|1|1|
|<pre>f() { ! return; }; f; echo $?</pre>|0|0|1|0|0|0|1|1|-|
|<pre>f() { ! return; }; false; f; echo $?</pre>|1|1|0|0|1|1|0|0|-|
|<pre>f() { return; }; x=\`false\` f; echo $?</pre>|1|1|1|1|0|0|0|0|0|
|<pre>f() { return; }; f <&0\`false\`; echo $?</pre>|1|1|1|1|0|0|0|0|1|
|<pre>f() { x=\`false\` return; }; f; echo $?</pre>|1|1|1|0|0|0|0|0|1|
|<pre>f() { return <&0\`false\`; }; f; echo $?</pre>|1|1|1|0|0|0|0|0|1|
|<pre>f() { x=\`false\` return <&0\`false\`; }; f; echo $?</pre>|1|1|1|1|0|0|0|0|1|

### case..esac

Statuses measured within the command and after, with matching and
non-matching patterns.

|test|bash|bash<br>(POSIX)|zsh<br>(emulate ksh)|ksh93|mksh|posh|dash|busybox|heirloom|
|--|--|--|--|--|--|--|--|--|--|
|<pre>(exit 2); case x in x) echo $?;; esac</pre>|2|2|0|2|2|2|0|0|2|
|<pre> (exit 2); case \`exit 3\`x in x) echo $?;; esac</pre>|3|3|0|3|2|2|0|0|3|
|<pre> (exit 2); case x in \`exit 4\`x) echo $?;; esac</pre>|4|4|4|4|2|2|0|0|4|
|<pre> (exit 2); case \`exit 3\`x in \`exit 4\`x) echo $?;; esac</pre>|4|4|4|4|2|2|0|0|4|
|<pre>(exit 2); case x in x);; esac; echo $?</pre>|0|0|0|0|0|0|0|0|2|
|<pre>(exit 2); case x in "");; esac; echo $?</pre>|0|0|0|0|0|0|0|0|2|
|<pre>(exit 2); case \`exit 3\`x in x);; esac; echo $?</pre>|0|0|0|3|0|0|0|0|3|
|<pre>(exit 2); case \`exit 3\`x in "");; esac; echo $?</pre>|0|0|0|3|0|0|0|0|3|
|<pre>(exit 2); case x in \`exit 4\`x);; esac; echo $?</pre>|0|0|0|4|0|0|0|0|4|
|<pre>(exit 2); case x in \`exit 4\`);; esac; echo $?</pre>|0|0|4|4|0|0|0|0|4|
|<pre>(exit 2); case \`exit 3\`x in \`exit 4\`);; esac; echo $?</pre>|0|0|4|4|0|0|0|0|4|
|<pre> (exit 2); case \`exit 3\`x in \`exit 4\`x);; esac; echo $?</pre>|0|0|0|4|0|0|0|0|4|
