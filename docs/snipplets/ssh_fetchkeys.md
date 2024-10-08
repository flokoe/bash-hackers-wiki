# Fetching SSH hostkeys without interaction

---- dataentry snipplet ---- snipplet_tags: ssh, ssh-keys
LastUpdate_dt: 2010-07-31 Contributors: Jan Schampera

------------------------------------------------------------------------

Applies at least to `openssh`.

To get the hostkeys for a server, and write them to `known_hosts`-file
(to avoid that yes/no query when the key isn't known), you can do:

    ssh-keyscan -t rsa foo foo.example.com 1.2.3.4 >> ~/.ssh/known_host

This example queries the hostkeys for the very same machine, but under 3
different \"names\" (hostname, FQDN, IP) and redirects the output to the
`known_hosts`-file.

<u>**Notes:**</u>

-   if done blindly, the `known_host`-file may grow very large. It might
    be wise to check for key existance first
-   if multiple keys for the same host exist in `known_hosts`, the first
    one is taken (which might be an old or wrong one)
