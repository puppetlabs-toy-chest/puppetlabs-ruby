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
  $ruby_dev_packages  = undef
) inherits ruby::params {
  require ruby

  # as the package ensure covers _multiple_ packages
  # specifying a version may cause issues.
  validate_re($ensure,['^installed$','^present$','^absent$','^latest$'])

  case $::osfamily {
    'Debian': {
      if $ruby_dev_packages {
        $ruby_dev = $ruby_dev_packages
      } else {
        case $::ruby::version {
          /^1\.8.*$/:{
            $ruby_dev = [
              'ruby1.8-dev',
              'ri1.8',
              'pkg-config'
            ]
          }
          /^1\.9.*$/:{
            $ruby_dev = [
              'ruby1.9.1-dev',
              'ri1.9.1',
              'pkg-config'
            ]
          }
          /^2\.0.*$/:{
            $ruby_dev = [
              'ruby2.0-dev',
              'ri',
              'pkg-config'
            ]
          }
          /^2\.1.*$/:{
            $ruby_dev = [
              'ruby2.0-dev',
              'ri',
              'pkg-config'
            ]
          }
          default: {
            $ruby_dev = $::ruby::params::ruby_dev
          }
        }
      }
    }
    'RedHat', 'Amazon': {
      # This specifically covers the case where there is no distro-provided
      # package for bundler. We install it using gem instead. Right now, this is
      # only set on RedHat and Amazon (see params.pp).
      $ruby_dev_gems = $::ruby::params::ruby_dev_gems

      if $ruby_dev_packages {
        $ruby_dev = $ruby_dev_packages
      } else {
        $ruby_dev = $::ruby::params::ruby_dev
      }
    }
  }

  # The "version" switch seems to do nothing on a non-Debian distro. This is
  # probably the safest behavior for the moment, since RedHat doesn't change
  # the ruby package name the way Debian does when new versions become
  # available. It's a bit misleading for the user, though, since they can
  # specify a version and it will just silently continue installing the
  # default version.
  package { $ruby_dev:
    ensure => $ensure,
  }

  if $ruby_dev_gems {
    package { $ruby_dev_gems:
      ensure   => $ensure,
      provider => gem,
    }
  }

}
