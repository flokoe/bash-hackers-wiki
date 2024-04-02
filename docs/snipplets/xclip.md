# X-Clipboard on Commandline

---- dataentry snipplet ---- snipplet_tags: clipboard, x11, xclip,
readline LastUpdate_dt: 2010-07-31 Contributors: Josh Triplett type:
snipplet

------------------------------------------------------------------------

    # Make Control-v paste, if in X and if xclip available - Josh Triplett
    if [ -n "$DISPLAY" ] && [ -x /usr/bin/xclip ] ; then
        # Work around a bash bug: \C-@ does not work in a key binding
        bind '"\C-x\C-m": set-mark'
        # The '#' characters ensure that kill commands have text to work on; if
        # not, this binding would malfunction at the start or end of a line.
        bind 'Control-v: "#\C-b\C-k#\C-x\C-?\"$(xclip -o -selection c)\"\e\C-e\C-x\C-m\C-a\C-y\C-?\C-e\C-y\ey\C-x\C-x\C-d"'
    fi

The behaviour is a bit tricky to explain:

-   kill text after the cursor
    -   since the kill command **wants** text, it blindly adds a fake
        text \"#\" here
-   kill text before the cursor
    -   since the kill command **wants** text, it blindly adds a fake
        text \"#\" here, too
-   write out `"$(xclip -o -selection c)"`
-   run Control-Meta-e (shell-expand-line) to expand the
    `"$(xclip -o -selection c)"`
-   yank the previously killed text back where it belongs

Of course you can use any other command, you\'re not limited to `xclip`
here.

Note: C-@ as well as M-SPC both works and set the mark for me -- pgas
