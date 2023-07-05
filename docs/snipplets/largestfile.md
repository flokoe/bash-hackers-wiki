# Get largest file

\-\-\-- dataentry snipplet \-\-\-- snipplet_tags: directory, recursive,
find, crawl LastUpdate_dt: 2013-03-23 Contributors: Dan Douglas type:
snipplet

------------------------------------------------------------------------

One basic pattern for recursive directory traversal with operations on
files at each node. This gets the largest file in each subdirectory.
Toggling some small details will make it return the smallest, or
traverse breadth-first instead of depth-first.

``` bash
#!/usr/bin/env bash
# GNU find + bash4 / ksh93v / zsh
# Get the largest file matching pattern in the given directories recursively
${ZSH_VERSION+false} || emulate ksh
${BASH_VERSION+shopt -s lastpipe extglob}

function getLargest {
    typeset -A cur top || return
    typeset dir x
    for dir in "$2"/*/; do
        [[ -d $dir ]] || return 0
        getLargest "$1" "${dir%/}" || return
        top[size]=-1
        find "$dir" -maxdepth 1 -type f -name "$1" -printf '%s\0%f\0' | {
            while :; do
                for x in cur\[{size,name}\]; do
                    IFS= read -rd '' "$x" || break 2
                done
                if (( cur[size] > top[size] )); then
                    top[size]=${cur[size]} top[name]=${cur[name]}
                fi
            done
            printf '%q\n' "${dir}${top[name]}"
        }
    done
}

# main pattern dir [ dir ... ]
function main {
    if [[ -n $1 ]]; then
        typeset dir pattern=$1
        shift
        for dir; do
            [[ -d $dir ]] || return
            getLargest "$pattern" "$dir"
        done
    else
        return 1
    fi
}

main "$@"

# vim: set fenc=utf-8 ff=unix ft=sh :
```

## More examples

-   <http://mywiki.wooledge.org/BashFAQ/003>
-   <http://mywiki.wooledge.org/UsingFind>
