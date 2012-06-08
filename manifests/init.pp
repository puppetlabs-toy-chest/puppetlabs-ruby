# Class: ruby
#
# This class installs Ruby
#
# Parameters:
#
# Actions:
#   - Install Ruby
#   - Install Ruby Gems
#
# Requires:
#
# Sample Usage:
#
class ruby {
  include ruby::params

  package{'ruby': 
     ensure => installed,
  }
  package{'rubygems': 
     ensure => installed, 
     require => Package['ruby'],
  }
}
