# graalvm-scripts

The repository provides scripts for installation, setup, and removal the GraalVM JDK on Ubuntu-based distros.
The installation and removal scripts integrate the JDK with the [update-alternatives](https://man7.org/linux/man-pages/man1/update-alternatives.1.html) tool that allows to switch between JDK versions.

## Usage

### Install the latest GraalVM for JDK 21

```
curl -s https://raw.githubusercontent.com/nickkalgin/graalvm-scripts/master/install.sh | sudo bash
```

### Remove the previously installed GraalVM for JDK 21

```
curl -s https://raw.githubusercontent.com/nickkalgin/graalvm-scripts/master/remove.sh | sudo bash
```
