# File

A file is a pool of data in the [filesystem](../dict/terms/filesystem.md). On
userlevel, it\'s referenced using a name, a
[hardlink](../dict/terms/hardlink.md) to the file.

If a file is not referenced anymore (number of hardlinks to it drops to
0) then the space allocated for that file is re-used, unless it\'s still
used by some process.

The file-data splits into actual payload (file contents) and some
metadata like filesize, filemode or timestamps. The metadata is stored
in the [inode](../dict/terms/inode.md).

Strictly spoken, a [hardlink](../dict/terms/hardlink.md) (also called
\"filename\") points to the [inode](../dict/terms/inode.md) which organizes a
file, not to the file itself.

## See also

-   [filesystem](../dict/terms/filesystem.md)
-   [filetimes](../dict/terms/filetimes.md)
-   [hardlink](../dict/terms/hardlink.md)
-   [inode](../dict/terms/inode.md)
