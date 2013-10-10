# == Class: ruby
#
# This class installs Ruby and manages rubygems
#
# Parameters:
#
#  version: (default installed)
#    Set the version of Ruby to install
#
#  gems_version: (default installed)
#    Set the version of Rubygems to be installed
#
#  rubygems_update: (default true)
#    If set to true, the module will ensure that the rubygems package is
#    installed but will use rubygems-update (same as gem update --system
#    but versionable) to update Rubygems to the version defined in
#    $gems_version. If set to false then the rubygems package resource
#    will be versioned from $gems_version
#
#  ruby_package: (default ruby)
#    Set the package name for ruby
#
#  rubygems_package: (default rubygems)
#    Set the package name for rubygems
#
# Actions:
#   - Install Ruby
#   - Install Rubygems
#   - Update Rubygems
#
# Requires:
#
# Sample Usage:
#
#  For a standard install using the latest Rubygems provided by
#  rubygems-update on Redhat use:
#
#    class { 'ruby':
#      gems_version  => 'latest',
#    }
#
#  On Redhat this is equivilant to
#    $ yum install ruby rubygems
#    $ gem update --system
#
#  To install a specific version of ruby and rubygems
#  but *not* use rubygems-update use:
#
#    class { 'ruby':
#      version         => '1.8.7',
#      gems_version    => '1.8.24',
#      rubygems_update => false,
#    }
#
#  On Redhat this is equivalent to
#    $ yum install ruby-1.8.7 rubygems-1.8.24
#
#  If you need to use different packages for either ruby or rubygems you
#  can. This could be for different versions or custom packages. For instance
#  the following installs ruby 1.9 on Ubuntu 12.04.
#
#    class { 'ruby':
#      ruby_package     => 'ruby1.9.1-full',
#      rubygems_package => 'rubygems1.9.1',
#      gems_version     => 'latest',
#    }
#
class ruby (
  $version          = 'installed',
  $gems_version     = 'installed',
  $ruby_package     = 'ruby',
  $rubygems_package = 'rubygems',
  $rubygems_update  = 'USE_DEFAULTS',
  $ruby_dev         = 'USE_DEFAULTS',
) {

  case $::osfamily {
    'redhat': {
      $default_ruby_dev        = 'ruby-devel'
      $default_rubygems_update = true
    }
    'debian': {
      $default_ruby_dev        = [ 'ruby-dev',
                                    'rake',
                                    'ri' ]
      $default_rubygems_update = false
    }
    default: {
      fail("Ruby module support OS families 'RedHat' and 'Debian'. Detected osfamily is <${::osfamily}>.")
    }
  }

  if $rubygems_update == 'USE_DEFAULTS' {
    $rubygems_update_real = $default_rubygems_update
  } else {
    $rubygems_update_real = $rubygems_update
  }

  if $ruby_dev == 'USE_DEFAULTS' {
    $ruby_dev_real = $default_ruby_dev
  } else {
    $ruby_dev_real = $ruby_dev
  }

  package { 'ruby':
    ensure => $version,
    name   => $ruby_package,
  }

  # if rubygems_update is set to true then we only need to make the package
  # resource for rubygems ensure to installed, we'll let rubygems-update
  # take care of the versioning.

  if $rubygems_update_real == true {
    $rubygems_ensure = 'installed'
  } else {
    $rubygems_ensure = $gems_version
  }

  package { 'rubygems':
    ensure  => $rubygems_ensure,
    name    => $rubygems_package,
    require => Package['ruby'],
  }

  if $rubygems_update_real {
    package { 'rubygems-update':
      ensure    => $gems_version,
      provider  => 'gem',
      require   => Package['rubygems'],
    }

    exec { 'ruby::update_rubygems':
      path        => '/usr/local/bin:/usr/bin:/bin',
      command     => 'update_rubygems',
      refreshonly => true,
      subscribe   => Package['rubygems-update'],
    }
  }
}
