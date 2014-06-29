# Class: ruby::params
#
# This class handles the Ruby module parameters
#
class ruby::params {
  $version              = 'installed'
  $gems_version         = 'installed'
  $ruby_switch_package  = 'ruby-switch'

  case $::osfamily {
    'redhat', 'amazon': {
      $ruby_dev         = ['ruby-devel','rubygems-bundler']
      $rubygems_update  = true
      $ruby_package     = 'ruby'
      $rubygems_package = 'rubygems'
    }
    'debian': {
      $rubygems_update = false
      case $::operatingsystemrelease {
        '14.04': {
          #Ubuntu 14.04 changed ruby/rubygems to be all in one package. Specifying these as defaults will permit the module to behave as anticipated.
          $ruby_package     = 'ruby1.9.1'
          $rubygems_package = 'ruby1.9.1-full'
          $ruby_dev         = [ 'ruby-dev', 'rake', 'ri', 'ruby-bundler', 'pkg-config' ]
        }
        '12.04': {
          #Ubuntu 12.04 has a ruby-bundler package available but debian does not
          $ruby_package     = 'ruby'
          $rubygems_package = 'rubygems'
          $ruby_dev         = [ 'ruby-dev', 'rake', 'ri', 'ruby-bundler', 'pkg-config' ]
        }
        default: {
          $ruby_package     = 'ruby'
          $rubygems_package = 'rubygems'
          $ruby_dev         = [ 'ruby-dev', 'rake', 'ri', 'pkg-config' ]
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
