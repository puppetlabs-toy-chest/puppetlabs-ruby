# ## Class: ruby::params ##
#
# This class handles the Ruby module parameters
#
# ### Parameters: ###
#
# $ruby_dev = the name of the Ruby development libraries
#
#
class ruby::params {

  $version      = 'installed'
  $gems_version = 'installed'
  $ruby_package = 'ruby'

  case $::osfamily {
    'redhat': {
      $ruby_dev         = 'ruby-devel'
      $rubygems_update  = false
    }
    'debian': {
      $ruby_dev         = [ 'ruby-dev',
                            'rake',
                            'irb',
                          ]
      $rubygems_update  = false
    }
    default: {
      fail("Supported OS families are RedHat and Debian and detected osfamily is <${::osfamily}>.")
    }
  }
}
