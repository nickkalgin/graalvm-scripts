#!/bin/bash
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "No root privileges. Use sudo to run the script."
    exit 1
fi

for path in /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/*; do
    name=$(basename $path)
    update-alternatives --remove $name $path
done
update-alternatives --remove jexec /usr/lib/jvm/graalvm-21-openjdk-amd64/lib/jexec

rm /usr/lib/jvm/.graalvm-1.21.0-openjdk-amd64.jinfo
rm /usr/lib/jvm/graalvm-1.21.0-openjdk-amd64
rm -rf /usr/lib/jvm/graalvm-21-openjdk-amd64