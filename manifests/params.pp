# Class: ruby::params
#
# This class handles the Ruby module parameters
#
class ruby::params {
  $version              = 'installed'
  $gems_version         = 'installed'
  $ruby_switch_package  = 'ruby-switch'

  case $::osfamily {
    'RedHat', 'Amazon': {
      $ruby_dev             = ['ruby-devel', 'rubygem-rake', 'ruby-rdoc', 'ruby-irb', 'ruby-ri']
      $ruby_dev_gems        = ['bundler', 'rubygems-bundler']
      $rubygems_update      = true
      $ruby_package         = 'ruby'
      $rubygems_package     = 'rubygems'
    }
    'Debian': {
      $ruby_dev             = [ 'ruby-dev', 'rake', 'ri', 'ruby-bundler', 'pkg-config' ]
      $rubygems_update      = false
      $ruby_bin_base        = '/usr/bin/ruby'
      $ruby_gem_base        = '/usr/bin/gem'
      $gem_integration_package = 'rubygems-integration'
      case $::operatingsystemrelease {
        '14.04': {
          #Ubuntu 14.04 changed ruby/rubygems to be all in one package. Specifying these as defaults will permit the module to behave as anticipated.
          $ruby_package     = 'ruby'
          $rubygems_package = 'ruby1.9.1-full'
        }
        default: {
          $ruby_package     = 'ruby'
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
