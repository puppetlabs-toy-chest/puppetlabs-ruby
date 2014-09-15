# Class: ruby::params
#
# This class handles the Ruby module parameters
#
class ruby::params {
  $version              = 'installed'
  $gems_version         = 'installed'
  $ruby_switch_package  = 'ruby-switch'
  $rails_env            = 'production'
  $minimum_path         = ['/usr/bin', '/bin', '/usr/sbin', '/sbin', '/usr/local/bin']

  case $::osfamily {
    'redhat', 'amazon': {
      $ruby_package     = 'ruby'
      $rubygems_package = 'rubygems'
      $ruby_dev         = 'ruby-devel'
      $rubygems_update  = true
      $rake_package     = 'rubygem-rake'
      $bundler_package  = 'bundler'
      $bundler_provider = 'gem'
    }
    'debian': {
      $ruby_dev         = [
        'ruby-dev',
        'ri',
        'pkg-config'
      ]
      $rake_package     = 'rake'
      $bundler_package  = 'bundler'
      $bundler_provider = 'apt'
      $rubygems_update  = false
      $ruby_gem_base    = '/usr/bin/gem'
      $ruby_bin_base    = '/usr/bin/ruby'
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
