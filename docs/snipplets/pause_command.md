# Pausing a script (like MSDOS pause command)

\-\-\-- dataentry snipplet \-\-\-- snipplet_tags: terminal, pause, input
LastUpdate_dt: 2010-07-31 Contributors: Jan Schampera type: snipplet

------------------------------------------------------------------------

From the [example section of the read
command](../commands/builtin/read.md#examples), something that acts similar
to the MSDOS `pause` command:

    pause() {
      local dummy
      read -s -r -p "Press any key to continue..." -n 1 dummy
    }
