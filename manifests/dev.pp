# Class: ruby::dev
#
# This class installs Ruby development libraries. It's not right, and has no tests.
#
# Parameters:
#
# Actions:
#   - Install RDoc, IRB, Rake and development libraries
#
# Requires:
#
# Sample Usage:
#
class ruby::dev {
  require ruby
  package { $ruby::ruby_dev:
    ensure => $ruby::ruby_package_ensure,
  }
}
