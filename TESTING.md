# saltstack-formula-ndenv
Testing salt formulas using [Kitchen](https://docs.chef.io/kitchen.html) and
[Testinfra](https://testinfra.readthedocs.io)

# Synopsis
Full test using Kitchen and Docker (used for CI)

```sh
$ gem install bundler
$ bundle install
$ kitchen test
```

You will find the above is slow, but that is because the test command combines
creating, coverging, verifying and destroying each test stuite. When testing it's
worth breaking each section up into individual commands.

```sh
$ kitchen create
$ kitchen converge
$ kitchen verify
$ kitchen destroy
```

Once you have run `kitchen converge` you will find you will only want to run the
`kitchen verify` command while you develop your `testinfra` tests. `verify` will
run the tests against a running `docker` container, so make sure your tests are
nullipotent.

# Description
If you're reading this, I'm assuming you're already familiar with SaltStack and
you understand the importance of testing salt recipes/formulas.

There are various ways of testing formulas that involve a lot of boilerplate,
but the canonical tool for testing salt recipes based on the
[Salt Stack Formulas](https://github.com/saltstack-formulas) github
organisation is [Chef](https://www.chef.io/chef/)'s
[Kitchen](https://docs.chef.io/kitchen.html).

`Kitchen` is great and very flexible. It allows you to use different
`verifiers`.

* [InSpec](http://inspec.io/)
* `Shell`
  * [Serverspec](http://serverspec.org/) (*ruby*)
  * [Testinfra](https://testinfra.readthedocs.io/) (*python*)

Verifiers can be in any language, and a lot of people seem to use `Serverspec`,
but as `SaltStack` is written in `Python`, I have opted to use `Testinfra` which
is also written in `Python`.

# References
* [Kitchen](https://docs.chef.io/kitchen.html)
* [Kitchen and testinfra](https://medium.com/@syndicut/testing-salt-formulas-with-test-kitchen-and-testinfra-d2b8642e6a39)
* [Saltstack, Docker and Testinfra](http://blog.xebia.com/testing-infrastructure-with-saltstack-docker-and-testinfra/)
* [Testinfra](https://testinfra.readthedocs.io)
