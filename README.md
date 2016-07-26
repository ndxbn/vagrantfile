# Vagrantfile

## Dependencies

* [Oracle VritualBox](https://chocolatey.org/packages/virtualbox)
* [Vagrant](https://chocolatey.org/packages/vagrant)

## Installation

```bash
git clone http://github.com/ndxbn/vagrantfile
cd vagrantfile
vagrant up
```

## Coding Style

Language | Coding Style
:-- | :--
Bash Script | [Google Coding Style](https://google.github.io/styleguide/shell.xml)


## Pipeline

1. bootstrapping is hard-corded in [Vagrantfile](./Vagrantfile)
1. [synced_folder](https://www.vagrantup.com/docs/synced-folders/) will be done before provisioning
1. provisioning (a.k.a. configuration)
