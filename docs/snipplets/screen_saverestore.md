# Save and restore terminal/screen content

\-\-\-- dataentry snipplet \-\-\-- snipplet_tags: terminal, restore
screen LastUpdate_dt: 2010-07-31 Contributors: Greg Wooledge type:
snipplet

------------------------------------------------------------------------

This cool hack uses the terminal capabilities (see `terminfo(5)` manual)
**smcup** and **rmcup** to save and restore the terminal content.

For sure, you've already seen those programs that restore the terminal
contents after they did their work (like `vim`).

    # save, clear screen
    tput smcup
    clear

    # example "application" follows...
    read -n1 -p "Press any key to continue..."
    # example "application" ends here

    # restore
    tput rmcup
