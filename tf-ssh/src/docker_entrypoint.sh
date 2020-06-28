#!/bin/bash
# When building the image, this script is copied into the container
## References:
# https://github.com/docker-library/mongo/blob/fbaaf63e240b194cc3a05b859611c26b02035abf/4.2/docker-entrypoint.sh#L214-L221

for f in /docker-entrypoint-init.d/*; do
        case "$f" in
            *.sh) echo "$0: running $f"; . "$f" ;;
            *)    echo "$0: ignoring $f" ;;
        esac
    echo
done

# remove scripts because there may be sensitive data
rm -rf /docker-entrypoint-init.d/*

# Run command. Default is /usr/sbin/sshd -D
$@
