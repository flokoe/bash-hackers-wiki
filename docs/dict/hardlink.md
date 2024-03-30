# Hardlink

Also the article for:

-   filename

A hardlink associates a *filename* with a [file](../dict/terms/file.md). That
name is an entry in a directory listing. Of course a file can have more
hardlinks to it (usually the number of hardlinks to a file is limited),
but all hardlinks to a file must reside on the same
[filesystem](../dict/terms/filesystem.md) as the file itself!

What you usually call a file is just a name for that file, and thus, a
hardlink.

The difference between a [symbolic link](../dict/terms/symlink.md) and a hard
link is that there is no easy way to differentiate between a \'real\'
file and a hard link, let's take a look at the example:

\* create an empty file

    $ touch a

\* create a hard link \'b\' and sym link \'c\' to empty file

    $ ln a b
    $ ln -s a c

as you can see file(1) can\'t differentiate between a real file \'a\'
and a hard link \'b\', but it can tell \'c\' is a sym link

    $ file *
    a: empty
    b: empty
    c: symbolic link to `a'

`ls -i` prints out the inode numbers of files, if two files have the
same inode number AND are on the same file system it means they are
**hardlinked**.

    $ ls -i *
    5262 a  5262 b  5263 c

hard links don\'t consume additional space on the filesystem, the space
is freed when the last hard link pointing to it is deleted.

## See also

-   [file](../dict/terms/file.md)
-   [filesystem](../dict/terms/filesystem.md)
-   [symlink](../dict/terms/symlink.md)
