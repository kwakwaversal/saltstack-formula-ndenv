# saltstack-formula-ndenv
Install [ndenv](https://github.com/riywo/ndenv) and [Node](https://nodejs.org/en/)
http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html

## Available states

  - [ndenv](#ndenv)
  - [ndenv.clone](#ndenv.clone)
  - [ndenv.global](#ndenv.global)
  - [ndenv.gulp](#ndenv.gulp)
  - [ndenv.install](#ndenv.install)
  - [ndenv.plugins](#ndenv.plugins)
  - [ndenv.profile](#ndenv.profile)

## Basic pillar
Below is a basic pillar for the user `vagrant`. N.B., the user must exist on the
system you're salting.

```yaml
ndenv:
  # The version of node to be installed for all users. N.B., this can be
  # overridden per user.
  node:
    packages: []
    version: 6.7.0

  users:
    vagrant:
      user: vagrant
      group: vagrant
      node:
        packages:
          - gulp
        version: 6.9.0

```
