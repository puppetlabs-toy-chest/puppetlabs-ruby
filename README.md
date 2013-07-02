# Ruby Module

This module manages Ruby and Rubygems on Debian and Redhat based systems.

## Parameters

* version: (default installed) -
 Set the version of Ruby to install

* gems_version: (default installed) -
 Set the version of Rubygems to be installed

* rubygems_update: (default true) -
 If set to true, the module will ensure that the rubygems package is installed
but will use rubygems-update (same as gem update --system but versionable) to
update Rubygems to the version defined in $gems_version.  If set to false then
the rubygems package resource will be versioned from $gems_version

* ruby_package: (default ruby) -
 Set the package name for ruby

* rubygems_package: (default rubygems) -
 Set the package name for rubygems

## Usage

For a standard install using the latest Rubygems provided by rubygems-update on
CentOS or Redhat use:

    class { 'ruby':
      gems_version  => 'latest'
    }

On Redhat this is equivilant to

    $ yum install ruby rubygems
    $ gem update --system

To install a specific version of ruby and rubygems but *not* use
rubygems-update use:

    class { 'ruby':
      version         => '1.8.7',
      gems_version    => '1.8.24',
      rubygems_update => false
    }

On Redhat this is equivilant to

    $ yum install ruby-1.8.7 rubygems-1.8.24

If you need to use different packages for either ruby or rubygems you
can. This could be for different versions or custom packages. For
instance the following installs ruby 1.9 on Ubuntu 12.04.

    class { 'ruby':
      ruby_package     => 'ruby1.9.1-full',
      rubygems_package => 'rubygems1.9.1',
      gems_version     => 'latest',
    }

