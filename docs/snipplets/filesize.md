# Show size of a file

---- dataentry snipplet ---- snipplet_tags: files, file size
LastUpdate_dt: 2010-07-31 Contributors: Frank Lazzarini type: snipplet

------------------------------------------------------------------------

This is a simple snippet to echo the size of a file in bytes.

    #!/bin/bash
    FILENAME=/home/heiko/dummy/packages.txt
    FILESIZE=$(wc -c < "$FILENAME")
    # non standard way (GNU stat): FILESIZE=$(stat -c%s "$FILENAME")

    echo "Size of $FILENAME = $FILESIZE bytes."
