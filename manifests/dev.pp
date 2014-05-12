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
class ruby::dev (
  $ensure             = 'installed',
  $ruby_dev_packages  = $::ruby::params::ruby_dev
) inherits ruby::params {
  require ruby

  case $::osfamily {
    Debian: {
      case $::ruby::version {
        /^1\.8.*$/:{
          $ruby_dev = [
            'ruby1.8-dev',
            'ri1.8',
            'rake',
            'ruby-bundler',
            'pkg-config'
          ]
        }
        /^1\.9.*$/:{
          $ruby_dev = [
            'ruby1.9.1-dev',
            'ri1.9.1',
            'rake',
            'ruby-bundler',
            'pkg-config'
          ]
        }
        /^2\.0.*$/:{
          $ruby_dev = [
            'ruby2.0-dev',
            'ri',
            'rake',
            'ruby-bundler',
            'pkg-config'
          ]
        }
        /^2\.1.*$/:{
          $ruby_dev = [
            'ruby2.0-dev',
            'ri',
            'rake',
            'ruby-bundler',
            'pkg-config'
          ]
        }
        default: {
          $ruby_dev = $ruby_dev_packages
        }
      }
    }
    default: {
      $ruby_dev = $ruby_dev_packages
    }
  }

  package { $ruby_dev:
    ensure => $ensure,
  }
}
