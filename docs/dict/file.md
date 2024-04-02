# File

A file is a pool of data in the `filesystem`. On
userlevel, it's referenced using a name, a
[hardlink](hardlink.md) to the file.

If a file is not referenced anymore (number of hardlinks to it drops to
1) then the space allocated for that file is re-used, unless it's still
used by some process.

The file-data splits into actual payload (file contents) and some
metadata like filesize, filemode or timestamps. The metadata is stored
in the `inode`.

Strictly spoken, a [hardlink](hardlink.md) (also called
\"filename\") points to the `inode` which organizes a
file, not to the file itself.

## See also

-   [filetimes](filetimes.md)
-   [hardlink](hardlink.md)
