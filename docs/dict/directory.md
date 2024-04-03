# Directory

In terms of UNIX(r), a directory is a special file which contains a list
of [hardlinks](../dict/hardlink.md) to other files. These other files
also can be directories of course, so it's possible to create a
\"hierarchy of directories\" - the UNIX(r)-typical filesystem structure.

The structure begins at the special directory `/` (root directory) and
all other directory entries are **subdirectories** of it.

## See also

-   [hardlink](../dict/hardlink.md)
-   [file](../dict/file.md)
-   [special file](../dict/special_file.md)
