# Add Color to your scripts

\-\-\-- dataentry snipplet \-\-\-- snipplet_tags : terminal, color
LastUpdate_dt : 2013-03-23 Contributors : Frank Lazzarini, Dan Douglas
type : snipplet

------------------------------------------------------------------------

Make your scripts output more readable using bash colors. Simply add
these variables to your script, and you will be able to echo in color.
(I haven\'t added all the colors available, just some basics)

    # Colors
    ESC_SEQ="\x1b["
    COL_RESET=$ESC_SEQ"39;49;00m"
    COL_RED=$ESC_SEQ"31;01m"
    COL_GREEN=$ESC_SEQ"32;01m"
    COL_YELLOW=$ESC_SEQ"33;01m"
    COL_BLUE=$ESC_SEQ"34;01m"
    COL_MAGENTA=$ESC_SEQ"35;01m"
    COL_CYAN=$ESC_SEQ"36;01m"

Now if you want to output some text in color use *echo -e* instead of
just echo. And always remember to use the *\$COL_RESET* variable to
reset the color changes in bash. Like so \....

    echo -e "$COL_RED This is red $COL_RESET"
    echo -e "$COL_BLUE This is blue $COL_RESET"
    echo -e "$COL_YELLOW This is yellow $COL_RESET"

But also see the notes in [the article about using
terminalcodes](/scripting/terminalcodes) about generating codes and
hardwiring codes.

This snipplet sets up associative arrays for basic color codes using
`tput` for Bash, ksh93 or zsh. You can pass it variable names to
correspond with a collection of codes. There\'s a `main` function with
example usage.

``` bash
#!/usr/bin/env bash

${ZSH_VERSION+false} || emulate ksh
${BASH_VERSION+shopt -s lastpipe extglob}

# colorSet [ --setaf | --setab | --misc ] var
# Assigns the selected set of escape mappings to the given associative array names.
function colorSet {
    typeset -a clrs msc
    typeset x
    clrs=(black red green orange blue magenta cyan grey darkgrey ltred ltgreen yellow ltblue ltmagenta ltcyan white)
    msc=(sgr0 bold dim smul blink rev invis)

    while ! ${2:+false}; do
        ${KSH_VERSION:+eval typeset -n "$2"=\$2}
        case ${1#--} in
            setaf|setab)
                for x in "${!clrs[@]}"; do
                    eval "$2"'[${clrs[x]}]=$(tput "${1#--}" "$x")'
                done
                ;;
            misc)
                for x in "${msc[@]}"; do
                    eval "$2"'[$x]=$(tput "$x")'
                done
                ;;
            *)
                return 1
        esac
        shift 2
    done
}

# Example code
function main {
    typeset -A fgColors bgColors miscEscapes
    if colorSet --setaf fgColors --setab bgColors --misc miscEscapes; then
        if ! ${1:+${fgColors[$1]:+false}}; then
            printf '%s%s%s\n' "${fgColors[$1]}" "this text is ${1}" "${miscEscapes[sgr0]}" >&3
        else
            printf '%s, %s\n' "${1:-Empty}" 'no such color.'
            typeset x y
            for x in fgColors bgColors miscEscapes; do
                typeset -a keys
                eval 'keys=("${!'"$x"'[@]}")'
                printf '%s=( ' "$x"
                for y in "${keys[@]}"; do
                    eval 'printf "[%q]=%q " "$y" "${'"$x"'[$y]}"'
                done
                printf ')\n'
            done
            return 1
        fi
    else
        echo 'Failed setting color arrays.'
        return 1
    fi 3>&1 >&2
}

main "$@"

# vim: set fenc=utf-8 ff=unix ft=sh :
```
