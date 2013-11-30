# Class: ruby::dev
#
# This class installs Ruby development libraries
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
  if $ruby::params::ruby_dev {
    package { $ruby::params::ruby_dev:
      ensure => installed,
    }
  }
}
