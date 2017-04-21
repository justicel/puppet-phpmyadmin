# Testing

## Prerequisites

`Docker` and `ruby` need to be installed on the local machine.

## Running Tests

After cloning the repository the testing environment should be set up on the
local machine:

```
$ bundle install --path=.bundle
$ bundle exec rake
$ bundle exec rake lint
$ bundle exec rake spec
$ bundle exec rake beaker
```
