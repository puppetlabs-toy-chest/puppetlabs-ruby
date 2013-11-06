# Class: ruby::params
#
# This class handles the Ruby module parameters
#
class ruby::params {
  $version          = 'installed'
  $gems_version     = 'installed'

  # Gentoo specific
  $ruby_gentoo_keywords = ''
  $ruby_gentoo_use      = ''
  $gems_gentoo_keywords = ''
  $gems_gentoo_use      = ''

  case $::osfamily {
    'redhat', 'amazon': {
      $ruby_package     = 'ruby'
      $rubygems_package = 'rubygems'
      $ruby_dev         = 'ruby-devel'
      $rubygems_update  = true
    }
    'debian': {
      $ruby_package     = 'ruby'
      $rubygems_package = 'rubygems'
      $ruby_dev         = [ 'ruby-dev', 'rake', 'ri' ]
      $rubygems_update  = false
    }
    'gentoo': {
      $ruby_package     = 'dev-lang/ruby'
      $rubygems_package = 'dev-ruby/rubygems'
      $ruby_dev         = [ 'dev-ruby/rdoc', 'dev-ruby/rake' ]
      $rubygems_update  = false
    }
    default: {
      fail("Unsupported OS family: ${::osfamily}")
    }
  }

}
