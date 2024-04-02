---
hide: [navigation]
tags:
  - bash
  - shell
  - linux
  - scripting
---

# The Bash Hackers Wiki

!!! warning "Under construction"
    This is an archive of the old [wiki.bash-hackers.org](https://wiki.bash-hackers.org) with the goal of preserving and improving the content by the community in a modern way and format.

    The most recent version of each page that had content was automatically converted to Markdown and can be found here.
    Pandoc did its best, but there is still some work to do as not all pages are formatted correctly.
    So for everyone who is interested in helping out, feel free to open PRs. Any help is welcome.

This wiki is intended to hold documentation of any kind about GNU Bash.
The main motivation was to provide *human-readable documentation* and information so users aren't forced to read every bit of the Bash manpage - which can be difficult to understand.
However, the docs here are **not** meant as a newbie tutorial.

This wiki and any programs found in this wiki are free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This wiki and its programs are distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.
If not, see [http://www.gnu.org/licenses/](http://www.gnu.org/licenses/).

**Stranger!** Feel free to comment or edit the contents on GitHub. Use GitHub Issues to submit bugs and GitHub Discussions for enhancements, requests and general feedback/discussion.

## Scripting and general information

- [Bash v4 - a rough overview](bash4.md) (unmaintained, since Bash 4 is more or less standard.md)
- [style](scripting/style.md) – an assorted collection of style and optic hints
- [basics](scripting/basics.md)
- [newbie_traps](scripting/newbie_traps.md)
- [bashbehaviour](scripting/bashbehaviour.md)
- [posparams](scripting/posparams.md)
- [processtree](scripting/processtree.md)
- [obsolete](scripting/obsolete.md)
- [nonportable](scripting/nonportable.md)
- [debuggingtips](scripting/debuggingtips.md)
- [terminalcodes](scripting/terminalcodes.md)

## Code snippets

There is a [section that holds small code snippets](snipplets/index.md).

See also [some Bash source code excerpts](misc/readthesourceluke.md).

## How to

[Doing specific tasks: concepts, methods, ideas](howto/start.md):

- [Simple locking (against parallel run.md)](howto/mutex.md)
- [Rudimentary config files for your scripts](howto/conffile.md)
- [Editing files with ed](howto/edit-ed.md)
- [Collapsing Functions](howto/collapsing_functions.md)
- [Illustrated Redirection Tutorial](howto/redirection_tutorial.md)
- [Calculate with dc](howto/calculate-dc.md)
- [Introduction to pax - the POSIX archiver](howto/pax.md)
- [getopts_tutorial](howto/getopts_tutorial.md) (*under construction!*)
- [dissectabadoneliner](howto/dissectabadoneliner.md) An example of a bad oneliner, breakdown and fix (by `kojoro`)
- [Write tests for ./your-script.sh](howto/testing-your-scripts.md) by using bashtest util

## Bash syntax and operations

- [Bash features overview by version](scripting/bashchanges.md)
- [Basic grammar rules](syntax/basicgrammar.md)
- [Quoting and character escaping](syntax/quoting.md)
- [Parsing and execution](syntax/grammar/parser_exec.md)
- [Some words about words...](syntax/words.md)
- [Patterns and pattern matching](syntax/pattern.md)
- [Arithmetic expressions](syntax/arith_expr.md)
- [List of shell options](internals/shell_options.md)
- [Redirection](syntax/redirection.md)
- [Special parameters and shell variables](syntax/shellvars.md)
- [Arrays](syntax/arrays.md)

## Compound commands

| [Compound commands overview](syntax/ccmd/intro.md) |                                                                  |
| ------------------------------------------------ | ---------------------------------------------------------------- |
| **Grouping**                                     |                                                                  |
| `{ ...; }`                                       | [command grouping](syntax/ccmd/grouping_plain.md)                  |
| `( ... .md)`                                        | [command grouping in a subshell](syntax/ccmd/grouping_subshell.md) |
| **Conditionals**                                 |                                                                  |
| `[[ ... ]]`                                      | [conditional expression](syntax/ccmd/conditional_expression.md)    |
| `if ...; then ...; fi`                           | [conditional branching](syntax/ccmd/if_clause.md)                  |
| `case ... esac`                                  | [pattern-based branching](syntax/ccmd/case.md)                     |
| **Loops**                                        |                                                                  |
| `for word in ...; do ...; done`                  | [classic for-loop](syntax/ccmd/classic_for.md)                     |
| `for ((x=1; x<=10; x++)); do ...; done`          | [C-style for-loop](syntax/ccmd/c_for.md)                           |
| `while ...; do ...; done`                        | [while loop](syntax/ccmd/while_loop.md)                            |
| `until ...; do ...; done`                        | [until loop](syntax/ccmd/until_loop.md)                            |
| **Misc**                                         |                                                                  |
| `(( ... ))`                                      | [arithmetic evaluation](syntax/ccmd/arithmetic_eval.md)            |
| `select word in ...; do ...; done`               | [user selections](syntax/ccmd/user_select.md)                      |

## Expansions and substitutions

| [Introduction to expansions and substitutions](syntax/expansion/intro.md) |                                                      |
| ------------------------------------------------------------------------| ---------------------------------------------------- |
| `{A,B,C} {A..C}`                                                        | [Brace expansion](syntax/expansion/brace.md)           |
| `~/ ~root/`                                                             | [Tilde expansion](syntax/expansion/tilde.md)           |
| `$FOO ${BAR%.mp3}`                                                      | [Parameter expansion](syntax/pe.md)                    |
| `` `command` $(command) ``                                              | [Command substitution](syntax/expansion/cmdsubst.md)   |
| `<(command.md) >(command)`                                                 | [Process substitution](syntax/expansion/proc_subst.md) |
| `$((1 + 2 + 3)) $[4 + 5 + 6]`                                           | [Arithmetic expansion](syntax/expansion/arith.md)      |
| `Hello <---> Word!`                                                     | [Word splitting](syntax/expansion/wordsplit.md)        |
| `/data/*-av/*.mp?`                                                      | [Pathname expansion](syntax/expansion/globs.md)        |

## Builtin Commands

This is a selection of builtin commands and command-like keywords, loosely arranged by their common uses.
These are provided directly by the shell, rather than invoked as standalone external commands.

### Declaration commands

!!! note
    Commands that set and query attributes/types, and manipulate simple datastructures.

| Command                                | Description                                                            | Alt          | Type            |
| -------------------------------------- | ---------------------------------------------------------------------- | ------------ | --------------- |
| [declare](commands/builtin/declare.md)   | Display or set shell variables or functions along with attributes.     | `typeset`    | builtin         |
| [export](commands/builtin/export.md)     | Display or set shell variables, also giving them the export attribute. | `typeset -x` | special builtin |
| [eval](commands/builtin/eval.md)         | Evaluate arguments as shell code.                                      |              | special builtin |
| [local](commands/builtin/local.md)       | Declare variables as having function local scope.                      |              | builtin         |
| [readonly](commands/builtin/readonly.md) | Mark variables or functions as read-only.                              | `typeset -r` | special builtin |
| [unset](commands/builtin/unset.md)       | Unset variables and functions.                                         |              | special builtin |
| [shift](commands/builtin/shift.md)       | Shift positional parameters                                            |              | special builtin |

### IO

!!! note
    Commands for reading/parsing input, or producing/formatting output of standard streams.

| Command                              | Description                                                            | Alt         | Type     |
| ------------------------------------ | ---------------------------------------------------------------------- | ----------- | ---------|
| [coproc](syntax/keywords/coproc.md)    | Co-processes: Run a command in the background with pipes for reading / writing its standard streams. |  | keyword |
| [echo](commands/builtin/echo.md)       | Create output from arguments.                                          |             | builtin  |
| [mapfile](commands/builtin/mapfile.md) | Read lines of input into an array.                                     | `readarray` | builtin  |
| [printf](commands/builtin/printf.md)   | "advanced `echo`"                                                      |             | builtin  |
| [read](commands/builtin/read.md)       | Read input into variables or arrays, or split strings into fields using delimiters. | | builtin |

### Configuration and Debugging

!!! note
    Commands that modify shell behavior, change special options, assist in debugging.

| Command                            | Description                                                                   | Alt | Type            |
| ---------------------------------- | ----------------------------------------------------------------------------- | --- | --------------- |
| [caller](commands/builtin/caller.md) | Identify/print execution frames.                                              |     | builtin         |
| [set](commands/builtin/set.md)       | Set the positional parameters and/or set options that affect shell behaviour. |     | special builtin |
| [shopt](commands/builtin/shopt.md)   | set/get some bash-specific shell options.                                     |     | builtin         |

### Control flow and data processing

!!! note
    Commands that operate on data and/or affect control flow.

| Command                                             | Description                                          | Alt      | Type            |
| --------------------------------------------------- | ---------------------------------------------------- | -------- | --------------- |
| [colon](commands/builtin/true.md)                     | "true" null command.                                 | `true`   | special builtin |
| [dot](commands/builtin/source.md)                     | Source external files.                               | `source` | special builtin |
| [false](commands/builtin/false.md)                    | Fail at doing nothing.                               |          | builtin         |
| [continue / break](commands/builtin/continueBreak.md) | continue with or break out of loops.                 |          | special builtin |
| [let](commands/builtin/let.md)                        | Arithmetic evaluation simple command.                |          | builtin         |
| [return](commands/builtin/return.md)                  | Return from a function with a specified exit status. |          | special builtin |
| [[]](commands/classictest.md)                         | The classic `test` simple command.                   | `test`   | builtin         |

### Process and Job control

!!! note
    Commands related to jobs, signals, process groups, subshells.

| Command                          | Description                                            | Alt | Type            |
| -------------------------------- | ------------------------------------------------------ | --- | --------------- |
| [exec](commands/builtin/exec.md)   | Replace the current shell process or set redirections. |     | special builtin |
| [exit](commands/builtin/exit.md)   | Exit the shell.                                        |     | special builtin |
| [trap](commands/builtin/trap.md)   | Set signal handlers or output the current handlers.    |     | special builtin |
| [kill](commands/builtin/kill.md)   | Send a signal to specified process(es.md)                 |     | builtin         |
| [times](commands/builtin/times.md) | Display process times.                                 |     | special builtin |
| [wait](commands/builtin/wait.md)   | Wait for background jobs and asynchronous lists.       |     | builtin         |

## Dictionary

A list of expressions, words, and their meanings is [here](dict/index.md).

## Links

### Official Bash links

- [Chet Ramey's Bash page](http://tiswww.case.edu/php/chet/bash/bashtop.html) and its [FAQ](http://tiswww.case.edu/php/chet/bash/FAQ).
- [GNU Bash software page](http://www.gnu.org/software/bash/)
- Official Bash mailing lists:
  - **Bug reports**: <bug-bash@gnu.org> ([archives](http://mail.gnu.org/pipermail/bug-bash))
  - **General questions**: <help-bash@gnu.org> ([archives](http://mail.gnu.org/pipermail/help-bash))
- Official Bash git repository:
  - **Browse**: [cgit](http://git.savannah.gnu.org/cgit/bash.git)
  - **Clone**: `git clone git.sv.gnu.org/srv/git/bash.git`

### Recommended Shell resources

- [Greg's wiki](http://mywiki.wooledge.org/) - Greg Wooledge's (aka "greycat") wiki -- with **MASSIVE** information about Bash and UNIX(r) in general.
- [BashFAQ](http://mywiki.wooledge.org/BashFAQ) • [BashGuide](http://mywiki.wooledge.org/BashGuide) • [BashPitfalls](http://mywiki.wooledge.org/BashPitfalls) • [BashSheet](http://mywiki.wooledge.org/BashSheet)
- [Sven Mascheck's pages](http://www.in-ulm.de/~mascheck/) - A goldmine of information. A must-read.
- [#ksh channel page](https://www.mirbsd.org/ksh-chan.htm) - #ksh Freenode channel page maintains a solid collection of recommended links.
- [The Grymoire Unix pages](http://www.grymoire.com/Unix/) - Good scripting information, especially read the [quoting](http://www.grymoire.com/Unix/Quote.html) guide.
- [Heiner's "Shell Dorado"](http://www.shelldorado.com) - Tips, tricks, links - for every situation.
- [The Single Unix Specification (version 4, aka POSIX-2008)](http://pubs.opengroup.org/onlinepubs/9699919799/)
- [The Austin Group](http://www.opengroup.org/austin/) - [List archives](http://dir.gmane.org/gmane.comp.standards.posix.austin.general), [Bug tracker](http://austingroupbugs.net/main_page.php)
- [comp.unix.shell FAQ](http://cfajohnson.com/shell/cus-faq.html)
- [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/index.html) - last update: 10 Mar 2014, but still very useful guide.

#### Documentation / Reference

- **Bash**: [man page](http://tiswww.case.edu/php/chet/bash/bash.html), [info page](http://tiswww.case.edu/php/chet/bash/bashref.html)
- **AT&T ksh**: [ksh88](http://www2.research.att.com/sw/download/man/man1/ksh88.html), [ksh93](http://www2.research.att.com/sw/download/man/man1/ksh.html)
- [mksh](https://www.mirbsd.org/htman/i386/man1/mksh.htm) (pdksh successor)
- [zsh](http://zsh.sourceforge.net/Doc/)
- [dash](http://man7.org/linux/man-pages/man1/dash.1.html)
- [Heirloom Bourne shell](http://heirloom.sourceforge.net/man/sh.1.html)
- [Thompson shell](http://v6shell.org/man/osh.1.html)

### Assorted interesting links

- [History and development of the traditional Bourne shell family](http://www.in-ulm.de/~mascheck/bourne/) - very interesting and nice to read!
- [Interview with Chet Ramey](http://www.computerworld.com.au/article/222764/-z_programming_languages_bash_bourne-again_shell)
- [Interview with Steve Bourne](http://www.computerworld.com.au/article/279011/a-z_programming_languages_sh) • [Stephen Bourne - BSDCan 2015 keynote](https://www.youtube.com/watch?v=2kEJoWfobpA)
- [Interview with David Korn](http://news.slashdot.org/story/01/02/06/2030205/david-korn-tells-all)
- [Kernighan on the Unix pipeline (computerphile video)](https://www.youtube.com/watch?v=bKzonnwoR2I)
- Linux in general, with some shell related stuff: [nixCraft: Linux Tips, Hacks, Tutorials and Ideas](http://www.cyberciti.biz/)
- Linux tutorials, guides and how-tos: [RoseHosting Blog](https://www.rosehosting.com/blog/), [bash script for installing WordPress](https://www.rosehosting.com/blog/script-install-wordpress-on-a-debianubuntu-vps/) and some [basic shell commands](https://www.rosehosting.com/blog/basic-shell-commands-after-putty-ssh-logon/)
- [Bashphorism list from the Bash IRC channel on Freenode](misc/bashphorisms.md)
- [Some more or less funny commandline stuff](misc/shell_humor.md)
- [How to Enable SSH on Ubuntu Tutorial](https://thishosting.rocks/how-to-enable-ssh-on-ubuntu/)
- [How To Make an Awesome Custom Shell with ZSH](https://linuxstans.com/how-to-make-an-awesome-custom-shell-with-zsh/)

### Bash Libraries (needs review)

- [An oo-style bash library for bash 4](http://sourceforge.net/projects/oobash/) - provides tools for rapid script development and huge libraries.
- [General purpose shell framework for bash 4](https://github.com/hornos/shf3) - in development.
- [General purpose bash library for bash 4](https://github.com/chilicuil/learn/blob/master/sh/lib) - active development

## Contact

Visit us in [ircs://irc.libera.chat:6697](ircs://irc.libera.chat:6697), channel `#bash` ;-)

If you have critiques or suggestions, please feel free to send a mail using the contact form on the right.
Note that there is a simple discussion option below every article.

Please also see the [imprint](user/thebonsai/imprint.md) if you have problems with the site and its contents (legality, ...)!

It also would be nice to drop a line when

- it helped you
- it didn't help you (something missing / unclear)
- you like it
- you don't like it
- you found mistakes / bugs

Simply: Reader's feedback.
