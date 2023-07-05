# File timestamp

## atime

This timestamp indicates when a file was last accessed (read). `cat`ing
a file or executing a shellscript will set it, for example.

## ctime

This timestamp is set, whenever the metadata of a file (stored in the
responsible inode) is set. The metadata includes for example:

-   file name
-   fize size
-   file mode (permissions)

and some other things. `ctime` will also be updated when a file is
written to (when `mtime` is updated.

## mtime

The mtime is set, whenever a file\'s contents are changed, for example
by editing a file.
