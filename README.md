# Bash Hackers Wiki

The popular [wiki.bash-hackers.org](https://wiki.bash-hackers.org) (original IP address: `83.243.40.67`) site had its DNS expire in April 2023. The owner seems unresponsive, see the [Reddit thread here](https://www.reddit.com/r/bash/comments/12klulf/bashhackersorg_is_now_a_parking_domain/). Fortunately, the web server behind wiki.bash-hackers.org is still running, so I crawled the entire wiki to archive the current versions of all pages.

This repo tries to preserve and present all this valuable information in a modern way and format, just in case the original wiki won't come back.

## LICENSE

As per the original wiki.bash-hackers.org:

> This wiki and any programs found in this wiki are free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
>
> This wiki and its programs are distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See [LICENSE](LICENSE) for more details.

### Modifications

The original source files that I scraped from the wiki can be found unmodified in [original_source](original_source/).

Under [docs](docs/) you will find files that are converted from the original DokuWiki Text to Markdown. Furthermore, I slightly modified the organization of the files to be a better fit for MkDocs Material.

## COPYRIGHT

The original copyright belongs to Jan Schampera (TheBonsai) and subsequent contributors, 2007 - 2023.

It is important to me that copyright and attribution are given where required. If you're one of the original contributors, and you believe I've violated your copyright in any way, please let me know and write me an email at [mail@flokoe.de](mailto:mail@flokoe.de).
