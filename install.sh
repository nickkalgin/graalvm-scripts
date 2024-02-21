#!/bin/bash
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "No root privileges. Use sudo to run the script."
    exit 1
fi

wget https://download.oracle.com/graalvm/21/latest/graalvm-jdk-21_linux-x64_bin.tar.gz

mkdir -p /usr/lib/jvm/graalvm-21-openjdk-amd64
tar -xzf graalvm-jdk-21_linux-x64_bin.tar.gz -C /usr/lib/jvm/graalvm-21-openjdk-amd64 --strip-components 1

rm graalvm-jdk-21_linux-x64_bin.tar.gz

ln -s /usr/lib/jvm/graalvm-21-openjdk-amd64 /usr/lib/jvm/graalvm-1.21.0-openjdk-amd64

bash -c "cat > /usr/lib/jvm/.graalvm-1.21.0-openjdk-amd64.jinfo" << EOF
name=graalvm-21-openjdk-amd64
alias=graalvm-1.21.0-openjdk-amd64
priority=2102
section=main

hl java /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/java
hl jpackage /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jpackage
hl keytool /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/keytool
hl rmiregistry /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/rmiregistry
hl jexec /usr/lib/jvm/graalvm-21-openjdk-amd64/lib/jexec
jdkhl jar /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jar
jdkhl jarsigner /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jarsigner
jdkhl javac /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/javac
jdkhl javadoc /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/javadoc
jdkhl javap /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/javap
jdkhl jcmd /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jcmd
jdkhl jdb /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jdb
jdkhl jdeprscan /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jdeprscan
jdkhl jdeps /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jdeps
jdkhl jfr /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jfr
jdkhl jimage /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jimage
jdkhl jinfo /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jinfo
jdkhl jlink /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jlink
jdkhl jmap /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jmap
jdkhl jmod /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jmod
jdkhl jps /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jps
jdkhl jrunscript /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jrunscript
jdkhl jshell /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jshell
jdkhl jstack /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jstack
jdkhl jstat /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jstat
jdkhl jstatd /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jstatd
jdkhl jwebserver /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jwebserver
jdkhl serialver /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/serialver
jdkhl jhsdb /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jhsdb
jdk jconsole /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/jconsole
jdk native-image /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/native-image
jdk native-image-configure /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/native-image-configure
jdk native-image-inspect /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/native-image-inspect
EOF

bash << "EOF"
for path in /usr/lib/jvm/graalvm-21-openjdk-amd64/bin/*; do
    name=$(basename $path)
    update-alternatives --install /usr/bin/$name $name $path 2102 \
    --slave /usr/share/man/man1/$name.1.gz $name.1.gz /usr/lib/jvm/graalvm-21-openjdk-amd64/man/man1/$name.1
done

update-alternatives --install /usr/bin/jexec jexec /usr/lib/jvm/graalvm-21-openjdk-amd64/lib/jexec 2102
EOF

update-java-alternatives -s graalvm-1.21.0-openjdk-amd64

java -version