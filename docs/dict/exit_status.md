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

  Code      Description
  --------- ------------------------------------------------------------------------------------------------------------------------------------------------------------
  0         success
  1-255     failure (in general)
  126       the requested command (file) can't be executed (but was found)
  127       command (file) not found
  128       according to ABS it's used to report an invalid argument to the exit builtin, but I wasn't able to verify that in the source code of Bash (see code 255)
  128 + N   the shell was terminated by the signal N (also used like this by various other programs)
  255       wrong argument to the exit builtin (see code 128)

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

  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  test                                                                                                  bash\    bash\     zsh 5.0.2\      ksh93\            mksh\            posh\   dash\     busybox\   heirloom\
                                                                                                        4.2.45   (POSIX)   (emulate ksh)   93v- 2013-03-18   R44 2013/02/24   0.11    0.5.7.3   1.2.1      050706
  ----------------------------------------------------------------------------------------------------- -------- --------- --------------- ----------------- ---------------- ------- --------- ---------- -----------
  `` :; : `false` `echo $? >&2` ``                                                                      1        1         1               1                 0                0       0         0          1

  `false; eval; echo $?`                                                                                0        0         0               0                 0                1       0         1          0

  `` x=`false` eval echo \$? ``                                                                         1        1         1               1                 0                0       0         0          1

  `` eval echo \$? <&0`false` ``                                                                        1        1         1               1                 0                0       0         0          1

  `while :; do ! break; done; echo $?`                                                                  1        1         1               1                 0                0       1         1          -

  [discussion](https://lists.gnu.org/archive/html/bug-bash/2010-09/msg00009.html)`false; : | echo $?`   1        1         1               0                 1                1       1         1          0

  `` (exit 2); for x in "`exit 3`"; do echo $?; done ``                                                 3        3         3               3                 2                2       0         0          3
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### functions

Measuring side-effects during the function call, during return, and
transparency of the return builtin.

  -------------------------------------------------------------------------------------------------------------------------------------------
  test                                                     bash   bash\     zsh\            ksh93   mksh   posh   dash   busybox   heirloom
                                                                  (POSIX)   (emulate ksh)                                          
  -------------------------------------------------------- ------ --------- --------------- ------- ------ ------ ------ --------- ----------
  `` f() { echo $?; }; :; f `false` ``                     1      1         1               1       0      0      0      0         1

  `f() { return; }; false; f; echo $?`                     1      1         1               0       1      1      1      1         1

  `f() { return $?; }; false; f; echo $?`                  1      1         1               1       1      1      1      1         1

  `f() { ! return; }; f; echo $?`                          0      0         1               0       0      0      1      1         -

  `f() { ! return; }; false; f; echo $?`                   1      1         0               0       1      1      0      0         -

  `` f() { return; }; x=`false` f; echo $? ``              1      1         1               1       0      0      0      0         0

  `` f() { return; }; f <&0`false`; echo $? ``             1      1         1               1       0      0      0      0         1

  `` f() { x=`false` return; }; f; echo $? ``              1      1         1               0       0      0      0      0         1

  `` f() { return <&0`false`; }; f; echo $? ``             1      1         1               0       0      0      0      0         1

  `` f() { x=`false` return <&0`false`; }; f; echo $? ``   1      1         1               1       0      0      0      0         1
  -------------------------------------------------------------------------------------------------------------------------------------------

### case..esac

Statuses measured within the command and after, with matching and
non-matching patterns.

  -------------------------------------------------------------------------------------------------------------------------------------------------
  test                                                           bash   bash\     zsh\            ksh93   mksh   posh   dash   busybox   heirloom
                                                                        (POSIX)   (emulate ksh)                                          
  -------------------------------------------------------------- ------ --------- --------------- ------- ------ ------ ------ --------- ----------
  `(exit 2); case x in x) echo $?;; esac`                        2      2         0               2       2      2      0      0         2

  `` (exit 2); case `exit 3`x in x) echo $?;; esac ``            3      3         0               3       2      2      0      0         3

  `` (exit 2); case x in `exit 4`x) echo $?;; esac ``            4      4         4               4       2      2      0      0         4

  `` (exit 2); case `exit 3`x in `exit 4`x) echo $?;; esac ``    4      4         4               4       2      2      0      0         4

  `(exit 2); case x in x);; esac; echo $?`                       0      0         0               0       0      0      0      0         2

  `(exit 2); case x in "");; esac; echo $?`                      0      0         0               0       0      0      0      0         2

  `` (exit 2); case `exit 3`x in x);; esac; echo $? ``           0      0         0               3       0      0      0      0         3

  `` (exit 2); case `exit 3`x in "");; esac; echo $? ``          0      0         0               3       0      0      0      0         3

  `` (exit 2); case x in `exit 4`x);; esac; echo $? ``           0      0         0               4       0      0      0      0         4

  `` (exit 2); case x in `exit 4`);; esac; echo $? ``            0      0         4               4       0      0      0      0         4

  `` (exit 2); case `exit 3`x in `exit 4`);; esac; echo $? ``    0      0         4               4       0      0      0      0         4

  `` (exit 2); case `exit 3`x in `exit 4`x);; esac; echo $? ``   0      0         0               4       0      0      0      0         4
  -------------------------------------------------------------------------------------------------------------------------------------------------
