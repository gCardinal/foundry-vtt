#!/bin/bash
set -e

# Not going to lie, I don't know. It's witchcraft to me, but it uses gosu to map whatever user you are using on your
# host machine to the user within the nodejs container.

cwd=$(pwd)
user_id=$(stat -c "%u" "$cwd")

sed -ie "s/$(id -u node)/$user_id/g" /etc/passwd

if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then
  set -- node "$@"
fi

exec gosu "$user_id" "$@"
