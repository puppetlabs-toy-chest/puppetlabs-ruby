# Class: ruby::params
#
# This class handles the Ruby module parameters
#
class ruby::params {
  $version              = 'installed'
  $gems_version         = 'installed'
  $ruby_package         = 'ruby'
  $ruby_switch_package  = 'ruby-switch'

  case $::osfamily {
    'redhat', 'amazon': {
      $ruby_dev = ['ruby-devel','rubygems-bundler']
      $rubygems_update = true
      $rubygems_package = 'rubygems'
    }
    'debian': {
      $ruby_dev = [ 'ruby-dev', 'rake', 'ri', 'ruby-bundler', 'pkg-config' ]
      $rubygems_update = false

      case $::lsbdistcodename {
        'trusty': {
          $rubygems_package = 'ruby'
        }

        default: {
          $rubygems_package = 'rubygems'
        }
      }
    }
    default: {
      fail("Unsupported OS family: ${::osfamily}")
    }
  }

  $ruby_environment_file = '/etc/profile.d/ruby.sh'
  $gemrc                 = '/etc/gemrc'
}
